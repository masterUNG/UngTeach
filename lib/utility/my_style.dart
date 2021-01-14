import 'package:flutter/material.dart';

class MyStyle {
  Color darkColor = Color(0xff630c00);
  Color primaryColor = Color(0xff963c00);
  Color lightColor = Color(0xffcd6930);

  Widget showProgress() => Center(child: CircularProgressIndicator());

  OutlineInputBorder outline20() => OutlineInputBorder(
        borderSide: BorderSide(color: MyStyle().darkColor),
        borderRadius: BorderRadius.circular(20),
      );

  BoxDecoration box20() => BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      );

  MyStyle();
}
