import 'package:flutter/material.dart';

Widget customListTile(String titleText, amount, ){
  return Padding(
    padding: const EdgeInsets.only(left: 9, right: 9, top: 2,bottom: 2),
    child: ListTile(
      title: Text(titleText),
      trailing: Container(
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xff707070)),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 35,right: 35, top: 2,bottom: 2),
          child: Text( amount),
        ),
      ),
    ),
  );
}