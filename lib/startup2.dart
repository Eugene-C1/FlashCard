import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import 'startup3.dart';

class StartupPage2 extends StatefulWidget {
  const StartupPage2({Key? key}) : super(key: key);

  @override
  _StartupPage2State createState() => _StartupPage2State();
}

class _StartupPage2State extends State<StartupPage2> {
  final _text = TextEditingController();
  bool _validate = false;

  @override
  void dispose() {
    _text.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          reverse: true,
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 32,
                ),
                margin: EdgeInsets.only(
                  top: 100,
                ),
                child: Center(
                  child: Image.asset('assets/images/startup2.png'),
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(
                  top: 75,
                  left: 51.5,
                ),
                child: Text(
                  'What\'s your name?',
                  style: TextStyle(
                    color: Color(0xFFB76A185),
                    fontSize: 24,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  top: 25,
                  left: 50,
                  right: 50,
                  bottom: 107,
                ),
                child: Column(
                  children: [
                    TextField(
                      controller: _text,
                      decoration: InputDecoration(
                        hintText: 'Name',
                        labelStyle: TextStyle(color: Colors.black),
                        border: OutlineInputBorder(),
                        errorText: _validate ? 'Name can\'t be empty' : null,
                      ),
                    )
                  ],
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
                      setState(
                        () {
                          _text.text.isEmpty
                              ? _validate = true
                              : _validate = false;
                          if (!_validate) {
                            Navigator.push(
                              context,
                              PageTransition(
                                type: PageTransitionType.fade,
                                child: StartupPage3(),
                              ),
                            );
                          }
                        },
                      );
                    },
                    child: Center(
                      child: Text(
                        'Next',
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
