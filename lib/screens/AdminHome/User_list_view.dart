import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:provider/provider.dart';
import 'package:gym_el/provider/auth_provider.dart';

class UserListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ap = Provider.of<AuthProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text('User List'),
        automaticallyImplyLeading: true,
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
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('users').snapshots(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            if (snapshot.data == null || snapshot.data!.size == 0) {
              return Center(
                child: Text('No users found.'),
              );
            }

            return ListView.builder(
              itemCount: snapshot.data!.size,
              itemBuilder: (BuildContext context, int index) {
                final user = snapshot.data!.docs[index];
                final uid = user.id;

                return FutureBuilder<DocumentSnapshot<Map<String, dynamic>>?>(
                  future: _getUser(uid),
                  builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>?> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.grey,
                        ),
                        title: Text('Loading...'),
                        subtitle: Text(''),
                      );
                    }

                    if (snapshot.hasError || snapshot.data == null) {
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.grey,
                          child: Icon(Icons.person),
                        ),
                        title: Text('Error'),
                        subtitle: Text('Failed to retrieve user data'),
                      );
                    }

                    final userData = snapshot.data!.data();
                    final profilePic = userData?['profilePic'];

                    return ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.grey,
                        backgroundImage: profilePic != null ? NetworkImage(profilePic) : null,
                        child: profilePic == null ? Icon(Icons.person) : null,
                      ),
                      title: Text(userData?['name'] ?? '', style: TextStyle(color: Colors.white)),
                      subtitle: Text(userData?['email'] ?? '', style: TextStyle(color: Colors.white)),
                    );
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }

  Future<DocumentSnapshot<Map<String, dynamic>>?> _getUser(String uid) async {
    try {
      final userSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .get();
      return userSnapshot;
    } catch (e) {
      print('Error retrieving user data: $e');
      return null;
    }
  }
}
