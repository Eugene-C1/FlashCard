import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flashcard/startup.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import 'startup.dart';

class Splash extends StatelessWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: AnimatedSplashScreen(
        backgroundColor: Colors.white,
        splash: 'assets/images/splashlogo.png',
        //splashTransition: SplashTransition.fadeTransition,
        pageTransitionType: PageTransitionType.fade,
        duration: 3000,
        nextScreen: StartupPage(title: 'Home'),
      ),
    );
  }
}
