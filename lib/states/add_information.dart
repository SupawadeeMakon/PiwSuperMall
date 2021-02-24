import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:piwsupermall/models/typeuser_model.dart';
import 'package:piwsupermall/utility/my_style.dart';

class AddInformation extends StatefulWidget {
  @override
  _AddInformationState createState() => _AddInformationState();
}

class _AddInformationState extends State<AddInformation> {
  double screen;
  List<String> names = ['', ''];
  TypeUserModel typeUserModel;
  File file;
  String uid;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    readInitiaValue();
  }

  Future<Null> readInitiaValue() async {
    await Firebase.initializeApp().then((value) async {
      await FirebaseAuth.instance.authStateChanges().listen((event) async {
        uid = event.uid;
        await FirebaseFirestore.instance
            .collection('typeuser')
            .doc(event.uid)
            .snapshots()
            .listen((event) {
          setState(() {
            typeUserModel = TypeUserModel.fromMap(event.data());
            names[0] = typeUserModel.name;
          });
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    screen = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyStyle().primarydarkColor,
        title: Text('Add of Edit Information'),
      ),
      body: names[0].isEmpty ? CircularProgressIndicator() : buildContent(),
    );
  }

  Column buildContent() {
    return Column(
      children: [
        buildRowImage(),
        buildName(),
        buildUploadeData(),
      ],
    );
  }

  Future<Null> uploadImageToFirebase() async {
    int i = Random().nextInt(100000);
    String fileName = 'shop$i.jpg';
    //String fileName = 'shopper$i.png';

    await Firebase.initializeApp().then((value) async {
      UploadTask task = FirebaseStorage.instance
          .ref()
          .child('shopper/$fileName')
          .putFile(file);
      await task.whenComplete(() async {
        String urlPath = await FirebaseStorage.instance
            .ref()
            .child('shopper/$fileName')
            .getDownloadURL();
        print('urlPath ==>> $urlPath');
        if (names[1].isEmpty) {
          //update urlimage Only
          Map<String, dynamic> data = Map();
          data['urlshopper'] = urlPath;
          await FirebaseFirestore.instance
              .collection('typeuser')
              .doc(uid)
              .update(data)
              .then((value) => Navigator.pop(context));
        } else {
          //update about
        }
      });
    });
  }

  ElevatedButton buildUploadeData() {
    return ElevatedButton.icon(
      onPressed: () {
        if ((file == null) && (names[1].isEmpty)) {
          Navigator.pop(context);
        } else {
          if (file == null) {
            //Change Display Only

          } else {
            //Upload Image to Firebase
            uploadImageToFirebase();
          }
        }
      },
      icon: Icon(Icons.cloud_upload),
      label: Text('Upload Data'),
    );
  }

  Container buildName() {
    return Container(
      width: screen * 0.6,
      child: TextFormField(
        onChanged: (value) => names[1] = value.trim(),
        initialValue: names[0],
        decoration: InputDecoration(
          border: OutlineInputBorder(),
        ),
      ),
    );
  }

  Future<Null> getImage(ImageSource source) async {
    try {
      var result = await ImagePicker().getImage(
        source: source,
        maxWidth: 800,
        maxHeight: 800,
      );
      setState(() {
        file = File(result.path);
      });
    } catch (e) {}
  }

  Row buildRowImage() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
            icon: Icon(Icons.add_a_photo),
            onPressed: () => getImage(ImageSource.camera)),
        buildImage(),
        IconButton(
          icon: Icon(Icons.add_a_photo_outlined),
          onPressed: () => getImage(ImageSource.gallery),
        ),
      ],
    );
  }

  Container buildImage() {
    return Container(
      width: screen * 0.6,
      height: screen * 0.6,
      child:
          file == null ? MyStyle().showImage() : Image(image: FileImage(file)),
    );
  }
}
