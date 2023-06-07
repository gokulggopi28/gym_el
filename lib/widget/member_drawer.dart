import 'package:flutter/material.dart';
import 'package:gym_el/provider/auth_provider.dart';
import 'package:provider/provider.dart';

class MyHeaderDrawer extends StatefulWidget {
  const MyHeaderDrawer({required Key key}) : super(key: key);

  @override
  State<MyHeaderDrawer> createState() => _MyHeaderDrawerState();
}

class _MyHeaderDrawerState extends State<MyHeaderDrawer> {
  @override
  Widget build(BuildContext context) {
    final ap = Provider.of<AuthProvider>(context, listen: false);
    return Container(
      color: Colors.blue,
      width: double.infinity,
      height: 200,
      padding: EdgeInsets.only(top: 20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            backgroundColor: Colors.blue,
            backgroundImage: NetworkImage(ap.userModel.profilePic),
            radius: 50,
          ),
          UserAccountsDrawerHeader(
            accountName: Text("AppMaking.co"),
            accountEmail: Text("sundar@appmaking.co"),
            currentAccountPicture: CircleAvatar(
              backgroundImage: NetworkImage(
                  "https://media.istockphoto.com/id/479009182/photo/silhouette-of-a-strong-fighter.jpg?s=612x612&w=0&k=20&c=eqC_1o48WNIxNZIyJrHl8nDLmYC7RtSKq1lJVmDS9GU="),
            ),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                  "https://images.unsplash.com/photo-1577221084712-45b0445d2b00?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8Ym9keWJ1aWxkaW5nfGVufDB8fDB8fHww&w=1000&q=80",
                ),
                fit: BoxFit.fill,
              ),
            ),
            otherAccountsPictures: [
              CircleAvatar(
                backgroundColor: Colors.white,
                backgroundImage: NetworkImage(
                    "https://www.shutterstock.com/image-photo/brutal-strong-bodybuilder-athletic-man-260nw-1277705647.jpg"),
              ),
              CircleAvatar(
                backgroundColor: Colors.white,
                backgroundImage: NetworkImage(
                    "https://images.unsplash.com/photo-1603287681836-b174ce5074c2?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8Ym9keWJ1aWxkZXJ8ZW58MHx8MHx8fDA%3D&w=1000&q=80"),
              ),
            ],
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text("Home"),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.account_box),
            title: Text("About"),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.grid_3x3_outlined),
            title: Text("Products"),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.contact_mail),
            title: Text("Contact"),
            onTap: () {},
          )
        ],
    ),
    );
  }
  }




