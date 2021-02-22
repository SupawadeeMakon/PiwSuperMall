import 'package:flutter/material.dart';

class MyStyle {

  Color darkColor = Color(0xffaa00c7);
  Color primarydarkColor = Color(0xffe040fb);
  Color LightColor = Color(0xffff79ff);
  Widget showLogo() => Image(image: AssetImage('images/logo.png'));

  Widget titleH1(String string) => Text(
        string,
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: darkColor,
        ),
      );

  MyStyle();
}
