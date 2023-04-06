import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class RealtimeDatabaseInsert extends StatelessWidget {
  RealtimeDatabaseInsert({Key? key}) : super(key: key);

  var nameController = new TextEditingController();
  var ageController = new TextEditingController();
  var dlController = new TextEditingController();
  var adController = new TextEditingController();
  var phnController = new TextEditingController();

  // final databaseRef = FirebaseDatabase.instance.ref();
    final firestore=FirebaseFirestore.instance;
  get data => null;
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Text(
                  'Insert Driver Details',
                  style: TextStyle(fontSize: 28),
                ),
                SizedBox(
                  height: 30,
                ),
                SizedBox(
                  height: 50,
                ),
                TextFormField(
                  controller: nameController,
                  maxLength: 15,
                  decoration: InputDecoration(
                      labelText: 'Name', border: OutlineInputBorder()),
                ),
                SizedBox(
                  height: 15,
                ),
                TextFormField(
                  controller: ageController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText: 'Age', border: OutlineInputBorder()),
                ),
                SizedBox(
                  height: 15,
                ),
                TextFormField(
                  controller: dlController,
                  maxLength: 20,
                  decoration: InputDecoration(
                      labelText: 'Driving Licencse Number',
                      border: OutlineInputBorder()),
                ),
                SizedBox(
                  height: 15,
                ),
                TextFormField(
                  controller: adController,
                  decoration: InputDecoration(
                      labelText: 'Address', border: OutlineInputBorder()),
                ),
                SizedBox(
                  height: 15,
                ),
                TextFormField(
                  controller: phnController,
                  maxLength: 10,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText: 'Phone No.', border: OutlineInputBorder()),
                ),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (nameController.text.isNotEmpty &&
                        ageController.text.isNotEmpty &&
                        dlController.text.isNotEmpty &&
                        adController.text.isNotEmpty &&
                        phnController.text.isNotEmpty) {
                      firestore.collection("Driver Details").add({
                          "Name": nameController.text,
                          "Age": ageController.text,
                          "Driving Licence": dlController.text,
                          "Address.": adController.text,
                          "Phone No.": phnController.text
                      });
                    }
                    },
                  child: Text(
                    "Submit Details",
                  ),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.amber,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                )
              ],
            ),
          ),
        ),
      ),
    ));
  }
  // void insertData(String name, String age, String dl, String ad, String phn) {
  //   databaseRef.push().set({
  //     'name': name,
  //     'age': age,
  //     'dln': dl,
  //     'ad': ad,
  //     'phn': phn,
  //   });
  //   nameController.clear();
  //   ageController.clear();
  //   dlController.clear();
  //   adController.clear();
  //   phnController.clear();
  // }
}
