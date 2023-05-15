import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:hunger_cravings/DetailsScreen/productdetail_screens.dart';
import 'package:hunger_cravings/delivery_address/delivery_time.dart';
import 'package:hunger_cravings/models/address_model.dart';

import '../orderConfirm.dart';

class AddAddressScreen extends StatefulWidget {
  const AddAddressScreen({Key? key}) : super(key: key);

  @override
  State<AddAddressScreen> createState() => _AddAdressSreenState();
}

class _AddAdressSreenState extends State<AddAddressScreen> {
  TextEditingController AddressTitle = new TextEditingController();
  TextEditingController DetailAddressDirection = new TextEditingController();
  TextEditingController AlternatePhoneNumber = new TextEditingController();
  TextEditingController DefaultAddress = new TextEditingController();
  bool value = false;

  final form = GlobalKey<FormState>();

  Future<void> saveAddress() async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    final data = Address(
        addressTitle: AddressTitle.text,
        detailAddressDirection: DetailAddressDirection.text,
        alternatePhoneNumber: AlternatePhoneNumber.text,
        isDefaultAddress: DefaultAddress.text);

    db.collection("Address").add(data.toJson()).then((value) {
      print(value.id);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Address Added Successfully")));

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          child: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    CheckoutScreen(),
              ),
            );
          },
        ),
        backgroundColor: Colors.black,
        centerTitle: true,
        title: const Text(
          'ADD ADDRESS',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Form(
            key: form,
            child: Column(
              children: [
                Container(
                  height: 200,
                  width: double.infinity,
                  child: Image.asset('assets/images/Logo.jpg'),
                ),
                Container(
                  margin: EdgeInsets.only(left: 10, right: 10),
                  child: Column(
                    children: [
                      TextFormField(
                        controller: AddressTitle,
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return "Address Title is required";
                          }
                        },
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(width: 3, color: Colors.black),
                              borderRadius: BorderRadius.circular(90)),
                          hintText: "Enter Address Title",
                        ),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      TextFormField(
                        controller: DetailAddressDirection,
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return "Detail Address Direction is required";
                          }
                        },
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(width: 3, color: Colors.black),
                              borderRadius: BorderRadius.circular(90)),
                          hintText: "Enter Detail Address Direction",
                        ),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      TextFormField(
                        controller: AlternatePhoneNumber,
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return "Alternate Phone Number is required";
                          }
                        },
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(width: 3, color: Colors.black),
                              borderRadius: BorderRadius.circular(90)),
                          hintText: "Enter Alternate Phone Number",
                        ),
                      ),
                      SizedBox(
                        height: 35,
                      ),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black),
                          onPressed: () {
                            if (form.currentState!.validate()) {
                              saveAddress();
                              Navigator.of(context).pushNamed("/deliveryTime");
                            }
                          },
                          child: Text("ADD")),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black),
                          onPressed: () {
                            Navigator.of(context).pushNamed("/map");
                          },
                          child: Text("map")),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
