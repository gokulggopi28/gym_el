import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:gym_el/bottom_navigation.dart';
import 'package:gym_el/screens/memberhome=%3E/carousel.dart';
import 'package:gym_el/provider/auth_provider.dart';
import 'package:gym_el/screens/welcome_screen.dart';
import 'package:gym_el/widget/member_drawer.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class MemberHome extends StatefulWidget {
  const MemberHome({Key? key}) : super(key: key);

  @override
  State<MemberHome> createState() => _MemberHomeState();
}

class _MemberHomeState extends State<MemberHome> {
  int activeIndex = 0;
  final urlImages = [
    'https://www.shutterstock.com/image-photo/muscular-man-showing-muscles-on-260nw-1686329977.jpg',
    'https://media.istockphoto.com/id/612262390/photo/body-building-workout.jpg?s=612x612&w=0&k=20&c=zsRgRf3tuStA7dN5bdFS_x1ud-XdU-dJC7B6iuq_AZk=',
    'https://media.istockphoto.com/id/479009182/photo/silhouette-of-a-strong-fighter.jpg?s=612x612&w=0&k=20&c=eqC_1o48WNIxNZIyJrHl8nDLmYC7RtSKq1lJVmDS9GU=',
    'https://t3.ftcdn.net/jpg/01/83/37/72/360_F_183377230_aM8xRw22OMCnbWXYRajuZdAuV94InnkD.jpg',
    'https://wallpapercave.com/wp/wc1683148.jpg',
    'https://img.favpng.com/4/23/9/natural-bodybuilding-1080p-exercise-desktop-wallpaper-png-favpng-5z2Yt1SbkdiykDK3Yzn06iQcE.jpg'
  ];
  

  @override
  Widget build(BuildContext context) {
    final ap = Provider.of<AuthProvider>(context, listen: false);
    return Scaffold(
      bottomNavigationBar: const HomeBottomNavigation(),
      appBar: AppBar(
        backgroundColor: Colors.blue[500],
        elevation: 0,
        title: const Text("Homescreen"),
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
                    builder: (context) => const WelcomeScreen(),
                  ),
                ),
              );
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
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Column(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CarouselSlider.builder(
                        itemCount: urlImages.length,
                        itemBuilder: (context, index, realIndex) {
                          final urlImage = urlImages[index];
                          return buildImage(urlImage, index);
                        },
                        options: CarouselOptions(
                          height: 250,
                          autoPlay: true,
                          enlargeCenterPage: true,
                          autoPlayInterval: Duration(seconds: 3),
                          onPageChanged: (index, reason) =>
                              setState(() => activeIndex = index),
                        ),

                      ),
                      const SizedBox(height: 20),
                      buildIndicator(),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30.0, right: 200),
              child: Text(
                'New Products',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 25
                ),
              ),
            ),
            SizedBox(height: 30),

            CarouselScreen(),
            SizedBox(height: 30,),
            ElevatedButton.icon(
              onPressed: () {
                // Handle button press
              },
              icon: Icon(Icons.qr_code_2),
              label: Text('SCAN QR CODE',
                style: TextStyle(color: Colors.white),),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(200, 50),
                primary: Colors.green
              ),
            ),



          ],
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
          child: ListView(
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
                title: Text("Home",style: TextStyle(color: Colors.white),),
                trailing: Icon(Icons.arrow_forward_ios),
                onTap: () {},
              ),
              ListTile(
                leading: Icon(Icons.account_box),
                title: Text("Membership Details",style: TextStyle(color: Colors.white),),
                trailing: Icon(Icons.arrow_forward_ios),
                onTap: () {},
              ),
              ListTile(
                leading: Icon(Icons.money_rounded),
                title: Text("Payment",style: TextStyle(color: Colors.white),),
                trailing: Icon(Icons.arrow_forward_ios),
                onTap: () {},
              ),
              ListTile(
                leading: Icon(Icons.grid_3x3_outlined),
                title: Text("New Products",style: TextStyle(color: Colors.white),),
                trailing: Icon(Icons.arrow_forward_ios),
                onTap: () {},
              ),
              ListTile(
                leading: Icon(Icons.qr_code),
                title: Text("Attendance Scanner",style: TextStyle(color: Colors.white),),
                trailing: Icon(Icons.arrow_forward_ios),
                onTap: () {},
              ),
              ListTile(
                leading: Icon(Icons.settings),
                title: Text("Settings",style: TextStyle(color: Colors.white),),
                trailing: Icon(Icons.arrow_forward_ios),
                onTap: () {},
              ),
            ],
          ),
        ),
      ),

    );
  }

  Widget buildImage(String urlImage, int index) => Container(
    margin: EdgeInsets.only(left: 10,right: 10),
    child: Image.network(
      urlImage,
      fit: BoxFit.cover,
    ),
  );

  Widget buildIndicator() => AnimatedSmoothIndicator(
    activeIndex: activeIndex,
    count: urlImages.length,
    effect: JumpingDotEffect(
      dotWidth: 10,
      dotHeight: 10,
      dotColor: Colors.green,
      activeDotColor: Colors.white,
    ),
  );
}
