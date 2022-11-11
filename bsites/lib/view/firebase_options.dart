// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyDIbB18dRIS7q1_W0ZpDDn0hFQXawGDE1s',
    appId: '1:879646947146:web:d6c14ef1cf35ce5d7b73b3',
    messagingSenderId: '879646947146',
    projectId: 'bsite-80ada',
    authDomain: 'bsite-80ada.firebaseapp.com',
    databaseURL: 'https://bsite-80ada-default-rtdb.firebaseio.com',
    storageBucket: 'bsite-80ada.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAmVFLUi2HESGFCWUueJ1DOhzlMaKzJdG8',
    appId: '1:879646947146:android:42760c00de514d637b73b3',
    messagingSenderId: '879646947146',
    projectId: 'bsite-80ada',
    databaseURL: 'https://bsite-80ada-default-rtdb.firebaseio.com',
    storageBucket: 'bsite-80ada.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBg0bJC2UftDRoTS8DyxfU_ebPvxf1oPEE',
    appId: '1:879646947146:ios:aad7edc403f963047b73b3',
    messagingSenderId: '879646947146',
    projectId: 'bsite-80ada',
    databaseURL: 'https://bsite-80ada-default-rtdb.firebaseio.com',
    storageBucket: 'bsite-80ada.appspot.com',
    androidClientId: '879646947146-62mk8kmu9kofemeu1899vm6ahfrlrta7.apps.googleusercontent.com',
    iosClientId: '879646947146-66la2al0qpodnv0bo7tc2ld1ghefudph.apps.googleusercontent.com',
    iosBundleId: 'com.example.bsites',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBg0bJC2UftDRoTS8DyxfU_ebPvxf1oPEE',
    appId: '1:879646947146:ios:aad7edc403f963047b73b3',
    messagingSenderId: '879646947146',
    projectId: 'bsite-80ada',
    databaseURL: 'https://bsite-80ada-default-rtdb.firebaseio.com',
    storageBucket: 'bsite-80ada.appspot.com',
    androidClientId: '879646947146-62mk8kmu9kofemeu1899vm6ahfrlrta7.apps.googleusercontent.com',
    iosClientId: '879646947146-66la2al0qpodnv0bo7tc2ld1ghefudph.apps.googleusercontent.com',
    iosBundleId: 'com.example.bsites',
  );
}