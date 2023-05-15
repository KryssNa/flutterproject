import 'package:flutter/material.dart';
import 'package:hunger_cravings/dashboard/screens/home.dart';

import '../widgets/fetchProducts.dart';

class Cart extends StatefulWidget {
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Home()),
            );
          },
          icon: Icon(Icons.arrow_back),
        ),
        backgroundColor: Colors.black,
        title: Text('Cart'),
      ),
      body: SafeArea(
        child: MyWidget(
          collectionName: 'users-cart-items',
        ),
      ),
    );
  }
}
