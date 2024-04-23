import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:intl/intl.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Import FirebaseAuth
import 'package:cloud_firestore/cloud_firestore.dart'; // Import Firestore

class PostLangerPage extends StatefulWidget {
  @override
  _PostLangerPageState createState() => _PostLangerPageState();
}

class _PostLangerPageState extends State<PostLangerPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance; // Firebase Authentication instance
  final FirebaseFirestore _firestore = FirebaseFirestore.instance; // Firestore instance

  File? _image;
  TextEditingController _locationController = TextEditingController();

  bool _isUploading = false; // Flag to track whether data is being uploaded

  Future<void> _getImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);

    setState(() {
      _image = pickedFile != null ? File(pickedFile.path) : null;
    });
  }

  Future<void> _fetchLocation() async {
    setState(() {
      _locationController.text = 'Fetching location...'; // Show loading text
    });

    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      // Fetch the address using the obtained position
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      // Construct the address string
      String address = '${placemarks[0].subLocality}, ${placemarks[0].locality}';

      // Update the location text field with the fetched address
      setState(() {
        _locationController.text = address;
      });
    } catch (e) {
      // Handle error if any
      print('Error fetching location: $e');
      setState(() {
        _locationController.text = 'Error fetching location';
      });
    }
  }

  Future<void> _postLanger() async {
    try {
      setState(() {
        _isUploading = true; // Set flag to true when starting upload
      });

      // Get the currently logged-in user
      User? user = _auth.currentUser;
      
      // Get the user's name
      String? userName = user?.displayName;

      // Get the data to be posted
      String location = _locationController.text;
      String deviceTime = DateFormat('dd-MM-yyyy HH:mm').format(DateTime.now());

      // Upload the image to Firebase Storage
      String imageUrl = await _uploadImage();

      // Create a new document in the "langer_posts" collection
      await _firestore.collection('langer_posts').add({
        'userName': userName,
        'location': location,
        'deviceTime': deviceTime,
        'imageUrl': imageUrl,
      });

      // Show success message after successful upload
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Langer posted successfully!'),
          duration: Duration(seconds: 2),
        ),
      );
    } catch (e) {
      // Handle error
      print('Error posting langer: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error posting langer. Please try again later.'),
          duration: Duration(seconds: 2),
        ),
      );
    } finally {
      setState(() {
        _isUploading = false; // Reset flag after upload completes
      });
    }
  }

  Future<String> _uploadImage() async {
    try {
      // Get image file from the state
      File? imageFile = _image;

      // Create a reference to the Firebase Storage location
      Reference ref = FirebaseStorage.instance.ref().child('langer_images/${DateTime.now().millisecondsSinceEpoch}');

      // Upload the file to Firebase Storage
      UploadTask uploadTask = ref.putFile(imageFile!);
      
      // Wait for the upload to complete and get the download URL
      TaskSnapshot taskSnapshot = await uploadTask;
      String imageUrl = await taskSnapshot.ref.getDownloadURL();

      return imageUrl;
    } catch (e) {
      // Handle error
      print('Error uploading image: $e');
      throw e; // Rethrow the error
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Post Langer'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Place Name', style: TextStyle(fontSize: 18.0)),
                SizedBox(height: 5.0),
                TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                ),
              ],
            ),
           const SizedBox(height: 20.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      'Location',
                      style: TextStyle(fontSize: 18.0),
                    ),
                    SizedBox(width: 10.0),
                    IconButton(
                      icon: Icon(Icons.location_on),
                      onPressed: _fetchLocation,
                    ),
                  ],
                ),
                SizedBox(height: 5.0),
                TextFormField(
                  controller: _locationController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Device Time',
                  style: TextStyle(fontSize: 16.0),
                ),
                SizedBox(height: 16.0),
                Text(
                  DateFormat('dd-MM-yyyy HH:mm').format(DateTime.now()),
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: 20.0),
            Column(
              children: [
                _image == null
                    ? ElevatedButton(
                        onPressed: _getImage,
                        child: Image.asset(
                          'assets/images/upload.jpg',
                          height: 200.0,
                          width: 200.0,
                        ),
                      )
                    : Image.file(_image!),
              ],
            ),
            SizedBox(height: 20.0),
            Column(
              children: [
                // Show loading indicator if data is being uploaded
                if (_isUploading)
                  CircularProgressIndicator()
                else
                  ElevatedButton(
                    onPressed: _postLanger,
                    child: Text('Post Langer', style: TextStyle(fontSize: 18.0)),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
