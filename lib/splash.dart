import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:after_layout/after_layout.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dart:async';

import 'main.dart';
import 'startup1.dart';

class Splash extends StatelessWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: AnimatedSplashScreen(
        backgroundColor: Color(0xFFB222629),
        splash: 'assets/images/splashlogo.png',
        splashIconSize: 200,
        //splashTransition: SplashTransition.fadeTransition,
        pageTransitionType: PageTransitionType.fade,
        duration: 3000,
        nextScreen: Check(),
      ),
    );
  }
}

class Check extends StatefulWidget {
  const Check({Key? key}) : super(key: key);

  @override
  _CheckState createState() => _CheckState();
}

class _CheckState extends State<Check> with AfterLayoutMixin<Check> {
  Future checkFirstSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool _seen = (prefs.getBool('seen') ?? false);

    if (_seen) {
      Navigator.of(context).pushReplacement(
        new MaterialPageRoute(
          builder: (context) => MyHomePage(),
          // NOTE: Changeback to MyHomePage() !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
        ),
      );
    } else {
      //await prefs.setBool('seen', true);
      Navigator.of(context).pushReplacement(
        new MaterialPageRoute(
          builder: (context) => StartupPage(title: 'Start Up'),
        ),
      );
    }
  }

  @override
  void afterFirstLayout(BuildContext context) => checkFirstSeen();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Center(
        child: new Text('Loading ......'),
      ),
    );
  }
}
