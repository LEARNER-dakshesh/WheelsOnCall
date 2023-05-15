import 'dart:async';
import 'package:flutter/services.dart';
import 'package:drivekaro/pho.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pinput/pinput.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'pho.dart';

class MyOt extends StatefulWidget {
  const MyOt({Key? key}) : super(key: key);

  @override
  State<MyOt> createState() => _MyOtState();
}

class _MyOtState extends State<MyOt> {
  final FirebaseAuth auth = FirebaseAuth.instance;

  late SharedPreferences prefs;
  late Timer timer;
  bool verified = false;

  @override
  void initState() {
    super.initState();
    initPrefs();
  }

  void initPrefs() async {
    await Firebase.initializeApp();
    prefs = await SharedPreferences.getInstance();

    final lastVerifiedTimestamp = prefs.getInt('last_verified_timestamp') ?? 0;
    final now = DateTime.now().millisecondsSinceEpoch;
    if (now - lastVerifiedTimestamp < 15 * 60 * 1000) {
      setState(() {
        verified = true;
      });
      startTimer(now - lastVerifiedTimestamp);
    }
  }

  void startTimer(int lastVerifiedTimestamp) {
    timer = Timer(
        Duration(milliseconds: 15 * 60 * 1000 - lastVerifiedTimestamp), () {
      setState(() {
        verified = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Future<void> triggerAutofill() async {
      const timeout = Duration(milliseconds: 100);
      await Future.delayed(timeout); // wait for the keyboard to show up
      await SystemChannels.textInput.invokeMethod('TextInput.hide'); // hide keyboard
      await Future.delayed(timeout); // wait for keyboard to hide
      await SystemChannels.textInput.invokeMethod('TextInput.show'); // show keyboard
      await Future.delayed(timeout); // wait for keyboard to show up
      await SystemChannels.textInput.invokeMethod('TextInput.hide'); // hide keyboard again
    }
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: TextStyle(
          fontSize: 20,
          color: Color.fromRGBO(30, 60, 87, 1),
          fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        border: Border.all(color: Color.fromRGBO(234, 239, 243, 1)),
        borderRadius: BorderRadius.circular(20),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: Color.fromRGBO(114, 178, 238, 1)),
      borderRadius: BorderRadius.circular(8),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        color: Color.fromRGBO(234, 239, 243, 1),
      ),
    );
    var code = "";
    return Scaffold(
      // backgroundColor: Colors.blueGrey,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            onPressed: () {
              Navigator.pushNamed(context, 'pho');
            },
            icon: Icon(
              Icons.arrow_back_ios_outlined,
              color: Colors.black,
            ),
          )),
      body: Container(
          margin: EdgeInsets.only(left: 30, right: 30),
          alignment: Alignment.center,
          child: SingleChildScrollView(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child: Image.asset(
                  'assets/as1.jpg',
                  height: 150,
                  width: 150,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text("Phone Verification",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              SizedBox(
                height: 10,
              ),
              Text(
                "We need to verify register your phone before getting started !",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 20,
              ),
              Pinput(

                  autofillHints: [AutofillHints.oneTimeCode],
                  defaultPinTheme: defaultPinTheme,
                  focusedPinTheme: focusedPinTheme,
                  submittedPinTheme: submittedPinTheme,
                  validator: (s) {
                    return s == '2222' ? null : '';
                  },
                  pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                  length: 6,
                  showCursor: true,
                  onChanged: (value) {
                    code = value;
                  }),

              SizedBox(
                height: 10,
              ),
              SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      try {
                        PhoneAuthCredential credential =
                            PhoneAuthProvider.credential(
                                verificationId: MyPho.verify, smsCode: code);

                        // Sign the user in (or link) with the credential
                        await auth.signInWithCredential(credential);
                        Fluttertoast.showToast(
                            msg: " Success ",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.green,
                            textColor: Colors.white,
                            fontSize: 16.0);
                        Navigator.pushNamedAndRemoveUntil(
                            context, "home", (route) => false);
                      } catch (e) {
                        Fluttertoast.showToast(
                            msg: "Wrong Otp ",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 16.0);
                        print("Wrong Otp");
                      }
                    },
                    child: Text("Verify the code"),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.amber,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                  )),
              Row(
                children: [
                  TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, 'pho');
                      },
                      child: Text(
                        "Edit the Phone No?",
                        style: TextStyle(color: Colors.black),
                      )),
                ],
              ),
            ],
          ))),
    );
  }
}
