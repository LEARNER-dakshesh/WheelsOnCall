// To parse this JSON data, do
//
//     final driverDetails = driverDetailsFromJson(jsonString);

import 'dart:convert';

DriverDetails driverDetailsFromJson(String str) => DriverDetails.fromJson(json.decode(str));

String driverDetailsToJson(DriverDetails data) => json.encode(data.toJson());

class DriverDetails {
  String address;
  int? age;
  String drivingLicence;
  String image;
  String name;
  String phoneNo;

  DriverDetails({
    required this.address,
    required this.age,
    required this.drivingLicence,
    required this.image,
    required this.name,
    required this.phoneNo,
  });

  factory DriverDetails.fromJson(Map<String, dynamic> json) => DriverDetails(
    address: json["Address"],
    age: json["Age"],
    drivingLicence: json["DrivingLicence"],
    image: json["Image"],
    name: json["Name"],
    phoneNo: json["Phone No."],
  );

  Map<String, dynamic> toJson() => {
    "Address": address,
    "Age": age,
    "DrivingLicence": drivingLicence,
    "Image": image,
    "Name": name,
    "Phone No.": phoneNo,
  };
}
