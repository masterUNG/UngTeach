import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ungteach/utility/dialog.dart';
import 'package:ungteach/utility/my_style.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  String name, user, password;

  Container buildName() {
    return Container(
      decoration: MyStyle().box20(),
      margin: EdgeInsets.only(top: 16),
      width: 250,
      child: TextField(
        onChanged: (value) => name = value.trim(),
        style: TextStyle(color: MyStyle().darkColor),
        decoration: InputDecoration(
          hintStyle: TextStyle(color: MyStyle().darkColor),
          prefixIcon: Icon(
            Icons.fingerprint,
            color: MyStyle().darkColor,
          ),
          hintText: 'Name',
          enabledBorder: MyStyle().outline20(),
          focusedBorder: MyStyle().outline20(),
        ),
      ),
    );
  }

  Container buildUser() {
    return Container(
      decoration: MyStyle().box20(),
      margin: EdgeInsets.only(top: 16),
      width: 250,
      child: TextField(
        onChanged: (value) => user = value.trim(),
        keyboardType: TextInputType.emailAddress,
        style: TextStyle(color: MyStyle().darkColor),
        decoration: InputDecoration(
          hintStyle: TextStyle(color: MyStyle().darkColor),
          prefixIcon: Icon(
            Icons.email_outlined,
            color: MyStyle().darkColor,
          ),
          hintText: 'Email',
          enabledBorder: MyStyle().outline20(),
          focusedBorder: MyStyle().outline20(),
        ),
      ),
    );
  }

  Container buildPassword() {
    return Container(
      decoration: MyStyle().box20(),
      margin: EdgeInsets.only(top: 16),
      width: 250,
      child: TextField(
        onChanged: (value) => password = value.trim(),
        style: TextStyle(color: MyStyle().darkColor),
        decoration: InputDecoration(
          hintStyle: TextStyle(color: MyStyle().darkColor),
          prefixIcon: Icon(
            Icons.lock_outline,
            color: MyStyle().darkColor,
          ),
          hintText: 'Password',
          enabledBorder: MyStyle().outline20(),
          focusedBorder: MyStyle().outline20(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            buildName(),
            buildUser(),
            buildPassword(),
            buildRegister(),
          ],
        ),
      ),
    );
  }

  Container buildRegister() {
    return Container(
      margin: EdgeInsets.only(top: 16),
      width: 250,
      child: ElevatedButton(
        onPressed: () {
          print('name = $name, user = $user, password = $password');
          if ((name == null || name.isEmpty) ||
              (user?.isEmpty ?? true) ||
              (password?.isEmpty ?? true)) {
            normalDialog(context, 'Have Space ? Please Fill Every Blank');
          } else {
            registerThread();
          }
        },
        child: Text('Register'),
      ),
    );
  }

  Future<Null> registerThread() async {
    await Firebase.initializeApp().then((value) async {
      print('###### Initialize Success ######');
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: user, password: password)
          .then((value)async {
        print('Register Success');
        await value.user.updateProfile(displayName: name).then((value) => Navigator.pop(context));
      }).catchError((value) {
        normalDialog(context, value.message);
      });
    });
  }
}
