import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drivekaro/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class UserRepository extends GetxController{
  static UserRepository get Instance =>Get.find();

 final _db=FirebaseFirestore.instance;

 Future<UserModel>getUserDetails(String Name) async{
   final snapshot=await _db.collection("Driver Details").where("Name",isEqualTo: Name).get();
   final driverdata=snapshot.docs.map((e)=>UserModel.fromSnapshot(e)).single;
   return driverdata;
 }

  Future<List<UserModel>>allDriverString Name) async{
    final snapshot=await _db.collection("Drivers").get();
    final driverdata=snapshot.docs.map((e)=>UserModel.fromSnapshot(e)).toList();
    return driverdata;
  }
}