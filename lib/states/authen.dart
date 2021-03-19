import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';

import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:ungteach/utility/dialog.dart';
import 'package:ungteach/utility/my_style.dart';
import 'package:http/http.dart' as http;

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
            buildSignWithEmail(),
            buildSignWithGmail(),
            buildSignWithFacebook(),
            buildSignWithAppleId(),
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
          borderRadius: BorderRadius.circular(30),
        ),
        onPressed: () => signWithGmail(),
      ),
    );
  }

  Container buildSignWithFacebook() {
    return Container(
      width: 250,
      child: SignInButton(
        Buttons.FacebookNew,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        onPressed: () => singWithFackbookFirebase(),
      ),
    );
  }

  Future<Null> singWithFackbookFirebase() async {
    FacebookLogin facebookLogin = FacebookLogin();
    await facebookLogin.logInWithReadPermissions(['email', "public_profile"]).then((value) async {
      String token = value.accessToken.token;
      print('### Token facebook ==>> $token ###');
      await Firebase.initializeApp().then((value) async {
        final graphResponse = await http.get(
            'https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email&access_token=${token}');
        final profile = json.decode(graphResponse.body);
        print('######### profile ==> $profile');

        AuthCredential authCredential = FacebookAuthProvider.credential(token);

        final UserCredential userCredential =
            await FirebaseAuth.instance.signInWithCredential(authCredential);
        String nameLogin = userCredential.user.displayName;
        print('################## nameLogin = $nameLogin ################# \n ######################');

        // await FirebaseAuth.instance
        //     .signInWithCredential(authCredential)
        //     .then((value) => print('############### value token Success ##############'));
      });
    });
  }

  Future<Null> singWithFacebook() async {
    final FacebookLogin facebookLogin = FacebookLogin();
    print('SingWithFacebook');
    final result = await facebookLogin.logInWithReadPermissions(['email']);
    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        final String token = result.accessToken.token;
        final graphResponse = await http.get(
            'https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email&access_token=${token}');
        final profile = json.decode(graphResponse.body);
        print('######### profile ==> $profile');
        await Firebase.initializeApp().then((value) async {});
        break;
      default:
    }
  }

  Container buildSignWithAppleId() {
    return Container(
      width: 250,
      child: SignInButton(
        Buttons.AppleDark,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        onPressed: () {},
      ),
    );
  }

  Container buildSignWithEmail() {
    return Container(
      margin: EdgeInsets.only(top: 16),
      width: 250,
      child: SignInButton(
        Buttons.Email,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        onPressed: () {
          if ((user?.isEmpty ?? true) || (password?.isEmpty ?? true)) {
            normalDialog(context, 'Have Space ? Please Fill All Blank');
          } else {
            checkAuthen();
          }
        },
      ),
    );
  }

  Future<Null> signWithGmail() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    GoogleSignIn _googleSignIn = GoogleSignIn(
      scopes: [
        'email',
        'https://www.googleapis.com/auth/contacts.readonly',
      ],
    );
    await Firebase.initializeApp().then((value) async {
      await _googleSignIn.signIn().then((googleSignInAccount) async {
        await googleSignInAccount.authentication
            .then((googleSignInAuthentication) async {
          AuthCredential authCredential = GoogleAuthProvider.credential(
            idToken: googleSignInAuthentication.idToken,
            accessToken: googleSignInAuthentication.accessToken,
          );

          await auth.signInWithCredential(authCredential).then((authResult) {
            print(
                '################### authResult user ==> ${authResult.user} ##################');
            String uid = authResult.user.uid;
            print('uid === $uid');
            Navigator.pushNamed(context, '/myService');
          });
        });
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
        onPressed: () {},
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
            },
          ),
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
