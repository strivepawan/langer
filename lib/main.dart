// import 'dart:io';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:langer/Register/SignupPage.dart';
// import 'package:langer/Register/login_page.dart';
// import 'package:langer/WelcomeScreen/HomePage.dart';

// import 'package:shared_preferences/shared_preferences.dart';


// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();

//   // Initialize Firebase for Android
//   if (Platform.isAndroid) {
//     await Firebase.initializeApp(
//     options: const FirebaseOptions(
//     apiKey: 'AIzaSyDP9vk4rBYwIAZeAI1aaysJo7EFchJtJx0',
//     appId: '1:659247485127:android:46eb86edb30c572f93aee2',
//     messagingSenderId: '659247485127',
//     projectId: 'langer-1d13b',
//     storageBucket: 'langer-1d13b.appspot.com',
//       ),
//     );
//   } 
//   // Initialize Firebase for iOS
//   else if (Platform.isIOS) {
//     await Firebase.initializeApp(
//       options: const FirebaseOptions(
//     apiKey: 'AIzaSyDzFFK3FSVG2NOTfmf43xUhnGiNDRnqBRo',
//     appId: '1:659247485127:ios:db5b432d0ce146b793aee2',
//     messagingSenderId: '659247485127',
//     projectId: 'langer-1d13b',
//     storageBucket: 'langer-1d13b.appspot.com',
//     iosBundleId: 'com.example.langer',
//       ),
//     );
//   }

//   // Check if the user has already signed up
//   final prefs = await SharedPreferences.getInstance();
//   final bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

//   runApp(MyApp(isLoggedIn: isLoggedIn));
// }

// class MyApp extends StatelessWidget {
//   final bool isLoggedIn;

//   const MyApp({Key? key, required this.isLoggedIn}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Login & Signup',
//       debugShowCheckedModeBanner: false,
//       home: isLoggedIn ? HomePage() : SignupPage(), // Show HomePage if logged in, otherwise show SignupPage
//       routes: {
//         '/login': (context) => LoginPage(),
//         '/signup': (context) => SignupPage(),
//         '/home': (context) => HomePage(), // Replace with your home page widget
//       },
//     );
//   }
// }


import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:langer/Register/SignupPage.dart';
import 'package:langer/Register/login_page.dart';
import 'package:langer/WelcomeScreen/HomePage.dart';
import 'package:langer/postLanger/postLanger.dart';
import 'package:langer/ueseProfile/userProfile.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

   if (Platform.isAndroid) {
    await Firebase.initializeApp(
    options: const FirebaseOptions(
    apiKey: 'AIzaSyDP9vk4rBYwIAZeAI1aaysJo7EFchJtJx0',
    appId: '1:659247485127:android:46eb86edb30c572f93aee2',
    messagingSenderId: '659247485127',
    projectId: 'langer-1d13b',
    storageBucket: 'langer-1d13b.appspot.com',
      ),
    );
  } 
  // Initialize Firebase for iOS
  else if (Platform.isIOS) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
    apiKey: 'AIzaSyDzFFK3FSVG2NOTfmf43xUhnGiNDRnqBRo',
    appId: '1:659247485127:ios:db5b432d0ce146b793aee2',
    messagingSenderId: '659247485127',
    projectId: 'langer-1d13b',
    storageBucket: 'langer-1d13b.appspot.com',
    iosBundleId: 'com.example.langer',
      ),
    );
  }

  // Request permissions before initializing Firebase
  await _requestPermissions();

  // Initialize Firebase
  await Firebase.initializeApp();

  // Check if the user has already signed up
  final prefs = await SharedPreferences.getInstance();
  final bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

  runApp(MyApp(isLoggedIn: isLoggedIn));
}

Future<void> _requestPermissions() async {
  if (Platform.isAndroid || Platform.isIOS) {
    // Request location permission
    await Permission.location.request();
  }
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;

  const MyApp({Key? key, required this.isLoggedIn}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login & Signup',
      debugShowCheckedModeBanner: false,
      home: isLoggedIn ? HomePage() : SignupPage(), // Show HomePage if logged in, otherwise show SignupPage
      routes: {
        '/login': (context) => LoginPage(),
        '/signup': (context) => SignupPage(),
        '/home': (context) =>const HomePage(),
        '/upload_post': (context) => PostLangerPage(), // Add route for UploadPostPage
        '/user_account': (context) => CustomDrawer(), // Replace with your home page widget
      },
    );
  }
}
