import 'package:flutter/material.dart';

class OrderHistoryDetail extends StatefulWidget {
  final String? address;
  final String? date;
  final String? total;

  OrderHistoryDetail({this.address,this.date,this.total});

  @override
  _OrderHistoryDetailState createState() => _OrderHistoryDetailState();
}

class _OrderHistoryDetailState extends State<OrderHistoryDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order History Detail'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            History(foodName: 'Burger',date: 'Got on Dec-15',),
            Divider(thickness: 2.0,),
            History(foodUrl: 'cereals.jpg',foodName: 'Cereals',date: 'Got on Dec-17',),
            Divider(thickness: 2.0,),
            History(foodUrl: 'icecream.jpg',foodName: 'Ice-Cream',date: 'Got on Dec-18',),
            Divider(thickness: 2.0,),
            History(foodUrl: 'momo.jpg',foodName: 'Momo',date: 'Got on Dec-18',),
            Divider(thickness: 2.0,),
          ],
        ),
      ),
    );
  }
}

class History extends StatelessWidget {
  final String? foodUrl;
  final String? foodName;
  final String? date;
  const History({Key? key,this.foodUrl, this.foodName, this.date}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Container(
            height: 40.0,
            width: 60.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              image: DecorationImage(
                image: AssetImage('images/${foodUrl??'burger.jpg'}'),
                fit: BoxFit.fill
              )
            ),
          ),
          SizedBox(width: 10.0,),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("${foodName??''}",style: TextStyle(fontSize: 20,color: Colors.grey[800]),),
              Text("${date??''}",style: TextStyle(fontSize: 17,color: Colors.grey[700]),),
            ],
          ),
        ],
      ),
    );
  }
}

