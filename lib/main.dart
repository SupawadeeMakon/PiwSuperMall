import 'package:flutter/material.dart';
import 'package:piwsupermall/states/authen.dart';
import 'package:piwsupermall/states/create_account.dart';
import 'package:piwsupermall/states/my_service_buyer.dart';
import 'package:piwsupermall/states/my_service_shopper.dart';

final Map<String, WidgetBuilder> map={
  '/authen':(BuildContext context)=>Authen(),
  '/createAccount':(BuildContext context)=>CreateAccount(),
  '/myServiceBuyer':(BuildContext context)=> MyserviceBuyer(),
  '/myServiceShopper':(BuildContext context)=>MyserviceShopper(),
};
  String iniRount ='/authen';

  main()=>runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: map,
      title: 'Piw SupperMall',
      initialRoute: iniRount,
    );
  }
}