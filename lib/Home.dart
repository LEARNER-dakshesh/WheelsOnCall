import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:drivekaro/screens/about_screen.dart';
import 'package:drivekaro/screens/favorite_screen.dart';
import 'package:drivekaro/screens/home_screen.dart';
import 'package:drivekaro/screens/mail_screen.dart';
import 'package:drivekaro/screens/search_screen.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final navigationKey = GlobalKey<CurvedNavigationBarState>();
  int currentIndex = 2;
  final List<Widget> _screens = [
    HomeScreen(),
    SearchScreen(),
    MyMapScreen(),
    MailScreen(),
    AboutScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    List<String> imagePaths = [
      'assets/slider4.jpg',
      'assets/slider1.jpg',
      'assets/slider5.jpg',
      'assets/slider3.jpg',
      'assets/slider2.jpg',
    ];
    final items = <Widget>[
      IconButton(
        icon: Icon(Icons.home, size: 30),
        onPressed: () {
          Navigator.pushNamed(context, 'home');
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
          automaticallyImplyLeading: true,
          //  centerTitle: true,
          title: Text(
            "DriverKaro",
            style: TextStyle(
              color: Colors.green,
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
          elevation: 0,
          actions: [
            IconButton(
              icon: Icon(
                Icons.account_circle_outlined,
                size: 32,
                color: Colors.black,
              ),
              onPressed: () {},
            ),
          ],
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
        body: Container(
            child: Column(children: [
          Padding(
            padding: EdgeInsets.only(top: 10),
            child: CarouselSlider(
              options: CarouselOptions(
                height: 200.0,
                enlargeCenterPage: true,
                aspectRatio: 19 / 9,
                autoPlay: true,
                autoPlayInterval: Duration(seconds: 3),
                autoPlayAnimationDuration: Duration(milliseconds: 700),
                autoPlayCurve: Curves.fastOutSlowIn,
              ),
              items: imagePaths.map((imagePath) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.symmetric(horizontal: 5.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20.0),
                        child: Image.asset(
                          imagePath,
                          fit: BoxFit.fill,
                        ),
                      ),
                    );
                  },
                );
              }).toList(),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(18),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 10),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, 'insert');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.amber,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  child: Text(
                    'Add as Driver',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Expanded(
              child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Why is driver hiring app needed?',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        ),
                        SizedBox(height: 20),
                        Container(
                            child: Column(children: [
                          Container(
                            height: 50,
                            padding: EdgeInsets.all(10),
                            color: Colors.red,
                            child: Center(
                              child: Text("Hastle Free Rides"),
                            ),
                          ),
                          Container(
                            height: 50,
                            color: Colors.blue,
                            padding: EdgeInsets.all(10),
                            child: Center(
                              child: Text("Long Journey"),
                            ),
                          ),
                          Container(
                            height: 50,
                            color: Colors.green,
                            child: Center(
                              child: Text("Emergency Situation"),
                            ),
                          ),
                          Container(
                            height: 50,
                            color: Colors.yellow,
                            child: Center(
                              child: Text("Verified Peoples"),
                            ),
                          )
                        ]))
                      ])))
        ])));
  }
}
//   void setState(int Function() param0) {}
// }
