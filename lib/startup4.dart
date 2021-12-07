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
  void didChangeDependencies() {
    precacheImage(AssetImage('assets/images/start3.gif'), context);
    super.didChangeDependencies();
    // main_menu = Image.asset('assets/images/main_menu.gif');
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacementNamed(context, '/start3');
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
            child: Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(
                    top: 111,
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: 32,
                  ),
                  child: Center(
                    child: Image.asset(
                      'assets/images/start3.gif',
                      width: 323,
                      height: 312,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    top: 103,
                  ),
                  child: Text(
                    'You\'re all set to go!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFFBA69EBE),
                      fontSize: 26,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    top: 40,
                    bottom: 61,
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: 64,
                  ),
                  child: Text(
                    'Your profile is now finish. You can edit your profile later.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFFBA69EBE),
                      fontSize: 16,
                    ),
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
                      onTap: () {
                        MySharedPreferences.instance
                            .setBooeleanValue('seen', true);
                        Navigator.pushReplacementNamed(context, '/home');
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
      ),
    );
  }
}
