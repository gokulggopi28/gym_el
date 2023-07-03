import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RegistrationProgressPage extends StatefulWidget {
  @override
  _RegistrationProgressPageState createState() => _RegistrationProgressPageState();
}

class _RegistrationProgressPageState extends State<RegistrationProgressPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registration Progress'),
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
          stream: FirebaseFirestore.instance
              .collection('users')
              .orderBy('createdAt', descending: true)
              .snapshots(),
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

            final currentTime = Timestamp.now();
            final registeredWithinThreeDaysUsers = snapshot.data!.docs.where((user) {
              final createdAt = user['createdAt'] as Timestamp;
              final difference = currentTime.toDate().difference(createdAt.toDate()).inDays;
              return difference <= 3;
            }).toList();

            if (registeredWithinThreeDaysUsers.isEmpty) {
              return Center(
                child: Text('No users registered within the last 3 days.'),
              );
            }

            return ListView.builder(
              itemCount: registeredWithinThreeDaysUsers.length,
              itemBuilder: (BuildContext context, int index) {
                final user = registeredWithinThreeDaysUsers[index];
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
                        trailing: LinearProgressIndicator(),
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
      final userSnapshot = await FirebaseFirestore.instance.collection('users').doc(uid).get();
      return userSnapshot;
    } catch (e) {
      print('Error retrieving user data: $e');
      return null;
    }
  }
}
