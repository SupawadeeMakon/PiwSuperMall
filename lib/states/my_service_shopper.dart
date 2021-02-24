import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:piwsupermall/bodies/information_shopper.dart';
import 'package:piwsupermall/bodies/show_order_shopper.dart';
import 'package:piwsupermall/bodies/show_product.dart';
import 'package:piwsupermall/models/typeuser_model.dart';
import 'package:piwsupermall/utility/my_style.dart';

class MyserviceShopper extends StatefulWidget {
  @override
  _MyserviceShopperState createState() => _MyserviceShopperState();
}

class _MyserviceShopperState extends State<MyserviceShopper> {
  TypeUserModel typeUserModel;
  String nameLogin;
  List<Widget> widgets = [
    ShowOrderShopper(),
    ShowProduct(),
    InformationShop(),
  ];
  List<String> titles = [
    'Show Order',
    'Show Product',
    'Show Information',
  ];

  int index = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    findUserLogin();
  }

  Future<Null> findUserLogin() async {
    await Firebase.initializeApp().then((value) async {
      await FirebaseAuth.instance.authStateChanges().listen((event) async {
        String uid = event.uid;

        await FirebaseFirestore.instance
            .collection('typeuser')
            .doc(uid)
            .snapshots()
            .listen((event) {
          typeUserModel = TypeUserModel.fromMap(event.data());
          print(
              'name = ${typeUserModel.name},urlshopper==> ${typeUserModel.urlshopper}');
              if (typeUserModel.urlshopper == null) {
                setState(() {
                  index = 2;
                });
                
              } else {
              }
        });

        setState(() {
          nameLogin = event.displayName;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyStyle().primarydarkColor,
        title: Text(titles[index]),
      ),
      drawer: buildDrawer(context),
      body: widgets[index],
    );
  }

  Drawer buildDrawer(BuildContext context) {
    return Drawer(
      child: Stack(
        children: [
          Column(
            children: [
              buildUserAccountsDrawerHeader(),
              buildMenuShowOrder(context),
              buildMenuShowProduct(context),
              buildMenuInformation(context),
            ],
          ),
          MyStyle().buildSigOut(context),
        ],
      ),
    );
  }

  ListTile buildMenuShowOrder(BuildContext context) {
    return ListTile(
      onTap: () {
        setState(() {
          index = 0;
        });
        Navigator.pop(context);
      },
      leading: Icon(
        Icons.online_prediction_rounded,
        color: MyStyle().primarydarkColor,
      ),
      title: MyStyle().titleH2Dark(titles[0]),
      subtitle: MyStyle().titleH3Dark('Display Order of Customer'),
    );
  }

  ListTile buildMenuShowProduct(BuildContext context) {
    return ListTile(
      onTap: () {
        setState(() {
          index = 1;
        });
        Navigator.pop(context);
      },
      leading: Icon(
        Icons.list,
        color: MyStyle().primarydarkColor,
      ),
      title: MyStyle().titleH2Dark(titles[1]),
      subtitle: MyStyle().titleH3Dark('Display Product of shopper'),
    );
  }

  ListTile buildMenuInformation(BuildContext context) {
    return ListTile(
      onTap: () {
        setState(() {
          index = 2;
        });
        Navigator.pop(context);
      },
      leading: Icon(
        Icons.info,
        color: MyStyle().primarydarkColor,
      ),
      title: MyStyle().titleH2Dark(titles[2]),
      subtitle: MyStyle().titleH3Dark('Display Information '),
    );
  }

  UserAccountsDrawerHeader buildUserAccountsDrawerHeader() {
    return UserAccountsDrawerHeader(
        decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage('images/top2.png'))),
        accountName: nameLogin == null ? null : MyStyle().titleH1(nameLogin),
        accountEmail: MyStyle().titleH2Dark('Shopper'));
  }
}
