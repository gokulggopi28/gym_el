import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class AdminNavi extends StatefulWidget {
  final int currentPageIndex;
  final ValueChanged<int> onDestinationSelected;

  const AdminNavi({
    Key? key,
    required this.currentPageIndex,
    required this.onDestinationSelected,
  }) : super(key: key);

  @override
  State<AdminNavi> createState() => _AdminNaviState();
}

class _AdminNaviState extends State<AdminNavi> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.blueAccent,
        color: Colors.deepPurple,
        animationDuration: Duration(milliseconds: 300),
        index: widget.currentPageIndex,
        onTap: widget.onDestinationSelected,
        items: <Widget>[
          Icon(Icons.home, color: Colors.white),
          Icon(Icons.people, color: Colors.white),
          Icon(Icons.settings, color: Colors.white),
        ],
      ),
    );
  }
}
