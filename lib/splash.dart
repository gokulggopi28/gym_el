
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:gym_el/choose.dart';
import 'package:shared_preferences/shared_preferences.dart';



import 'main.dart';

class ScreenSplash extends StatefulWidget {
  const ScreenSplash({Key? key}) : super(key: key);

  @override
  State<ScreenSplash> createState() => _ScreenSplashState();
}

class _ScreenSplashState extends State<ScreenSplash> {
  @override
  void initState() {
    super.initState();
    checkUsedLoggedIn();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width, // Set width to full screen width
      height: MediaQuery.of(context).size.height, // Set height to full screen height
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          stops: [0.0, 1.0], // Add stops for smooth transition
          colors: [Color(0xff378ad6), Color(0xff2a288a)],
        ),
      ),
      child: AnimatedSplashScreen(
        splash: Center(
          child: Image.asset('assets/images/gymc.png',),
        ),
        nextScreen: ChoosePage(), // Navigate to ChoosePage after the splash screen
        splashTransition: SplashTransition.sizeTransition,
        backgroundColor: Colors.transparent, // Set the background color to transparent
        duration: 3000,
        // nextScreen: FutureBuilder(
        //   future: checkUsedLoggedIn(),
        //   builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        //     if (snapshot.connectionState == ConnectionState.waiting) {
        //       return Container(); // Replace with your desired loading indicator
        //     } else {
        //       final userLoggedIn = snapshot.data;
        //       if (userLoggedIn == null || !userLoggedIn) {
        //         return ScreenLogin();
        //       } else {
        //         return ScreenHome();
        //       }
        //     }
        //   },
        // ),

      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<bool> checkUsedLoggedIn() async {
    final _sharedPrefs = await SharedPreferences.getInstance();
    final _userLoggedIn = _sharedPrefs.getBool(SAVE_KEY_NAME);
    if (_userLoggedIn == null || _userLoggedIn == false) {
      return false;
    } else {
      return true;
    }
  }
}
