import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget CustomGrid( image,onTap ){
  return InkWell(
    onTap: onTap,
    child: Container(
      decoration: BoxDecoration(
        color: const Color(0xfff3f8ff),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color:const Color(0xffb3b3b3))
      ),
      child: image,
    ),
  );
}