import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import 'main.dart';
import 'sharedpreferences.dart';

class StartupPage4 extends StatefulWidget {
  const StartupPage4({Key? key}) : super(key: key);

  @override
  _StartupPage4State createState() => _StartupPage4State();
}

class _StartupPage4State extends State<StartupPage4> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(
                  top: 90,
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: 32,
                ),
                child: Center(
                  child: Image.asset('assets/images/startup3.png'),
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  top: 45,
                ),
                child: Text(
                  'You\'re all set to go!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFFB76A185),
                    fontSize: 26,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  top: 45,
                  bottom: 116,
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: 64,
                ),
                child: Text(
                  'Your profile is now finish. You can edit your profile later.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFFB76A185),
                    fontSize: 16,
                  ),
                ),
              ),
              Container(
                height: 73,
                width: 336,
                child: Material(
                  borderRadius: BorderRadius.circular(50),
                  color: Color(0xFFB76A185),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(50),
                    onTap: () {
                      MySharedPreferences.instance
                          .setBooeleanValue('seen', true);
                      Navigator.pushReplacement(
                        context,
                        PageTransition(
                          type: PageTransitionType.fade,
                          child: MyHomePage(),
                        ),
                      );
                    },
                    child: Center(
                      child: Text(
                        'Finish',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
