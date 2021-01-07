import 'package:flutter/material.dart';
import 'package:ungteach/states/authen.dart';
import 'package:ungteach/states/my_service.dart';
import 'package:ungteach/states/player_video.dart';
import 'package:ungteach/states/register.dart';

final Map<String, WidgetBuilder> routes = {
  '/authen': (BuildContext context) => Authen(),
  '/register': (BuildContext context) => Register(),
  '/myService': (BuildContext context) => MyService(),
  '/playerVideo': (BuildContext context) {return PlayerVideo();},
};
