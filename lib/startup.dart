import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import 'package:flashcard/home.dart';

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
        //backgroundColor: Colors.white,
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
                          color: Color(0xFFB40284A),
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
                          color: Color(0xFFB40284A),
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 32),
                margin: EdgeInsets.only(
                  bottom: 50,
                ),
                child: Center(
                  child: Image.asset('assets/images/startup.png'),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    PageTransition(
                      type: PageTransitionType.fade,
                      child: MyHomePage(title: 'Home'),
                    ),
                  );
                },
                child: Container(
                  margin: EdgeInsets.all(32),
                  padding: EdgeInsets.all(20),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Color(0xFFB40284A),
                    borderRadius: BorderRadius.circular(50),
                  ),
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
            ],
          ),
        ),
      ),
    );
  }
}
