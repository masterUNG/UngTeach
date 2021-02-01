import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:ungteach/utility/background.dart';
import 'package:ungteach/utility/dialog.dart';
import 'package:ungteach/utility/my_style.dart';

class Authen extends StatefulWidget {
  @override
  _AuthenState createState() => _AuthenState();
}

class _AuthenState extends State<Authen> {
  bool statusRedEye = true;
  String user, password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: buildTextButton(),
      body: Stack(
        children: [
          MyStyle().buildBackGround(context),
          buildMainContent(),
        ],
      ),
    );
  }

  

  Row buildMainContent() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buildLogo(),
            buildAppName(),
            buildUser(),
            buildPassword(),
            buildLogin(),
            buildSignWithGmail(),
          ],
        ),
      ],
    );
  }

  Container buildSignWithGmail() {
    return Container(
      width: 250,
      child: SignInButton(
        Buttons.GoogleDark,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        onPressed: () => signWithGmail(),
      ),
    );
  }

  Future<Null> signWithGmail() async {
    GoogleSignIn _googleSignIn = GoogleSignIn(
      scopes: [
        'email',
        'https://www.googleapis.com/auth/contacts.readonly',
      ],
    );

    await Firebase.initializeApp().then((value) async {
      await _googleSignIn.signIn().then((value) {
        print('Google SignIn Success');
        Navigator.pushNamed(context, '/myService');
      });
    });
  }

  Container buildLogin() {
    return Container(
      margin: EdgeInsets.only(top: 16),
      width: 250,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: MyStyle().darkColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
        onPressed: () {
          if ((user?.isEmpty ?? true) || (password?.isEmpty ?? true)) {
            normalDialog(context, 'Have Space ? Please Fill All Blank');
          } else {
            checkAuthen();
          }
        },
        child: Text('Login'),
      ),
    );
  }

  TextButton buildTextButton() => TextButton(
        onPressed: () => Navigator.pushNamed(context, '/register'),
        child: Text('New Register'),
      );

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
            Icons.perm_identity,
            color: MyStyle().darkColor,
          ),
          hintText: 'User',
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
        obscureText: statusRedEye,
        style: TextStyle(color: MyStyle().darkColor),
        decoration: InputDecoration(
          suffixIcon: IconButton(
            icon: Icon(Icons.remove_red_eye),
            onPressed: () {
              setState(() {
                statusRedEye = !statusRedEye;
              });
              print('statusRedEye = $statusRedEye');
            },
          ),
          labelStyle: TextStyle(color: MyStyle().darkColor),
          prefixIcon: Icon(
            Icons.lock,
            color: MyStyle().darkColor,
          ),
          hintText: 'Password',
          enabledBorder: MyStyle().outline20(),
          focusedBorder: MyStyle().outline20(),
        ),
      ),
    );
  }

  Text buildAppName() => Text(
        'Ung Teach',
        style: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.w500,
          fontStyle: FontStyle.italic,
          color: MyStyle().darkColor,
        ),
      );

  Container buildLogo() {
    return Container(
      width: 150.0,
      child: Image.asset('images/logo.png'),
    );
  }

  Future<Null> checkAuthen() async {
    await Firebase.initializeApp().then((value) async {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: user, password: password)
          .then((value) => Navigator.pushNamedAndRemoveUntil(
              context, '/myService', (route) => false))
          .catchError((value) {
        normalDialog(context, value.message);
      });
    });
  }
}
