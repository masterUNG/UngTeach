import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ungteach/router.dart';
import 'package:ungteach/utility/my_style.dart';

String initialRoute = '/authen';

Future<Null> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp().then((value) async {
    await FirebaseAuth.instance.authStateChanges().listen((event) {
      if (event != null) {
        initialRoute = '/myService';
      }
      runApp(MyApp());
    });
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.brown,
        inputDecorationTheme: InputDecorationTheme(
          hintStyle: TextStyle(color: MyStyle().darkColor),
        ),
      ),
      routes: routes,
      initialRoute: initialRoute,
    );
  }
}
