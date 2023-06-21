import 'dart:io';
import 'package:firebase_core/firebase_core.dart';

class DefaultFirebaseConfig {
  static FirebaseOptions get platformOptions {
    if (Platform.isAndroid) {
      return FirebaseOptions(
        appId: '1:317230014541:android:9eecc623fd381e19f43c04',
        apiKey: 'AIzaSyB1HPm9CkXSS-Dq6G3WiOyNYuwf0FrUjRU',
        projectId: 'gymelite-53198',
        messagingSenderId: '317230014541',
      );
    } else {
      return FirebaseOptions(
        appId: '',
        apiKey: '',
        projectId: '',
        messagingSenderId: '',
      );
    }
  }
}
