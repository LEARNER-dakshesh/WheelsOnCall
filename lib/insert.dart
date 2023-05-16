import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Driver {
  final String name;
  final String phone;
  final String imageUrl;

  Driver({required this.name, required this.phone, required this.imageUrl, required age, required drivingLicence, required address});
}

class RealtimeDatabaseInsert extends StatelessWidget {
  RealtimeDatabaseInsert({Key? key}) : super(key: key);

  var nameController = new TextEditingController();
  var ageController = new TextEditingController();
  var dlController = new TextEditingController();
  var adController = new TextEditingController();
  var phnController = new TextEditingController();

  final firestore = FirebaseFirestore.instance;
  File? _image;
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
                  style: TextStyle(fontSize: 28,fontWeight: FontWeight.bold,color: Colors.green),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 150,
                  width: 300,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Center(
                            child: _image == null
                                ? Text('No image selected.',
                                style:TextStyle(color:Colors.green))
                                : Image.file(_image!),
                          ),
                        ),
                      ElevatedButton(
                          onPressed: () async {
                            final image = await ImagePicker().getImage(source: ImageSource.gallery);
                            child:Text('Image Selected');
                            if (image != null) {
                              _image = File(image.path);
                            }
                          },
                        style:ElevatedButton.styleFrom(backgroundColor: Colors.amber),
                        child: Text('Select Image',),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),

                TextFormField(
                  controller: nameController,
                  decoration: InputDecoration(
                      labelText: 'Name',
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.amber))),
                ),
                SizedBox(
                  height: 15,
                ),
                TextFormField(
                  controller: ageController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText: 'Age',
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.amber))),
                ),
                SizedBox(
                  height: 15,
                ),
                TextFormField(
                  controller: dlController,
                  maxLength: 20,
                  decoration: InputDecoration(
                      labelText: 'Driving Licencse Number',
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.amber))),
                ),
                SizedBox(
                  height: 15,
                ),
                TextFormField(
                  controller: adController,
                  decoration: InputDecoration(
                      labelText: 'Address',
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.amber))),
                ),
                SizedBox(
                  height: 15,
                ),
                TextFormField(
                  controller: phnController,
                  maxLength: 10,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText: 'Phone No.',
                      border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.amber))),
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
                        phnController.text.isNotEmpty
                    && _image.toString().isNotEmpty) {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text("Confirmation"),
                            content: Text(
                                "Are you sure you want to submit these details?"),
                            actions: [
                              TextButton(
                                child: Text(
                                  "Cancel",
                                  style: TextStyle(color: Colors.amber),
                                ),
                                onPressed: () {
                                  nameController.clear();
                                  ageController.clear();
                                  dlController.clear();
                                  adController.clear();
                                  phnController.clear();
                                  Navigator.of(context).pop();
                                },
                              ),
                              TextButton(
                                child: Text(
                                  "Submit",
                                  style: TextStyle(color: Colors.amber),
                                ),
                                onPressed: () async {
                                  // Upload image file to Firebase Storage
                                  var imageName = DateTime.now().millisecondsSinceEpoch.toString();
                                  var storageRef = FirebaseStorage.instance.ref().child('driver_images/$imageName.jpg');
                                  var uploadTask = storageRef.putFile(_image!);
                                  var downloadUrl = await (await uploadTask).ref.getDownloadURL();

                                  firestore.collection("Driver Details").add({
                                    "Name": nameController.text,
                                    "Age": ageController.text,
                                    "Driving Licence": dlController.text,
                                    "Address.": adController.text,
                                    "Phone No.": phnController.text,
                                    "Image": downloadUrl.toString() // Add image reference to document
                                  });
                                  Navigator.of(context).pop();
                                  nameController.clear();
                                  ageController.clear();
                                  dlController.clear();
                                  adController.clear();
                                  phnController.clear();
                                },
                              ),
                            ],
                          );
                        },
                      );
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
}
