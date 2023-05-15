import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../dashboard/screens/firestore/add_address.dart';
import '../../dashboard/screens/orderConfirm.dart';

class MyWidget extends StatefulWidget {
  final String collectionName;

  MyWidget({required this.collectionName});

  @override
  _MyWidgetState createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection(widget.collectionName)
          .doc(FirebaseAuth.instance.currentUser!.email)
          .collection("items")
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text("Something is wrong"),
          );
        }
        return ListView.builder(
            itemCount: snapshot.data == null ? 0 : snapshot.data!.docs.length,
            itemBuilder: (_, index) {
              DocumentSnapshot _documentSnapshot = snapshot.data!.docs[index];
              return Card(
                elevation: 5,
                child: Column(children: [
                  Row(
                    children: [
                      Expanded(
                        child: ListTile(
                          leading: Image.asset(
                              "images/${_documentSnapshot['images']}",
                              width: 150,
                              height: 150,
                              fit: BoxFit.cover),
                          trailing: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                "\$ ${_documentSnapshot['name']}",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontSize: 20),
                              ),
                              Text(
                                "\$ ${_documentSnapshot['price']}",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Text(
                          "Quantity: ${_documentSnapshot['quantity']}",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 5),
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.add,
                          size: 30,
                        ),
                        onPressed: () {
                          _incrementQuantity(index, snapshot);
                        },
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.remove,
                          size: 30,
                        ),
                        onPressed: _documentSnapshot['quantity'] > 1
                            ? () {
                                _decrementQuantity(index, snapshot);
                              }
                            : null,
                      ),
                      Spacer(),
                      ElevatedButton.icon(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CheckoutScreen()),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                              elevation: 10,
                              shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(30.0),
                                side: BorderSide(color: Colors.black),
                              ),
                              primary: Color.fromARGB(255, 14, 14, 14)),
                          icon: Icon(Icons.shopping_cart),
                          label: Text(
                            "Buy Now",
                            style: TextStyle(fontSize: 15),
                          )),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton.icon(
                        label: Text(
                          "Delete",
                          style: TextStyle(fontSize: 15),
                        ),
                        onPressed: () {
                          FirebaseFirestore.instance
                              .collection(widget.collectionName)
                              .doc(FirebaseAuth.instance.currentUser!.email)
                              .collection("items")
                              .doc(_documentSnapshot.id)
                              .delete();
                        },
                        icon: Icon(Icons.delete),
                        style: ElevatedButton.styleFrom(
                            elevation: 10,
                            shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(30.0),
                              side: BorderSide(color: Colors.black),
                            ),
                            primary: Color.fromARGB(255, 18, 18, 18)),
                      ),
                    ],
                  )
                ]),
              );
            });
      },
    );
  }

  void _incrementQuantity(int index, AsyncSnapshot<QuerySnapshot> snapshot) {
    // get the documentSnapshot for this index
    DocumentSnapshot _documentSnapshot = snapshot.data!.docs[index];
    // increment the quantity
    int newQuantity = _documentSnapshot['quantity'] + 1;
    // calculate the new price
    double newPrice = _documentSnapshot['pricePerItem'] * newQuantity;
    // update the quantity and price in the Firestore document
    FirebaseFirestore.instance
        .collection(widget.collectionName)
        .doc(FirebaseAuth.instance.currentUser!.email)
        .collection("items")
        .doc(_documentSnapshot.id)
        .update({'quantity': newQuantity, 'price': newPrice});
    setState(() {});
  }

  void _decrementQuantity(int index, AsyncSnapshot<QuerySnapshot> snapshot) {
    // get the documentSnapshot for this index
    DocumentSnapshot _documentSnapshot = snapshot.data!.docs[index];
    // decrement the quantity
    int newQuantity = _documentSnapshot['quantity'] - 1;
    // calculate the new price
    double newPrice = _documentSnapshot['pricePerItem'] * newQuantity;
    // update the quantity and price in the Firestore document
    FirebaseFirestore.instance
        .collection(widget.collectionName)
        .doc(FirebaseAuth.instance.currentUser!.email)
        .collection("items")
        .doc(_documentSnapshot.id)
        .update({'quantity': newQuantity, 'price': newPrice});
    setState(() {});
  }
}
