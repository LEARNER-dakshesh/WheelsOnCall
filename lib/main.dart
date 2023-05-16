import 'package:drivekaro/pho.dart';
import 'package:drivekaro/screens/about_screen.dart';
import 'package:drivekaro/screens/favorite_screen.dart';
import 'package:drivekaro/screens/mail_screen.dart';
import 'package:drivekaro/screens/search_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'insert.dart';
import 'ot.dart';
import 'package:drivekaro/ot.dart';
import 'package:drivekaro/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: 'search_screen',
        routes: {
          'pho': (context) => MyPho(),
          'ot': (context) => MyOt(),
          'home': (context) => Home(),
          'insert': (context) => RealtimeDatabaseInsert(),
          'about_screen': (context) => AboutScreen(),
          'mail_screen': (context) => MailScreen(),
          'search_screen': (context) => SearchScreen(),
          'favorite_screen':(context)=>MyMapScreen(),
        });
  }
}
