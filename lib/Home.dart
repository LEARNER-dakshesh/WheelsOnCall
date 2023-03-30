// import 'package:carousel_slider/carousel_options.dart';
// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:flutter/material.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'package:mailer/mailer.dart';
// import 'package:mailer/smtp_server.dart';
//
// class Home extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     List<String> imagePaths = [      'assets/first carousel.jpg',      'assets/third carousal.jpg',      'assets/second carousal.jpg',    ];
//
//     return Scaffold(
//       appBar: AppBar(
//           backgroundColor: Colors.amber,
//           elevation: 0,
//           actions: [
//             IconButton(
//               icon: Icon(
//                 Icons.account_circle_outlined,
//                 size: 32,
//               ),
//               onPressed: () {},
//             ),
//           ]),
//       drawer: Drawer(
//         child: ListView(
//           children: <Widget>[
//             SizedBox(
//               height: 100,
//               child: DrawerHeader(
//                 child: Text(
//                   'DriverKaro',
//                   style: TextStyle(
//                       fontWeight: FontWeight.bold,
//                       fontSize: 46,
//                       color: Colors.white),
//                 ),
//                 decoration: BoxDecoration(
//                   color: Colors.amber,
//                 ),
//               ),
//             ),
//             ListTile(
//               leading: Icon(Icons.mail_outline),
//               title: Text('Contact Us'),
//               onTap: () async {
//                 // TODO: Add action
//                 String link = "mailto:daksheshgupta4@gmail.com";
//                 final Uri params = Uri(
//                   // scheme: 'mailto',
//                   path: link,
//                   query: 'subject=Hello%20from%20Flutter',
//                 );
//                 String url = params.toString();
//                 if (await canLaunchUrl(url as Uri)) {
//                   await launchUrl(url as Uri);
//                 } else {
//                   throw 'Could not launch $url';
//                 }
//               },
//             ),
//             ListTile(
//               title: Text('Item 2'),
//               onTap: () {
//                 // TODO: Add action
//               },
//             ),
//           ],
//         ),
//       ),
//       body: Container(
//         child: Column(
//           children: [
//             Padding(
//               padding:  EdgeInsets.only(top: 10),
//               child: CarouselSlider(
//                 options: CarouselOptions(height: 200.0
//                 ),
//                 items: imagePaths.map((imagePath) {
//                   return Builder(
//                     builder: (BuildContext context) {
//                       return Container(
//                         width: MediaQuery.of(context).size.width,
//                         margin: EdgeInsets.symmetric(horizontal: 5.0),
//                         decoration: BoxDecoration(
//                           color: Colors.white,
//                         ),
//                         child: Image.asset(
//                           imagePath,
//                             fit:BoxFit.fill,
//                            ),
//                       );
//                     },
//                   );
//                 }).toList(),
//               ),
//             ),
//             Center(child: Text('My App')),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<String> imagePaths = [      'assets/slider1.jpg',      'assets/slider4.jpg',      'assets/slider3.jpg',  'assets/slider2.jpg',  ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(
              Icons.account_circle_outlined,
              size: 32,
            ),
            onPressed: () {},
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            SizedBox(
              height: 100,
              child: DrawerHeader(
                child: Text(
                  'DriverKaro',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 46,
                    color: Colors.white,
                  ),
                ),
                decoration: BoxDecoration(
                  color: Colors.amber,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.mail_outline),
              title: Text('Contact Us'),
              onTap: () async {
                // TODO: Add action
                String link = "mailto:daksheshgupta4@gmail.com";
                final Uri params = Uri(
                  // scheme: 'mailto',
                  path: link,
                  query: 'subject=Hello%20from%20Flutter',
                );
                String url = params.toString();
                if (await canLaunchUrl(url as Uri)) {
                  await launchUrl(url as Uri);
                } else {
                  throw 'Could not launch $url';
                }
              },
            ),
            ListTile(
              title: Text('Item 2'),
              onTap: () {
                // TODO: Add action
              },
            ),
          ],
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
                  autoPlayInterval: Duration(seconds: 5),
                  autoPlayAnimationDuration: Duration(milliseconds: 800),
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
            Center(child: Text('My App')),
          ],
        ),
      ),
    );
  }
}

