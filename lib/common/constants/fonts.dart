import 'package:flutter/material.dart';

class FontHelper{
  static const String robotoFamily='Roboto';
  static const String poppinsFamily='Poppins';


  static TextStyle regular({
    double fontSize=0,
    Color color=Colors.black,
  }) {
    return TextStyle(
      fontFamily: robotoFamily,
      fontSize: fontSize,
      color: color,
      fontWeight: FontWeight.w300,
    );
  }


  static TextStyle medium({
    double fontSize=0,
    Color color=Colors.black,
  }) {
    return TextStyle(
      fontFamily: robotoFamily,
      fontSize: fontSize,
      color: color,
      fontWeight: FontWeight.w500,
    );
  }

  static TextStyle mediumPoppins({
    double fontSize=0,
    Color color=Colors.black,
  }) {
    return TextStyle(
      fontFamily: poppinsFamily,
      fontSize: fontSize,
      color: color,
      fontWeight: FontWeight.w500,
    );
  }



  static TextStyle semiBold({
    double fontSize=0,
    Color color=Colors.black,
  }) {
    return TextStyle(
      fontFamily: robotoFamily,
      fontSize: fontSize,
      color: color,
      fontWeight: FontWeight.w600,
    );
  }

  static TextStyle bold({
  double fontSize=0,
  Color color=Colors.black,
  }) {
    return TextStyle(
      fontFamily: robotoFamily,
      fontSize: fontSize,
      color: color,
      fontWeight: FontWeight.bold,
    );
  }
}