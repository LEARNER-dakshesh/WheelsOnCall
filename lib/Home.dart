import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

import 'insert.dart';

class Home extends StatelessWidget {
  final navigationKey = GlobalKey<CurvedNavigationBarState>();
  int index = 2;
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
      Icon(Icons.home, size: 30),
      Icon(Icons.search, size: 30),
      Icon(Icons.favorite, size: 30),
      Icon(Icons.mail_outline, size: 30),
      Icon(Icons.person, size: 30),
    ];
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
      //  centerTitle: true,
        title: Text("DriverKaro",style: TextStyle(color: Colors.black),),
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
          index: index,
          items: items,
          height: 55,
          onTap: (index) {
            setState(
              () => this.index = index,
            );
          },
        ),
      ),
      body: Container(
        child: Column(
          children: [
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
            Padding(
              padding: const EdgeInsets.only(left: 200.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, 'insert');
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.amber,shape: RoundedRectangleBorder(
                  side: BorderSide(color: Colors.transparent,width: 2),
                  borderRadius: BorderRadius.circular(5)
                )),
                child: Text(
                  ' Add as Driver ',
                  style:
                      TextStyle(color: Colors.white, fontWeight: FontWeight.bold, ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void setState(int Function() param0) {}
}
