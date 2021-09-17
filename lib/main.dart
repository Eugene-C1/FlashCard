import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flashcard/home.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import 'splash.dart';
import 'home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: AnimatedSplashScreen(
            splash: 'assets/images/study.png',
            duration: 2500,
            splashTransition: SplashTransition.fadeTransition,
            pageTransitionType: PageTransitionType.fade,
            nextScreen: MyHomePage(title: 'Home')));
  }
}
