import 'package:flutter/material.dart';
import 'package:ungteach/router.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.brown),
      routes: routes,
      initialRoute: '/authen',
    );
  }
}
