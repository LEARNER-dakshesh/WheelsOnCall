import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

import '../models/fetch.dart';
import 'about_screen.dart';
import 'favorite_screen.dart';
import 'home_screen.dart';
import 'mail_screen.dart';

class SearchScreen extends StatefulWidget {
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final navigationKey = GlobalKey<CurvedNavigationBarState>();
  int currentIndex = 1;
  final List<Widget> _screens = [
    HomeScreen(),
    SearchScreen(),
    MyMapScreen(),
    MailScreen(),
    AboutScreen()
  ];

  @override
  Widget build(BuildContext context) {
    final items = <Widget>[
      IconButton(
        icon: Icon(Icons.home, size: 30),
        onPressed: () {
          Navigator.pushNamed(context, 'Home');
        },
      ),
      IconButton(
        icon: Icon(Icons.search, size: 30),
        onPressed: () {
          Navigator.pushNamed(context, 'search_screen');
        },
      ),
      IconButton(
        icon: Icon(Icons.favorite, size: 30),
        onPressed: () {
        Navigator.pushNamed(context, 'favorite_screen');
        },
      ),
      IconButton(
        icon: Icon(Icons.mail_outline, size: 30),
        onPressed: () {
          Navigator.pushNamed(context, 'search_screen');
        },
      ),
      IconButton(
        icon: Icon(Icons.person, size: 30),
        onPressed: () {
          Navigator.pushNamed(context, 'about_screen');
        },
      ),
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Driver Details Availble',
          style: TextStyle(
            color: Colors.white,
            shadows: [
              Shadow(
                blurRadius: 2.0,
                color: Colors.grey,
                offset: Offset(1.0, 1.0),
              ),
            ],
          ),
        ),
        backgroundColor: Colors.amber,
      ),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          iconTheme: IconThemeData(color: Colors.black),
        ),
        child: CurvedNavigationBar(
          color: Colors.amber,
          buttonBackgroundColor: Colors.white,
          backgroundColor: Colors.transparent,
          index: currentIndex,
          items: items,
          height: 55,
          onTap: (index) {
            setState(() {
              currentIndex = index;
            });
          },
        ),
      ),
      body: Fetch(),
    );
  }
}
