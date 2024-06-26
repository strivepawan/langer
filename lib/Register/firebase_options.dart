// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        return windows;
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyCBnNHqNsa0C31IsFwksxZIgDsojDR3pxQ',
    appId: '1:659247485127:web:daafd71ab658a50293aee2',
    messagingSenderId: '659247485127',
    projectId: 'langer-1d13b',
    authDomain: 'langer-1d13b.firebaseapp.com',
    storageBucket: 'langer-1d13b.appspot.com',
    measurementId: 'G-TB64Z70N18',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDP9vk4rBYwIAZeAI1aaysJo7EFchJtJx0',
    appId: '1:659247485127:android:46eb86edb30c572f93aee2',
    messagingSenderId: '659247485127',
    projectId: 'langer-1d13b',
    storageBucket: 'langer-1d13b.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDzFFK3FSVG2NOTfmf43xUhnGiNDRnqBRo',
    appId: '1:659247485127:ios:db5b432d0ce146b793aee2',
    messagingSenderId: '659247485127',
    projectId: 'langer-1d13b',
    storageBucket: 'langer-1d13b.appspot.com',
    iosBundleId: 'com.example.langer',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDzFFK3FSVG2NOTfmf43xUhnGiNDRnqBRo',
    appId: '1:659247485127:ios:db5b432d0ce146b793aee2',
    messagingSenderId: '659247485127',
    projectId: 'langer-1d13b',
    storageBucket: 'langer-1d13b.appspot.com',
    iosBundleId: 'com.example.langer',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCBnNHqNsa0C31IsFwksxZIgDsojDR3pxQ',
    appId: '1:659247485127:web:026944983269859693aee2',
    messagingSenderId: '659247485127',
    projectId: 'langer-1d13b',
    authDomain: 'langer-1d13b.firebaseapp.com',
    storageBucket: 'langer-1d13b.appspot.com',
    measurementId: 'G-PHZ9MFG411',
  );
}
