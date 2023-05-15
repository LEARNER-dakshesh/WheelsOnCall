// ignore_for_file: deprecated_member_use

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:drivekaro/screens/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'favorite_screen.dart';
import 'home_screen.dart';
import 'mail_screen.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: AboutScreen(),
  ));
}

class AboutScreen extends StatefulWidget {
  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  final navigationKey = GlobalKey<CurvedNavigationBarState>();
  int currentIndex = 4;
  final List<Widget> _screens = [
    HomeScreen(),
    SearchScreen(),
    MyMapScreen(),
    MailScreen(),
    AboutScreen(),
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
          Navigator.pushNamed(context, 'Home');
        },
      ),
      IconButton(
        icon: Icon(Icons.mail_outline, size: 30),
        onPressed: () {
          Navigator.pushNamed(context, 'mail_screen');
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
          'Developers Page',
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
      body: Center(
        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              child: Image.asset(
                'assets/developers.jpeg',
                width: 300,
                height: 300,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            SizedBox(height: 30.0),
            Text(
              'This is a driving hiring app which allows users to hire confident and safe journey drivers.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 30.0),
            Text(
              'Meet the Developers:',
              style: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 15.0),
            GestureDetector(
              onTap: () => launch('https://www.linkedin.com/in/daksheshgupta/'),
              child: Text(
                'Managed By Dakshesh : {',
                style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.blue,
                ),
              ),
            ),
            SizedBox(height: 5.0),
            GestureDetector(
              onTap: () => launch(
                  'https://www.linkedin.com/in/varunesh-pathak-aa7413223/'),
              child: Text(
                'Fronted Developer  Varunesh Pathak : {',
                style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.blue,
                ),
              ),
            ),
            SizedBox(height: 5.0),
            GestureDetector(
              onTap: () =>
                  launch('https://www.linkedin.com/in/dev-sharma-a1310922b/'),
              child: Text(
                'Backend Developer Dev Sharma  : {',
                style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.blue,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
