import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:gym_el/choose.dart';
import 'package:gym_el/main.dart';
import 'package:gym_el/screens/welcome_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          stops: [0.0, 1.0],
          colors: [Color(0xff378ad6), Color(0xff2a288a)],
        ),
      ),
      child: AnimatedSplashScreen(
        splash: Center(
          child: Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: Transform.scale(
              scale: 2.0, // Adjust the scale as desired
              child: Image.asset(
                'assets/images/gymc.png',
              ),
            ),
          ),
        ),
        nextScreen: WelcomeScreen(),
        splashTransition: SplashTransition.scaleTransition,
        backgroundColor: Colors.transparent,
        duration: 3000,
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
