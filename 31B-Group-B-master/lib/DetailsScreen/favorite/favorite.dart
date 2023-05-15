import 'package:flutter/material.dart';
import 'package:hunger_cravings/dashboard/screens/home.dart';
import '../widgets/favourite_fetch/favourite_fetch_product.dart';

class Favourite extends StatefulWidget {
  @override
  _FavouriteState createState() => _FavouriteState();
}

class _FavouriteState extends State<Favourite> {
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
        title: Text('Favourites'),
      ),
      body: SafeArea(
        child: fetchproduct("users-favourite-items"),
      ),
    );
  }
}
