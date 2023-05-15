import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyPho extends StatefulWidget {
  const MyPho({Key? key}) : super(key: key);
  static String verify = "";

  @override
  State<MyPho> createState() => _MyPhoState();
}

class _MyPhoState extends State<MyPho> {
  TextEditingController countryCode = TextEditingController();
  var phone = "";
  @override
  void initState() {
    // TODO: implement initState
    countryCode.text = " +91";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.blueGrey,
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
                  height: 200,
                  width: 200,
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
                "We need to verify  your phone before getting started !",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Colors.grey),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    SizedBox(
                      width: 40,
                      child: TextField(
                        controller: countryCode,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "|",
                      style: TextStyle(fontSize: 33, color: Colors.grey),
                    ),
                    Expanded(
                        child: TextField(
                            keyboardType: TextInputType.phone,
                            onChanged: (value) {
                              phone = value;
                            },
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Phone No.")))
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      await FirebaseAuth.instance.verifyPhoneNumber(
                        phoneNumber: '${countryCode.text + phone}',
                        verificationCompleted:
                            (PhoneAuthCredential credential) {},
                        verificationFailed: (FirebaseAuthException e) {},
                        codeSent: (String verificationId, int? resendToken) {
                          MyPho.verify = verificationId;
                          Navigator.pushNamed(context, 'ot');
                        },
                        codeAutoRetrievalTimeout: (String verificationId) {},
                      );
                      //
                    },
                    child: Text("Send the code"),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.amber,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                  )),
            ],
          ))),
    );
  }
}
