import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drivekaro/insert.dart';
import 'package:drivekaro/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:firebase_cached_image/firebase_cached_image.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Fetch extends StatefulWidget {
  @override
  _FetchState createState() => _FetchState();
}

class _FetchState extends State<Fetch> {
  Future<List<DriverDetails>>? details;

  @override
  void initState() {
    super.initState();
    details = fetchRecords();
  }


  Future<List<DriverDetails>> fetchRecords() async {
    var snapshot =
    await FirebaseFirestore.instance.collection('Driver Details').get();

    List<DriverDetails> records = [];
    for (var doc in snapshot.docs) {
      var address = doc.data()['Address'];
      var drivingLicence = doc.data()['DrivingLicence'];

      // Create a DriverDetails object with all the fields
      var driver = DriverDetails(
        name: doc.data()['Name'] ?? 'Daksh',
        phoneNo: doc.data()['Phone No.'] ?? '8810939813',
        age: int.parse(doc.data()['Age']) ?? 0,
        address: address,
        drivingLicence: drivingLicence,
        image: doc.data()['Image'] ?? ' sdjk',
      );
      records.add(driver);
    }
    return records;
  }
  void _makePhoneCall(String phoneNumber) async {
    final phoneUrl = 'tel:$phoneNumber';
    if (await canLaunch(phoneUrl)) {
      await launch(phoneUrl);
    } else {
      throw 'Could not launch $phoneUrl';
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: FutureBuilder<List<DriverDetails>>(
        future: details,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData) {
            return Center(child: SpinKitWanderingCubes(
              color: Colors.blue,
              size: 50.0,
            ),);
          }

          return ListView.builder(
            physics: BouncingScrollPhysics(parent: ClampingScrollPhysics()),
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 100.0,
                      width: 100.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: CachedNetworkImageProvider(
                            snapshot.data![index].image,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 12.0),
                    Expanded(
                      child: ListTile(
                        title: Text(
                          'Driver',
                          style: TextStyle(
                              color: Colors.green,
                              fontSize: 25,
                              fontWeight: FontWeight.bold),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Name: ${snapshot.data![index].name}",
                              style: TextStyle(color: Colors.black, fontSize: 18,),
                            ),
                            GestureDetector(
                              onTap: () => _makePhoneCall(snapshot.data![index].phoneNo),
                              child: Text(
                                "Phone No.: ${snapshot.data![index].phoneNo}",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),

                            Text(
                              "Address: ${snapshot.data![index].address}",
                              style: TextStyle(color: Colors.black ,fontSize: 18,),
                            ),
                            Text(
                              "Age: ${snapshot.data![index].age}",
                              style: TextStyle(color: Colors.black,fontSize: 18,),
                            ),
                            Text(
                              "Driving License No.: ${snapshot.data![index].drivingLicence}",
                              style: TextStyle(color: Colors.black,fontSize: 18,),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );

            },
          );
        },
      ),
    );
  }
}

class DriverDetails {
  final String name;
  final String phoneNo;
  final int age;
  final String? address;
  final String? drivingLicence;
  final String image;

  DriverDetails(
      {required this.name,
      required this.phoneNo,
      required this.age,
      required this.address,
      required this.drivingLicence,
      required this.image});
}
