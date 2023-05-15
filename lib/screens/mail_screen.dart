import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:drivekaro/screens/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'about_screen.dart';
import 'favorite_screen.dart';
import 'home_screen.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MailScreen(),
  ));
}

class MailScreen extends StatefulWidget {
  const MailScreen({Key? key}) : super(key: key);

  @override
  State<MailScreen> createState() => _MailScreenState();
}

class _MailScreenState extends State<MailScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _messageController = TextEditingController();
  final navigationKey = GlobalKey<CurvedNavigationBarState>();
  int currentIndex = 3;
  final List<Widget> _screens = [
    HomeScreen(),
    SearchScreen(),
    MyMapScreen(),
    MailScreen(),
    AboutScreen(),
  ];

  void _sendEmail() async {
    final String emailUrl =
        'mailto:daksheshgupta4@gmail.com?subject=Message from DriveKaro App&body=${_messageController.text}';
    print('Email URL: $emailUrl');
    if (await canLaunch(emailUrl)) {
      print('Launching email client...');
      await launch(emailUrl);
    } else {
      print('Could not launch email client.');
      throw 'Could not launch $emailUrl';
    }
  }

  @override
  Widget build(BuildContext context) {
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
          title: Text(
            'Contact Us',
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
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'For any support, please write to us:',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 10.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText: 'Write your message here for any kind of Support',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your message';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                SizedBox(height: 16.0),
                SizedBox(
                  height: 50.0,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.amber,
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _sendEmail();

                      }
                    },
                    child: Text('Send'),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
