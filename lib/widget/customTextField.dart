import 'package:flutter/material.dart';

Widget customTextField (String hintText, bool obscureText){
  return Padding(
    padding: const EdgeInsets.only(left: 60,top: 15,right: 60,bottom: 5),

    child: Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      child: TextField(

        obscureText: obscureText,
        textAlign: TextAlign.center,

        decoration: InputDecoration(
            focusedBorder: InputBorder.none,
          hintText: hintText,
        ),
      ),
    ),
  );
}