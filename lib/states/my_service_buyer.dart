import 'package:flutter/material.dart';
import 'package:piwsupermall/utility/my_style.dart';

class MyserviceBuyer extends StatefulWidget {
  @override
  _MyserviceBuyerState createState() => _MyserviceBuyerState();
}

class _MyserviceBuyerState extends State<MyserviceBuyer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyStyle().primarydarkColor,
      appBar: AppBar(
        title: Text('Buyer'),
      ),
      drawer: Drawer(
        child: MyStyle().buildSigOut(context),
      ),
    );
  }
}
