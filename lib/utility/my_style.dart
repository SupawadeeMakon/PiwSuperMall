import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class MyStyle {

  Color darkColor = Color(0xffaa00c7);
  Color primarydarkColor = Color(0xffe040fb);
  Color LightColor = Color(0xffff79ff);

  Widget showLogo() => Image(image: AssetImage('images/logo.png'));
  Widget showImage() => Image(image: AssetImage('images/image.png'));

  Column buildSigOut(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ListTile(
          onTap: () async {
            await Firebase.initializeApp().then((value) async {
              await FirebaseAuth.instance.signOut().then(
                    (value) => Navigator.pushNamedAndRemoveUntil(
                        context, '/authen', (route) => false),
                  );
            });
          },
          tileColor: Colors.red.shade700,
          leading: Icon(
            Icons.exit_to_app,
            size: 36,
            color: Colors.white,
          ),
          title: Text(
            'Sign Out',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }

  Container buildBackground(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height,
      child: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            child: Image(
              image: AssetImage('images/top1.png'),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            child: Image(
              image: AssetImage('images/top2.png'),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            child: Image(
              image: AssetImage('images/bottom1.png'),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            child: Image(
              image: AssetImage('images/bottom2.png'),
            ),
          ),
        ],
      ),
    );
  }

  Widget titleH1(String string) => Text(
        string,
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: darkColor,
        ),
      );

Widget titleH2Dark(String string) => Text(
        string,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w700,
          color: darkColor,
        ),
      );

Widget titleH3Dark(String string) => Text(
        string,
        style: TextStyle(
          fontSize: 16,
          //fontWeight: FontWeight.w700,
          color: darkColor,
        ),
      );
Widget titleH3White(String string) => Text(
        string,
        style: TextStyle(
          fontSize: 16,
          //fontWeight: FontWeight.w700,
          color: Colors.white
        ),
      );


Widget titleH3Button(String string) => Text(
        string,
        style: TextStyle(
          fontSize: 16,
          //fontWeight: FontWeight.w700,
          color: Colors.orange.shade700,
        ),
      );

  MyStyle();
}
