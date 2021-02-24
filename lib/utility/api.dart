import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:piwsupermall/models/typeuser_model.dart';

class Api {
  Future<TypeUserModel> findTypeUserBuyUid(String uid) async {
    await Firebase.initializeApp().then((value) async {
      try {
        await FirebaseFirestore.instance
            .collection('typeuser')
            .doc(uid)
            .snapshots()
            .listen((event) {
              TypeUserModel model = TypeUserModel.fromMap(event.data());
              return model;
            });
      } on Exception catch (e) {
              // TODO
              return null;
      }
    });
  }

  String findKeyByTypeUser(String typeuser) {
    switch (typeuser) {
      case 'buyer':
        return '/myServiceBuyer';
        break;
      case 'shopper':
        return '/myServiceShopper';
        break;
      default:
        return null;
    }
  }

  Api();
}
