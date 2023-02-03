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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyDreZhE-E77pXTXgdYGSfALmHmXrH9e2LI',
    appId: '1:1091291136480:web:4e1e07ed8646cd40aa6b85',
    messagingSenderId: '1091291136480',
    projectId: 'fir-purchases',
    authDomain: 'fir-purchases.firebaseapp.com',
    storageBucket: 'fir-purchases.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBM_2CCwgfLhQnyevq1CDVNQp9X-jAQwI4',
    appId: '1:1091291136480:android:c8a4d5f51af7939faa6b85',
    messagingSenderId: '1091291136480',
    projectId: 'fir-purchases',
    storageBucket: 'fir-purchases.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDeGfDiQ7S9_COrYrdlF8sMdFfyimfd8iE',
    appId: '1:1091291136480:ios:82563d40be409a32aa6b85',
    messagingSenderId: '1091291136480',
    projectId: 'fir-purchases',
    storageBucket: 'fir-purchases.appspot.com',
    iosClientId: '1091291136480-tdhqskfu70ek6ifj84obc5p4b0n6j5ef.apps.googleusercontent.com',
    iosBundleId: 'com.example.firebasePurchase',
  );
}
