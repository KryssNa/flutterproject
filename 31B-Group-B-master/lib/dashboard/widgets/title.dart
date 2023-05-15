import 'package:flutter/material.dart';

import '../widgets/commons.dart';

class CustomText extends StatelessWidget {
  final String text;
  final double size;
  // final Color colors;
  // final FontWeight weight;


  CustomText({required this.text, required this.size,});//required this.colors,required this.weight,
  @override
  Widget build(BuildContext context) {

    return Text(text,style: TextStyle(fontSize: size ?? 16,),);//color: colors ?? black, fontWeight: FontWeight.normal
  }
}
