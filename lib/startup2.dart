import 'package:flashcard/home.dart';
import 'package:flashcard/startup3.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

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
              GestureDetector(
                onTap: () {
                  setState(
                    () {
                      _text.text.isEmpty ? _validate = true : _validate = false;
                      if (!_validate) {
                        Navigator.push(
                          context,
                          PageTransition(
                            type: PageTransitionType.rightToLeft,
                            child: StartupPage3(),
                          ),
                        );
                      }
                    },
                  );
                },
                child: Container(
                  margin: EdgeInsets.only(
                    right: 32,
                    left: 32,
                    bottom: 32,
                  ),
                  padding: EdgeInsets.all(20),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Color(0xFFB76A185),
                    borderRadius: BorderRadius.circular(50),
                  ),
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
            ],
          ),
        ),
      ),
    );
  }
}
