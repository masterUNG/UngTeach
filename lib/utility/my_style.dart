import 'package:flutter/material.dart';

class MyStyle {
  Color darkColor = Color(0xff630c00);
  Color primaryColor = Color(0xff963c00);
  Color lightColor = Color(0xffcd6930);

  Widget buildBackGround(BuildContext context) => SafeArea(
        child: Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              Positioned(
                top: 0,
                left: 0,
                child: Image.asset('images/top1.png'),
              ),
              Positioned(
                top: 0,
                left: 0,
                child: Image.asset('images/top2.png'),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                child: Image.asset('images/bottom1.png'),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                child: Image.asset('images/bottom2.png'),
              ),
            ],
          ),
        ),
      );

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
