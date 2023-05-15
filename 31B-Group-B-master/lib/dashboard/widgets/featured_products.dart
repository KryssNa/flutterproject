

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hunger_cravings/dashboard/widgets/title.dart';

import '../../DetailsScreen/productdetail_screens.dart';
import '../../models/products.dart';
import 'commons.dart';

List<Product> productList=[
  Product(name:"Cereals",image:"cereals.jpg",price:5.00, rating:4.2, vendor:"GoodFood", whishList:true, quantity: 1, pricePerItem: 5.00),
  Product(name:"Pizza",image:"pizza.jpg",price:6.00, rating:4.8, vendor:"GoodFood", whishList:true, quantity: 1, pricePerItem: 6.00),
  Product(name:"Steak",image:"steak.jpg",price:4.00, rating:4.4, vendor:"GoodFood", whishList:true, quantity: 1, pricePerItem: 4.00),
  Product(name:"burger",image:"burger.jpg",price:5.00, rating:4.4, vendor:"GoodFood", whishList:true, quantity: 1, pricePerItem: 5.00),
  Product(name:"ramen",image:"ramen.jpg",price:6.00, rating:4.4, vendor:"GoodFood", whishList:true, quantity: 1, pricePerItem: 6.00),
];
class Featured extends StatelessWidget {
  const Featured({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return  Container(
      height: 240,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: productList.length,
          itemBuilder: (_, index) {
            return InkWell(
              onTap: (){
                Navigator.of(context).push(
                  //Replacement
                  MaterialPageRoute(
                    builder: (BuildContext context) =>
                        ProductDetails(productList[index]),
                  ),
                );
              },
              child: Padding(
                padding: EdgeInsets.fromLTRB(12,14,16,12),
                child: Container(
                  height: 240,
                  width: 220,
                  decoration: BoxDecoration(
                      color: white,
                      boxShadow: [
                        BoxShadow(
                            color: red,
                            offset: Offset(15, 5),
                            blurRadius: 30),
                      ]),
                  child: Column(
                    children: <Widget>[
                      Image.asset(
                        "images/${productList[index].image}",
                        height: 140,
                        width: 140,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CustomText(
                              text: productList[index].name,
                              size: 10,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: white,
                                  boxShadow: [
                                    BoxShadow(
                                        color: grey,
                                        offset: Offset(1, 1),
                                        blurRadius: 4)
                                  ]),
                              // child: Padding(
                              //   padding: const EdgeInsets.all(4),
                              //   child: productList[index].whishList? Icon(
                              //     Icons.favorite,
                              //     color: red,
                              //     size: 18,
                              //   ):Icon(
                              //     Icons.favorite_border,
                              //     color: red,
                              //     size: 18,
                              //   ),
                              // ),
                            ),
                          )
                        ],
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children:<Widget> [
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: CustomText(
                                  text: productList[index].rating.toString(),
                                  size: 14,
                                ),
                              ),
                              SizedBox(
                                width: 2,
                              ),
                              Icon(
                                Icons.star,
                                color: red,
                                size: 16,
                              ),
                              Icon(
                                Icons.star,
                                color: red,
                                size: 16,
                              ),
                              Icon(
                                Icons.star,
                                color: red,
                                size: 16,
                              ),
                              Icon(
                                Icons.star,
                                color: red,
                                size: 16,
                              ),
                              Icon(
                                Icons.star,
                                color: grey,
                                size: 16,
                              )
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: CustomText(text: "\$${productList[index].price}", size: 15,),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}
