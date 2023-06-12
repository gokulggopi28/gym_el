import 'package:flutter/material.dart';
import 'package:gym_el/bottom_navigation.dart';
import 'package:gym_el/provider/auth_provider.dart';
import 'package:gym_el/screens/memberhome=%3E/member_home.dart';
import 'package:gym_el/screens/welcome_screen.dart';
import 'package:provider/provider.dart';

class Membership_details extends StatelessWidget {
  const Membership_details({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ap = Provider.of<AuthProvider>(context, listen: false);
    return Scaffold(
      bottomNavigationBar: const HomeBottomNavigation(),
      appBar: AppBar(
        backgroundColor: Colors.blue[500],
        elevation: 0,
        title: const Text("Membership Details"),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {},
          ),
          IconButton(
            onPressed: () {
              ap.userSignOut().then(
                    (value) => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MemberHome(),
                  ),
                ),
              );
            },
            icon: const Icon(Icons.exit_to_app),
          ),
        ],
      ),
      body: Container(
        constraints: BoxConstraints.expand(), // Expand to fill the available space
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: [0.0, 1.0],
            colors: [Color(0xff378ad6), Color(0xff2a288a)],
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Column(
                  children: [
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            backgroundColor: Theme.of(context).platform == TargetPlatform.iOS
                                ? Colors.blue
                                : Colors.white,
                            backgroundImage: NetworkImage(ap.userModel.profilePic),
                            radius: 100,
                          ),
                          SizedBox(height: 50),
                          Text(
                            ap.userModel.name,
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                          Text(
                            ap.userModel.email,
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                          Text("Id: "+
                            ap.userModel.createdAt,
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                          Text("Phone: "+
                              ap.userModel.phoneNumber,
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                          Text("Bio: "+
                              ap.userModel.bio,
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),

                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
