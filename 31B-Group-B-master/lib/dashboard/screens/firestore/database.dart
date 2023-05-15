import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/address_model.dart';
import '../../../repository/address_repository.dart';
import '../../../viewmodel/address_viewmodel.dart';


class FirebaseDatabaseScreen extends StatefulWidget {
  const FirebaseDatabaseScreen({Key? key}) : super(key: key);

  @override
  State<FirebaseDatabaseScreen> createState() => _FirebaseDatabaseScreenState();
}

class _FirebaseDatabaseScreenState extends State<FirebaseDatabaseScreen> {
  FirebaseFirestore db = FirebaseFirestore.instance;
  deleteAddress(String? id) {}
  void deleteTask(String id) async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text("Are you sure you want to delete?"),
        actions: [
          ElevatedButton(
              onPressed: () {
                _AddressRepository.deleteAddress(id).then((value) =>
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Product deleted"))));

                Navigator.of(context).pop();
              },
              child: Text("Delete")),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Cancel'),
          ),
        ],
      ),
    );
  }

  AddressRepository _AddressRepository = AddressRepository();
  late AddressViewModel _AddressViewModel;

  @override
  void initState() {
    _AddressViewModel = Provider.of<AddressViewModel>(context, listen: false);
    _AddressViewModel.getAddress();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var address = context.watch<AddressViewModel>().address;
    return Scaffold(
      body: StreamBuilder(
        stream: _AddressRepository.getData(),
        builder: (context, AsyncSnapshot<QuerySnapshot<Address>> snapshot) {
          if (snapshot.hasError) return Text("Error");
          return ListView(
            children: [
              ...snapshot.data!.docs.map(
                (document) {
                  Address address = document.data();
                  return ListTile(
                    trailing: Wrap(
                      children: [
                        InkWell(
                            onTap: () {
                              Navigator.of(context).pushNamed("/edit-product",
                                  arguments: document.id);
                            },
                            child: Icon(Icons.edit)),
                        InkWell(
                          onTap: () {
                            deleteAddress(document.id);
                          },
                          child: Icon(Icons.delete),
                        ),
                      ],
                    ),
                  );
                },
              )
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed("/add-address");
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
