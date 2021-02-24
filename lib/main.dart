import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:piwsupermall/models/typeuser_model.dart';
import 'package:piwsupermall/states/add_information.dart';
import 'package:piwsupermall/states/authen.dart';
import 'package:piwsupermall/states/create_account.dart';
import 'package:piwsupermall/states/my_service_buyer.dart';
import 'package:piwsupermall/states/my_service_shopper.dart';
import 'package:piwsupermall/utility/api.dart';

final Map<String, WidgetBuilder> map = {
  '/authen': (BuildContext context) => Authen(),
  '/createAccount': (BuildContext context) => CreateAccount(),
  '/myServiceBuyer': (BuildContext context) => MyserviceBuyer(),
  '/myServiceShopper': (BuildContext context) => MyserviceShopper(),
  '/addInformation': (BuildContext context) => AddInformation(),
};
String iniRount = '/authen';

Future<Null> main() async {
  WidgetsFlutterBinding.ensureInitialized(); //Wait Tread Finish Jop
  await Firebase.initializeApp().then((value) async {
    await FirebaseAuth.instance.authStateChanges().listen((event) async {
      if (event != null) {
        String uid = event.uid;
        await FirebaseFirestore.instance
            .collection('typeuser')
            .doc(uid)
            .snapshots()
            .listen((event) {
              TypeUserModel model = TypeUserModel.fromMap(event.data());
              String typeuser = model.typeuser;
              print('uid==>$uid, typeuser = $typeuser');
              iniRount = Api().findKeyByTypeUser(typeuser);
              runApp(MyApp());
            });
      } else {
        runApp(MyApp());
      }
    });
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    return MaterialApp(
      routes: map,
      title: 'Piw SupperMall',
      initialRoute: iniRount,
    );
  }
}
