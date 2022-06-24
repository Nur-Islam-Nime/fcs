import 'package:flutter/material.dart';
Widget customSubmitButton(String text, onPressed){
  return Container(
    decoration: BoxDecoration(
        color:const Color(0xffed8073), borderRadius: BorderRadius.circular(10)),
    child: TextButton(onPressed: onPressed, child: Padding(
      padding: const EdgeInsets.only(left: 20,right: 20, top: 5,bottom: 5),
      child: Text(text, style: const TextStyle(color: Colors.white),),
    )),
  );
}