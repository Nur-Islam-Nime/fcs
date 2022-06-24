import 'package:flutter/material.dart';

Widget customTextField (String hintText, controller,  [bool obscureText=false] ){
  return Padding(
    padding: const EdgeInsets.only(left: 60,top: 15,right: 60,bottom: 5),

    child: Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      child: TextField(
        controller: controller ,
        obscureText: obscureText,
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