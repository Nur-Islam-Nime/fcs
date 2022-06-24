import 'package:flutter/material.dart';

Widget CustomGrid(
  Image,
  onTap,
) {
  return InkWell(
    onTap: onTap,
    child: Container(
      decoration: BoxDecoration(
        color: const Color(0xfff3f8ff),
        border: Border.all(width: 1, color: Color(0xffb3b3b3)),
        borderRadius: const BorderRadius.all(Radius.circular(7)),
      ),
      child: Image,
    ),
  );
}
