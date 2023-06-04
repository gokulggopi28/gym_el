import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gym_el/admin_home.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';


class ScreenLogin extends StatefulWidget {
  ScreenLogin({Key? key}) : super(key: key);

  @override
  State<ScreenLogin> createState() => _ScreenLoginState();
}

class _ScreenLoginState extends State<ScreenLogin> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isDataMatched = true;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: Text('Admin Login'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(0),
          child: Form(
            key: _formKey,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  transform: GradientRotation(20 *pi/180),
                  colors: [Color(0xff378ad6), Color(0xff2a288a)],
                ),
              ),
              child: Column(
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 35),
                    child: Image.asset(
                      'assets/images/gym_logo.png',
                      height: 140,
                      width: 100,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Container(width: 300,
                    child: TextFormField(
                      controller: _usernameController,
                      decoration:  InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        hintText: 'Username',

                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Value is empty';
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(width: 300,
                    child: TextFormField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        hintText: 'Password',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Value is empty';
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text('Forgot Password?',style: TextStyle(
                      color: Colors.white,fontSize: 16),
                  ),
                  const SizedBox(
                    height: 20,
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Visibility(
                        visible: !_isDataMatched,
                        child: const Text(
                          'Username and Password does not match',
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton.icon(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              checkLogin(context);
                            } else {
                              print('Data empty');
                            }
                          },

                          icon:  Icon(Icons.check),
                          label:  Text('Login'),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.green,
                            onPrimary: Colors.white,
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  10),
                            ),
                            padding: EdgeInsets.symmetric(vertical: 15,horizontal: 50),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void checkLogin(BuildContext ctx) async {
    final _username = _usernameController.text;
    final _password = _passwordController.text;

    if (_username == _password) {
      print('Username and password match');
      // Go to home

      final _sharedPrefs = await SharedPreferences.getInstance();
      await _sharedPrefs.setBool(SAVE_KEY_NAME, true);

      Navigator.of(ctx).pushReplacement(
        MaterialPageRoute(builder: (ctx1) => ScreenHome()),
      );
    } else {
      print('Username and password does not match');
    }
  }
}
