import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AttendanceListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Attendance List'),
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
        child: _buildAttendanceList(context),
      ),
    );
  }

  Widget _buildAttendanceList(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('attendance').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }

        final documents = snapshot.data?.docs ?? [];

        return ListView.builder(
          itemCount: documents.length,
          itemBuilder: (context, index) {
            final document = documents[index].data() as Map<String, dynamic>;
            final memberName = document['Member Name'] ?? '';
            final timestamp = document['timestamp']?.toDate() ?? '';

            return ListTile(
              title: Text(memberName,style: TextStyle(color: Colors.white),),
              subtitle: Text(timestamp.toString(),style: TextStyle(color: Colors.white),),
            );
          },
        );
      },
    );
  }
}
