import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gym_el/member_home.dart';
import 'package:gym_el/screens/member_login.dart';
import 'package:gym_el/member_otp.dart';
import 'package:gym_el/splash.dart';
import 'package:firebase_auth/firebase_auth.dart';


const SAVE_KEY_NAME = 'User logged in';

Future<void> main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Gym_Elite',
      initialRoute: 'splash',
      routes: {
        'splash': (context) => ScreenSplash(),
        'login': (context) =>MemberLogin(),
        'otp': (context) => MyOtp(),
        'home': (context) => memberhome(),
      },
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ScreenSplash(),
    );
  }
}

