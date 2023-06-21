import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gym_el/provider/cart.dart';
import 'package:gym_el/provider/orders.dart';
import 'package:gym_el/provider/products.dart';
import 'package:gym_el/screens/AdminHome/admin_home.dart';
import 'package:gym_el/screens/memberhome=%3E/cartScreen.dart';
import 'package:gym_el/screens/memberhome=%3E/edit_product_screen.dart';
import 'package:gym_el/screens/memberhome=%3E/home_member.dart';
import 'package:gym_el/provider/auth_provider.dart';
import 'package:gym_el/screens/member_login.dart';
import 'package:gym_el/member_otp.dart';
import 'package:gym_el/screens/memberhome=%3E/orders_screen.dart';
import 'package:gym_el/screens/memberhome=%3E/product_detail_screen.dart';
import 'package:gym_el/screens/memberhome=%3E/user_product_screen.dart';
import 'package:gym_el/screens/welcome_screen.dart';
import 'package:gym_el/splash.dart';
import 'package:gym_el/widget/member_drawer.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

const SAVE_KEY_NAME = 'User logged in';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => Products()),
        ChangeNotifierProvider(create: (_) => Cart()),
        ChangeNotifierProvider(create: (_) => Orders())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Gym_Elite',
        initialRoute: 'splash',
        routes: {
          ProductDetailScreen.routeName: (ctx) => const ProductDetailScreen(),
          CartScreen.routeName: (ctx) => const CartScreen(),
          OrdersScreen.routeName: (ctx) => const OrdersScreen(),
          UserProductsScreen.routeName: (ctx) => const UserProductsScreen(),
          EditProductScreen.routeName: (ctx) => const EditProductScreen(),
          'splash': (context) => ScreenSplash(),
          'login': (context) => MemberLogin(),
          //'otp': (context) => M,
          'admin_home': (context) => ScreenHome(),
        },
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: ScreenSplash(),
      ),
    );
  }
}

class MyAppStatefulWidget extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyAppStatefulWidget> {
  bool isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    initSharedPrefs();
  }

  void initSharedPrefs() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.remove('isLoggedIn');
    isLoggedIn = preferences.getBool('isLoggedIn') ?? false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Gym',
        home: isLoggedIn?  HomeMemberPage() : const WelcomeScreen() ); // MaterialApp
  }
}
