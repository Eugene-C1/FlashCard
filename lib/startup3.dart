import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import 'startup4.dart';

class StartupPage3 extends StatefulWidget {
  const StartupPage3({Key? key}) : super(key: key);

  @override
  _StartupPage3State createState() => _StartupPage3State();
}

class _StartupPage3State extends State<StartupPage3> {
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
                child: Center(
                  child: Text(
                    'Gender',
                    style: TextStyle(
                      color: Color(0xFFB76A185),
                      fontSize: 24,
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    PageTransition(
                      type: PageTransitionType.rightToLeft,
                      child: StartupPage4(),
                    ),
                  );
                },
                child: Container(
                  margin: EdgeInsets.only(
                    top: 45,
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: 32,
                  ),
                  child: Center(
                    child: Image.asset('assets/images/boy.png'),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    PageTransition(
                      type: PageTransitionType.rightToLeft,
                      child: StartupPage4(),
                    ),
                  );
                },
                child: Container(
                  margin: EdgeInsets.only(
                    top: 45,
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: 32,
                  ),
                  child: Center(
                    child: Image.asset('assets/images/girl.png'),
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
