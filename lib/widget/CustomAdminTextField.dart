import 'package:flutter/material.dart';

Widget customAdminTextField(String hintText,  [controller] ){
  return Padding(
    padding: const EdgeInsets.only(left: 40,right: 40,top: 5,bottom: 5),
    child: Container(
      decoration: BoxDecoration(
        border: Border.all(color:const Color(0xff707070)),
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextField(
controller: controller,
        textAlign: TextAlign.center,

        decoration: InputDecoration(
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          hintText: hintText,
        ),
      ),
    ),
  );
}