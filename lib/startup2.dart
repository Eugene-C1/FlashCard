import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:path/path.dart' as Path;
import 'package:sqflite/sqflite.dart';

import 'sharedpreferences.dart';
import 'main.dart';
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
  void didChangeDependencies() {
    precacheImage(AssetImage('assets/images/start2.gif'), context);
    super.didChangeDependencies();
    // main_menu = Image.asset('assets/images/main_menu.gif');
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacementNamed(context, '/start1');
        return false;
      },
      child: MaterialApp(
        theme: ThemeData(
          primarySwatch: MyColor.discordPurple,
        ),
        home: Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: Color(0xFFB222629),
          body: SingleChildScrollView(
            reverse: true,
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 32,
                  ),
                  margin: EdgeInsets.only(
                    top: 60,
                  ),
                  child: Center(
                    child: Image.asset(
                      'assets/images/start2.gif',
                      width: 276,
                      height: 382,
                    ),
                  ),
                ),
                Center(
                  child: Container(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.only(
                      top: 58,
                      left: 51.5,
                    ),
                    child: Text(
                      'What\'s your name?',
                      style: TextStyle(
                        color: Color(0xFFBA69EBE),
                        fontSize: 24,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    top: 16,
                    left: 50,
                    right: 50,
                    bottom: 101,
                  ),
                  child: Column(
                    children: [
                      TextField(
                        controller: _text,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                        decoration: InputDecoration(
                          hintText: 'Name',
                          hintStyle: TextStyle(color: Colors.white),
                          filled: true,
                          fillColor: Color(0xFFB36393F),
                          //border: OutlineInputBorder(),
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
                    color: Color(0xFFBA69EBE),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(50),
                      onTap: () async {
                        MySharedPreferences.instance
                            .setStringValue('name', _text.text);
                        setState(
                          () {
                            _text.text.isEmpty
                                ? _validate = true
                                : _validate = false;
                            if (!_validate) {
                              Navigator.pushReplacementNamed(
                                  context, '/start3');
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
      ),
    );
  }
}
