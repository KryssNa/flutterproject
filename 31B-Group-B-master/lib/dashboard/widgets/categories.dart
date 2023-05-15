import 'package:flutter/material.dart';

// import 'package:31B-Group-B/dashboard/widgets/title.dart';
import 'package:hunger_cravings/dashboard/widgets/title.dart';
import '../../models/category.dart';
import 'commons.dart';

List<Category>categoriesList=[
  Category(name: "salad", image: "salad.jpg"),
  Category(name: "steak", image: "steak.jpg"),
  Category(name: "ramen", image: "ramen.jpg"),
  Category(name: "momo", image: "momo.jpg"),
  Category(name: "icecream", image: "icecream.jpg"),
  Category(name: "coco", image: "coco.jpg"),
];

class Categories extends StatelessWidget {
  const Categories({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Container(
      height: 105,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categoriesList.length ,
        itemBuilder: (_,index) {
          return  Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    color: white,
                    boxShadow: [
                      BoxShadow(
                          color: red,
                          offset: Offset(2,6),
                          blurRadius: 20
                      )
                    ],
                  ),
                  child: Padding(padding: EdgeInsets.all(4),
                    child: Image.asset("images/${categoriesList[index].image}",width: 60,),),
                ),
                SizedBox(height: 10,),
                CustomText(text: categoriesList[index].name,size:14)
              ],
            ),
          );
        },
      ),
    );
  }
}
