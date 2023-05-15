import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class EditAddressScreen extends StatefulWidget {
  const EditAddressScreen({Key? key}) : super(key: key);

  @override
  State<EditAddressScreen> createState() => _EditAdressSreenState();
}

class _EditAdressSreenState extends State<EditAddressScreen> {
  TextEditingController AddressTitle = new TextEditingController();
  TextEditingController DetailAddressDirection = new TextEditingController();
  TextEditingController AlternatePhoneNumber = new TextEditingController();
  TextEditingController DefaultAddress = new TextEditingController();

  Future<void> saveAddress() async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    final data = {
      "addressTitle": AddressTitle.text,
      "detailAddressDirection": DetailAddressDirection.text,
      "alternatePhoneNumber": AlternatePhoneNumber.text,
      "isDefaultAddress": DefaultAddress.text
    };

    db.collection("Address").add(data).then((value) {
      print("Added Data With ID: ${value.id}");
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Address Added")));
    });
  }

  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final args = ModalRoute.of(context)!.settings.arguments;
      print(args);
      FirebaseFirestore db = FirebaseFirestore.instance;

      db.collection("Address").doc(args.toString()).get().then((data) {
        AddressTitle.text = data["AddressTitle"];
        DetailAddressDirection = data["DetailAddressDirection"];
        AlternatePhoneNumber = data["AltrnatePhoneNumber"];
        DefaultAddress.text = data["DefaultAddress"];
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            TextFormField(
              controller: AddressTitle,
            ),
            TextFormField(
              controller: DetailAddressDirection,
            ),
            TextFormField(
              controller: AlternatePhoneNumber,
            ),
            TextFormField(
              controller: DefaultAddress,
            ),
            ElevatedButton(
                onPressed: () {
                  saveAddress();
                },
                child: Text("Save"))
          ],
        ),
      ),
    );
  }
}
