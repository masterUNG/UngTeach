import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:ungteach/models/token_model.dart';
import 'package:ungteach/states/show_listvideo.dart';

class MyService extends StatefulWidget {
  @override
  _MyServiceState createState() => _MyServiceState();
}

class _MyServiceState extends State<MyService> {
  String nameLogin;
  Widget currentWidget = ShowListVideo();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    readData();
    findToken();
  }

  Future<Null> findToken() async {
    await Firebase.initializeApp().then((value) async {
      await FirebaseAuth.instance.authStateChanges().listen((event) async {
        String uid = event.uid;
        FirebaseMessaging messaging = FirebaseMessaging();
        String token = await messaging.getToken();
        DateTime dateTimeLogin = DateTime.now();
        Timestamp timestamp = Timestamp.fromDate(dateTimeLogin);
        TokenModel model = TokenModel(token: token, timestampLogin: timestamp);
        await FirebaseFirestore.instance
            .collection('token')
            .doc(uid).collection('login').doc()
            .set(model.toMap())
            .then((value) => print('Token ==> $token'));
      });
    });
  }

  Future<Null> readData() async {
    await Firebase.initializeApp().then((value) async {
      // find DisplayName
      await FirebaseAuth.instance.authStateChanges().listen((event) {
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
        title: Text(nameLogin == null ? 'Name Login' : nameLogin),
        actions: [
          IconButton(
              icon: Icon(Icons.exit_to_app_rounded),
              onPressed: () async {
                await Firebase.initializeApp().then((value) async {
                  await FirebaseAuth.instance.signOut().then((value) =>
                      Navigator.pushNamedAndRemoveUntil(
                          context, '/authen', (route) => false));
                });
              })
        ],
      ),
      drawer: Drawer(),
      body: currentWidget,
    );
  }
}
