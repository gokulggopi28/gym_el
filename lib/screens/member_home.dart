import 'package:flutter/material.dart';
import 'package:gym_el/bottom_navigation.dart';
import 'package:gym_el/provider/auth_provider.dart';
import 'package:gym_el/screens/welcome_screen.dart';
import 'package:gym_el/widget/member_drawer.dart';
import 'package:provider/provider.dart';

class memberhome extends StatefulWidget {
  const memberhome({Key? key}) : super(key: key);

  @override
  State<memberhome> createState() => _memberhomeState();
}

class _memberhomeState extends State<memberhome> {
  @override
  Widget build(BuildContext context) {
    final ap = Provider.of<AuthProvider>(context, listen: false);
    return Scaffold(
      bottomNavigationBar: const HomeBottomNavigation(),
      appBar: AppBar(
        backgroundColor: Colors.green[400],
        elevation: 0,
        title: const Text("Homescreen"),
        actions: [
          IconButton(
            onPressed: () {
              ap.userSignOut().then((value) => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const WelcomeScreen(),
                ),
              ));
            },
            icon: const Icon(Icons.exit_to_app),
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: [0.0, 1.0],
            colors: [Color(0xff378ad6), Color(0xff2a288a)],
          ),
        ),
        child: Center(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.center,
            // children: [
            //   CircleAvatar(
            //     backgroundColor: Colors.blue,
            //     backgroundImage: NetworkImage(ap.userModel.profilePic),
            //     radius: 50,
            //   ),
            //   const SizedBox(height: 20),
            //   Text(ap.userModel.name),
            //   Text(ap.userModel.phoneNumber),
            //   Text(ap.userModel.email),
            //   Text(ap.userModel.bio),
            // ],
          ),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text(ap.userModel.name),
              accountEmail: Text(ap.userModel.email),
              currentAccountPicture: CircleAvatar(
                backgroundColor:
                Theme.of(context).platform == TargetPlatform.iOS
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
              title: Text("Home"),
              trailing: Icon(Icons.arrow_forward),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.account_box),
              title: Text("About"),
              trailing: Icon(Icons.arrow_forward),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.money_rounded),
              title: Text("Payment"),
              trailing: Icon(Icons.arrow_forward),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.grid_3x3_outlined),
              title: Text("New Products"),
              trailing: Icon(Icons.arrow_forward),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.qr_code),
              title: Text("Attendance Scanner"),
              trailing: Icon(Icons.arrow_forward),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text("Settings"),
              trailing: Icon(Icons.arrow_forward),
              onTap: () {},
            ),

          ],
        ),
      ),
    );
  }
}
