import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'startup2.dart';

class StartupPage extends StatefulWidget {
  const StartupPage({Key? key, required String title}) : super(key: key);

  @override
  _StartupPageState createState() => _StartupPageState();
}

class _StartupPageState extends State<StartupPage> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                child: Column(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(
                        top: 100,
                      ),
                      child: Text(
                        'Learn Free',
                        style: TextStyle(
                          color: Color(0xFFB76A185),
                          fontSize: 28,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(32),
                      padding: EdgeInsets.symmetric(horizontal: 50),
                      child: Text(
                        'We make reviewing easier. Join now and start your academic journey with us',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFFB76A185),
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 32,
                ),
                margin: EdgeInsets.only(
                  bottom: 122,
                ),
                child: Center(
                  child: Image.asset('assets/images/startup1.png'),
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
                      Navigator.push(
                        context,
                        PageTransition(
                          type: PageTransitionType.fade,
                          child: StartupPage2(),
                        ),
                      );
                    },
                    child: Center(
                      child: Text(
                        'Get Started',
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
