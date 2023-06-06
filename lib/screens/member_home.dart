import 'package:flutter/material.dart';
import 'package:gym_el/provider/auth_provider.dart';
import 'package:gym_el/screens/welcome_screen.dart';
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
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text("FlutterPhone Auth"),
        actions: [
          IconButton(
            onPressed: () {
              ap.userSignOut().then((value) => Navigator.push(
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundColor: Colors.purple,
              backgroundImage: NetworkImage(ap.userModel.profilePic),
              radius: 50,
            ), // CircleAvatar const SizedBox (height: 20),
            Text(ap.userModel.name),
            Text(ap.userModel.phoneNumber),
            Text(ap.userModel.email),
            Text(ap.userModel.bio),
          ],
        ),
      ),
    );
  }
}
