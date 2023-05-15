import 'dart:ui';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:hunger_cravings/DetailsScreen/cart/cart.dart';
import 'package:hunger_cravings/dashboard/screens/search.dart';
import 'package:hunger_cravings/services/notification_service.dart';

import '../../DetailsScreen/favorite/favorite.dart';
import '../../profileScreen/ContactDetails.dart';
import '../widgets/categories.dart';
import '../widgets/commons.dart';
import '../widgets/featured_products.dart';
import '../widgets/small_floating_button.dart';
import '../widgets/title.dart';
import 'location_screens.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  PageController pageController = PageController();
  int selectedIndex = 0;
  _onPageChanged(int index) {
    // onTap
    setState(() {
      selectedIndex = index;
    });
  }

  _itemTapped(int selectedIndex) {
    pageController.jumpToPage(selectedIndex);
    setState(() {
      this.selectedIndex = selectedIndex;
    });
  }

  @override
  void initState() {
    FirebaseMessaging.instance.getToken().then((value) {
      String? token = value;
      print("fcm: " + token.toString());
    });

    FirebaseMessaging.onMessage.listen((message) {
      print(message);
      if (message.notification != null) {
        print(message.notification!.body);
        print(message.notification!.title);
      }

      NotificationService.displayFcm(
          notification: message.notification!, buildContext: context);
    });
    //when the app is in background but opened and user taps
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      print(message);
    });
// TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: white,
        body: PageView(
          controller: pageController,
          children: [const Homepage(), Favourite(), Cart(), MyProfile()],
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.white,
          elevation: 0,
          currentIndex: selectedIndex,
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.black,
          selectedLabelStyle: TextStyle(color: Colors.black),
          unselectedLabelStyle: TextStyle(color: Colors.black),
          type: BottomNavigationBarType.fixed,
          onTap: _itemTapped,
          items: [
            BottomNavigationBarItem(
                icon: Image.asset(
                  "images/home.jpg",
                  width: 32,
                  height: 32,
                ),
                label: "Home"),
            BottomNavigationBarItem(
                icon: Image.asset(
                  "images/heart.png",
                  width: 24,
                  height: 24,
                ),
                label: "Favourite"),
            BottomNavigationBarItem(
                icon: Image.asset(
                  "images/cart.jpg",
                  width: 40,
                  height: 38,
                ),
                label: "Cart"),
            BottomNavigationBarItem(
                icon: Image.asset(
                  "images/people.png",
                  width: 25,
                  height: 25,
                ),
                label: "Profile"),
          ],
        ));
  }
}

class Homepage extends StatelessWidget {
  const Homepage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(
                  "images/logo.jpg",
                  width: 40,
                  height: 20,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomText(text: "Hungry Craving", size: 18),
              ),
              Stack(
                children: <Widget>[
                  IconButton(
                      icon: Icon(
                        Icons.notifications_none,
                      ),
                      onPressed: () {
                        NotificationService.display("Delivery",
                            "Your order is in the way", "Stay Tuned", context);
                        Positioned(
                          top: 12,
                          right: 12,
                          child: Container(
                            height: 10,
                            width: 10,
                            decoration: BoxDecoration(
                                color: red,
                                borderRadius: BorderRadius.circular(20)),
                          ),
                        );
                      }),
                ],
              )
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  color: white,
                  boxShadow: [
                    BoxShadow(color: grey, offset: Offset(1, 1), blurRadius: 4),
                  ],
                ),
                child: ListTile(
                  title: TextField(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SearchPage()),
                      );
                    },
                    decoration: InputDecoration(
                        hintText: "Find food and resturants",
                        border: InputBorder.none),
                  ),
                  // leading: IconButton(
                  //     icon: Icon(
                  //       Icons.location_on,
                  //       color: Colors.red,
                  //     ),
                  //     onPressed: () {
                  //       Navigator.of(context).push(
                  //         //Replacement
                  //         MaterialPageRoute(
                  //           builder: (BuildContext context) => LocationScreen(),
                  //         ),
                  //       );
                  //     }),
                  trailing: IconButton(
                    icon: Icon(
                      Icons.search,
                      color: Colors.red,
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SearchPage()),
                      );
                    },
                  ),
                ),
              )),
          SizedBox(
            height: 6,
          ),
          Categories(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomText(text: "Featured", size: 20),
          ),
          Featured(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomText(text: "Popular", size: 20),
          ),
          Padding(
            padding: const EdgeInsets.all(2),
            child: Stack(
              children: <Widget>[
                Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(40)),
                  child: Padding(
                    padding: const EdgeInsets.all(0),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.asset(
                          "images/tikka.jpg",
                          scale: 1,
                        )),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      // SmallButton(Icons.favorite),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: 50,
                          decoration: BoxDecoration(
                              color: white,
                              borderRadius: BorderRadius.circular(5)),
                          child: Row(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: Icon(
                                  Icons.star,
                                  color: Colors.yellow,
                                  size: 20,
                                ),
                              ),
                              Text("4.5")
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
