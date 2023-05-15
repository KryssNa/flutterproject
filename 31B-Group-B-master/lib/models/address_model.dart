import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'dart:convert';

Address addressFromJson(String str) => Address.fromJson(json.decode(str));

String addressToJson(Address data) => json.encode(data.toJson());

class Address {
  Address({
    this.id,
    required this.addressTitle,
    required this.detailAddressDirection,
    required this.alternatePhoneNumber,
    required this.isDefaultAddress,
  });
  String? id;
  String addressTitle;
  String detailAddressDirection;
  String alternatePhoneNumber;
  String isDefaultAddress;

  factory Address.fromFirebaseSnapshot(
          DocumentSnapshot<Map<String, dynamic>> json) =>
      Address(
        id: json.id,
        addressTitle: json["addressTitle"],
        detailAddressDirection: json["detailAddressDirection"],
        alternatePhoneNumber: json["alternatePhoneNumber"],
        isDefaultAddress: json["isDefaultAddress"],
      );

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        id: json["addressTitle"],
        addressTitle: json["addressTitle"],
        detailAddressDirection: json["detailAddressDirection"],
        alternatePhoneNumber: json["alternatePhoneNumber"],
        isDefaultAddress: json["isDefaultAddress"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        addressTitle: ["addressTitle"],
        detailAddressDirection: ["detailAddressDirection"],
        alternatePhoneNumber: ["alternatePhoneNumber"],
        isDefaultAddress: ["isDefaultAddress"],
      };
}
