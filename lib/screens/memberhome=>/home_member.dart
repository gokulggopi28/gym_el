import 'package:flutter/material.dart';
import 'package:gym_el/bottom_navigation.dart';
import 'package:gym_el/provider/auth_provider.dart';
import 'package:gym_el/screens/memberhome=%3E/member_home.dart';
import 'package:gym_el/screens/memberhome=%3E/membership_details.dart';
import 'package:gym_el/screens/memberhome=%3E/mycarousal.dart';
import 'package:gym_el/screens/welcome_screen.dart';
import 'package:provider/provider.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class HomeMemberPage extends StatelessWidget {
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QrScannerOverlayShape overlay = QrScannerOverlayShape();
  int activeIndex = 0;
  @override
  Widget build(BuildContext context) {
    final ap = Provider.of<AuthProvider>(context, listen: true);
    return Scaffold(
      bottomNavigationBar: const HomeBottomNavigation(),
      appBar: AppBar(
        backgroundColor: Colors.blue[500],
        elevation: 0,
        title: const Text("Homescreen"),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.more_horiz),
            onPressed: () {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => MemberHome()), (route) => false);
            },
          ),
        ],
      ),
      body: Container(
        constraints: BoxConstraints.expand(),
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
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Search for products...',
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              Container(
                height: 200.0,

                    child: Container(
                      width: 200.0,
                      margin: EdgeInsets.symmetric(horizontal: 8.0),
                      color: Colors.blue,
                      child: Center(
                        child: MyCarousel(),
                      ),


                ),
              ),
              SizedBox(height: 16.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  'Categories',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                itemCount: 6,
                itemBuilder: (context, index) {
                  return Card(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.category),
                        SizedBox(height: 8.0),
                        Text(
                          'Category ${index + 1}',
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        ElevatedButton(onPressed: () {}, child: Text('Product Store')),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
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
                  backgroundColor: Theme.of(context).platform == TargetPlatform.iOS
                      ? Colors.blue
                      : Colors.white,
                  backgroundImage: NetworkImage(ap.userModel.profilePic),
                  child: Text(
                    "",
                    style: TextStyle(fontSize: 40.0),
                  ),
                ),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    stops: [0.0, 1.0],
                    colors: [Color(0xff378ad6), Color(0xff2a288a)],
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
                  "Membership Details",
                  style: TextStyle(color: Colors.white),
                ),
                trailing: Icon(Icons.arrow_forward_ios),
                onTap: () {
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => Membership_details()), (route) => false);
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
                onTap: () {},
              ),
              ListTile(
                leading: Icon(Icons.grid_3x3_outlined),
                title: Text(
                  "New Products",
                  style: TextStyle(color: Colors.white),
                ),
                trailing: Icon(Icons.arrow_forward_ios),
                onTap: () {},
              ),
              ListTile(
                leading: Icon(Icons.qr_code),
                title: Text(
                  "Attendance Scanner",
                  style: TextStyle(color: Colors.white),
                ),
                trailing: Icon(Icons.arrow_forward_ios),
                onTap: () {},
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
                      MaterialPageRoute(builder: (context) => HomeMemberPage()), (route) => false);
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
                        (value) => Navigator.push(
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
    );
  }
}
