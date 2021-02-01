import 'package:flutter/material.dart';

class BackGround extends StatelessWidget {
  final Widget child;

  const BackGround({Key key, @required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
          child: Container(
        width: double.infinity,
        height: size.height,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              top: 0,
              right: 0,
              child: Image.asset('images/top1.png'),
            ),
            Positioned(
              top: 0,
              right: 0,
              child: Image.asset('images/top2.png'),
            )
          ],
        ),
      ),
    );
  }
}
