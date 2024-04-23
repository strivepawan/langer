import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:langer/WelcomeScreen/location_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String currentCity = 'Loading...';
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _fetchCity(); // Fetch location on app launch
  }

  Future<void> _fetchCity() async {
    final city = await LocationService.getCurrentCity();
    setState(() {
      currentCity = city;
    });
  }
  Future<String> _fetchUserName() async {
  // Simulate fetching username from backend (replace with actual backend call)
  await Future.delayed(Duration(seconds: 2)); // Simulating delay

  // Return the fetched username
  return 'Pawan'; // Replace with the actual fetched username
}


  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    switch (index) {
      case 1:
        Navigator.pushNamed(context, '/upload_post');
        break;
      case 2:
        Navigator.pushNamed(context, '/user_account');
        break;
      default:
    }
  }

  @override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Langer',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(currentCity),
        ],
      ),
    ),
    body: SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FutureBuilder<String>(
              future: _fetchUserName(), // Fetch username from backend
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator(); // Show loading indicator while fetching username
                }
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }
                return Text(
                  'Hey ${snapshot.data}',
                  style: TextStyle(fontSize: 24.0),
                );
              },
            ),
            SizedBox(height: 10.0),
            Text(
              'Looking for Langer and Bhandra around you',
              style: TextStyle(fontSize: 18.0),
            ),
            SizedBox(height: 20.0),
           Card(
  child: StreamBuilder<QuerySnapshot>(
    stream: FirebaseFirestore.instance.collection('langer_posts').snapshots(),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const CircularProgressIndicator();
      }
      if (snapshot.hasError) {
        return Text('Error: ${snapshot.error}');
      }
      final posts = snapshot.data!.docs.reversed.toList(); 
      // posts.sort((a, b) => b['timestamp'].compareTo(a['timestamp']));
      return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: posts.length,
        itemBuilder: (context, index) {
          final post = posts[index];
          final data = post.data();
          final Map<String, dynamic> postData = data as Map<String, dynamic>;
          final imageUrl = postData.containsKey('imageUrl') ? postData['imageUrl'] : null;
          return Card(
            // color: Colors.transparent,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 250,
                  child: imageUrl != null
                      ? Image.network(
                          imageUrl,
                          fit: BoxFit.cover,
                        )
                      : Image.asset(
                          'assets/images/upload.jpg',
                          fit: BoxFit.cover,
                        ),
                ),
                const SizedBox(height:6),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Text(postData['userName'] ?? ''),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Text(postData['location'] ?? ''),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Text(postData['deviceTime'] ?? ''),
                        ),
                      ],
                    ),
                    IconButton(
                      icon: const Icon(Icons.navigation, size: 40,),
                      onPressed: () {
                        // Handle navigation to the location
                      },
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      );
    },
  ),
),




          ],
        ),
      ),
    ),
    bottomNavigationBar: BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.upload_file),
          label: 'Upload Post',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.account_circle),
          label: 'User Account',
        ),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: Colors.blue,
      onTap: _onItemTapped,
    ),
  );
}

}
