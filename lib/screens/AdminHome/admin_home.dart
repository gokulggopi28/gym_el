import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gym_el/provider/auth_provider.dart';
import 'package:gym_el/screens/AdminHome/Attendance_list_page.dart';
import 'package:gym_el/screens/AdminHome/Payment/qr_pay.dart';
import 'package:gym_el/screens/AdminHome/User_list_view.dart';
import 'package:gym_el/screens/AdminHome/new_reg.dart';
import 'package:gym_el/screens/memberhome=%3E/orders_screen.dart';
import 'package:gym_el/screens/memberhome=%3E/user_product_screen.dart';
import 'package:gym_el/screens/welcome_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ScreenHome extends StatefulWidget {


  const ScreenHome({Key? key}) : super(key: key);

  static ValueNotifier<int> selectedIndexNotifier = ValueNotifier(0);

  @override
  State<ScreenHome> createState() => _ScreenHomeState();
}

class _ScreenHomeState extends State<ScreenHome> {
  int _selectedIndex = 0;



  @override
  Widget build(BuildContext context) {
    final DateTime createdAt;
    final ap = Provider.of<AuthProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome, Possessor'),
        actions: [
          IconButton(
            onPressed: () {
              signOut(context);
            },
            icon: const Icon(Icons.exit_to_app),
          )
        ],
      ),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.blue,
        color: Colors.white,
        items: <Widget>[
          Icon(Icons.home, color: Colors.blue),
          Icon(Icons.people, color: Colors.blue),
          Icon(Icons.settings, color: Colors.blue),
        ],
        onTap: (int index) {
          switch (index) {
            case 0:
            // Home icon tapped
            // Implement your logic here
              break;
            case 1:
            // People icon tapped
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => UserListView()),
                    (route) => true,
              );
              break;
            case 2:
            // Settings icon tapped
            // Implement your logic here
              break;
          }
        },
      ),
      drawer: Drawer(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              stops: [0.0, 1.0],
              colors: [Color(0xff378ad6), Color(0xff2a288a)],
            ),
          ),
          child: Column(
            children: <Widget>[
              UserAccountsDrawerHeader(
                accountName: Text(ap.userModel.name),
                accountEmail: Text(ap.userModel.email),
                currentAccountPicture: CircleAvatar(
                  backgroundColor:
                  Theme
                      .of(context)
                      .platform == TargetPlatform.iOS
                      ? Colors.blue
                      : Colors.white,
                  backgroundImage: NetworkImage(ap.userModel.profilePic),
                  child: Text(
                    "",
                    style: TextStyle(fontSize: 40.0),
                  ),
                ),
              ),
              ListTile(
                leading: Icon(Icons.home),
                title: Text(
                  "Home",
                  style: TextStyle(color: Colors.white),
                ),
                trailing: Icon(Icons.arrow_forward_ios),
                onTap: () {},
              ),
              ListTile(
                leading: Icon(Icons.account_box),
                title: Text(
                  "Member List",
                  style: TextStyle(color: Colors.white),
                ),
                trailing: Icon(Icons.arrow_forward_ios),
                onTap: () {
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => UserListView()),
                        (route) => true,
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.verified_user),
                title: Text(
                  "Profile Settings",
                  style: TextStyle(color: Colors.white),
                ),
                trailing: Icon(Icons.arrow_forward_ios),
                onTap: () {},
              ),
              ListTile(
                leading: Icon(Icons.money_rounded),
                title: Text(
                  "Payment",
                  style: TextStyle(color: Colors.white),
                ),
                trailing: Icon(Icons.arrow_forward_ios),
                onTap: () {
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (context) => QRPage(),
                    ),
                        (route) => true,
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.list),
                title: Text(
                  "Attendance List",
                  style: TextStyle(color: Colors.white),
                ),
                trailing: Icon(Icons.arrow_forward_ios),
                onTap: () {
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (context) => AttendanceListPage(),
                    ),
                        (route) => true,
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.file_open),
                title: Text(
                  "Orders",
                  style: TextStyle(color: Colors.white),
                ),
                trailing: Icon(Icons.arrow_forward_ios),
                onTap: () {
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (context) => OrdersScreen(),
                    ),
                        (route) => true,
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.edit),
                title: const Text(
                  'Manage Products',
                  style: TextStyle(color: Colors.white),
                ),
                trailing: Icon(Icons.arrow_forward_ios),
                onTap: () =>
                {
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (context) => UserProductsScreen(),
                    ),
                        (route) => true,
                  )
                },
              ),
              ListTile(
                leading: Icon(Icons.settings),
                title: Text(
                  "Settings",
                  style: TextStyle(color: Colors.white),
                ),
                trailing: Icon(Icons.arrow_forward_ios),
                onTap: () {},
              ),
              ListTile(
                leading: Icon(Icons.logout_outlined),
                title: Text(
                  "Logout",
                  style: TextStyle(color: Colors.white),
                ),
                trailing: Icon(Icons.arrow_forward_ios),
                onTap: () {
                  ap.userSignOut().then(
                        (value) =>
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const WelcomeScreen(),
                          ),
                        ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(0),
            child: Form(
              child: Container(
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                height: MediaQuery
                    .of(context)
                    .size
                    .height,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0xff378ad6), Color(0xff2a288a)],
                  ),
                ),
                child: StreamBuilder<User?>(
                  stream: FirebaseAuth.instance.authStateChanges(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else if (snapshot.hasData) {
                      final user = snapshot.data!;
                      return buildAdminContent(ap); // Pass 'ap' as an argument
                    } else {
                      return Container(); // Replace with the appropriate widget
                    }
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildAdminContent(AuthProvider ap) {
    final currentDate = DateTime.now();
    final today = DateTime(
        currentDate.year, currentDate.month, currentDate.day);
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection(
          'attendance').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasData) {
          final attendanceEntries = snapshot.data!.docs.length;
          final totalEntries = 100;
          final attendanceCount = (attendanceEntries / totalEntries) * 100;


          return Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              CircleAvatar(
                                radius: 40,
                                backgroundImage:
                                NetworkImage(ap.userModel.profilePic),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    ap.userModel.name,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                    ),
                                  ),
                                  Text(
                                    ap.userModel.email,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 30),
                          Text(
                            'Dashboard',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xff2a288a),
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          const SizedBox(
                            height: 30,
                          ),
                          Text(
                            'Attendance',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 10),
                          Container(
                            height: 10,
                            child: LinearProgressIndicator(
                              value: attendanceCount / 100,
                              color: Colors.green,
                              backgroundColor: Colors.grey,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            '$attendanceCount % Attendance',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                            ),
                          ),
                          SizedBox(height: 20),

                          Text(
                            'New Registration',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                        StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('users')
                        .orderBy('createdAt', descending: true)
                        .snapshots(),
                builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  }

                  final currentTime = Timestamp.now();
                  final registeredWithinThreeDaysUsers = snapshot.data!.docs.where((user) {
                    final createdAt = user['createdAt'];
                    if (createdAt is String) {
                      try {
                        final parsedDate = DateTime.parse(createdAt);
                        return currentTime.toDate().difference(parsedDate).inDays <= 3;
                      } catch (e) {
                        print('Invalid date format: $createdAt');
                        return false;
                      }
                    }
                    return false;
                  }).toList();

                  final registrationProgress = registeredWithinThreeDaysUsers.length;

                    LinearProgressIndicator(
                      value: registrationProgress/10,
                      color: Colors.green,
                      backgroundColor: Colors.grey,

                    );


                  return Column(
                    children: [
                      Text(
                        '$registrationProgress Users Registered Within 3 Days',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  );
                },

              )




              ],),
                    ),
                  ),
                ],

              ),
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }

  void signOut(BuildContext context) async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    await FirebaseAuth.instance.signOut();
    await sp.clear();
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => const ScreenHome()),
          (route) => false,
    );
  }
}

