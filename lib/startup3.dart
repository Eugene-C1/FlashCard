import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import 'sharedpreferences.dart';
import 'main.dart';
import 'startup4.dart';

class StartupPage3 extends StatefulWidget {
  const StartupPage3({Key? key}) : super(key: key);

  @override
  _StartupPage3State createState() => _StartupPage3State();
}

class _StartupPage3State extends State<StartupPage3> {
  @override
  void didChangeDependencies() {
    precacheImage(AssetImage('assets/images/boy.png'), context);
    precacheImage(AssetImage('assets/images/girl.png'), context);

    super.didChangeDependencies();
    // main_menu = Image.asset('assets/images/main_menu.gif');
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacementNamed(context, '/start2');
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
                    top: 90,
                  ),
                  child: Center(
                    child: Text(
                      'Gender',
                      style: TextStyle(
                        color: Color(0xFFBA69EBE),
                        fontSize: 24,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 20),
                  padding: EdgeInsets.symmetric(horizontal: 36),
                  child: Stack(
                    children: <Widget>[
                      Image(
                        image: AssetImage('assets/images/boy.png'),
                      ),
                      Positioned.fill(
                        child: Material(
                          color: Colors.transparent,
                          shape: CircleBorder(),
                          clipBehavior: Clip.hardEdge,
                          child: InkWell(
                            onTap: () {
                              MySharedPreferences.instance
                                  .setStringValue('gender', 'Male');
                              Navigator.pushReplacementNamed(
                                  context, '/start4');
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 20),
                  padding: EdgeInsets.symmetric(horizontal: 32),
                  child: Stack(
                    alignment: Alignment.center,
                    children: <Widget>[
                      Container(
                        alignment: Alignment.center,
                        child: Image(
                          image: AssetImage('assets/images/girl.png'),
                        ),
                      ),
                      Positioned.fill(
                        child: Material(
                          color: Colors.transparent,
                          shape: CircleBorder(),
                          clipBehavior: Clip.hardEdge,
                          child: InkWell(
                            onTap: () {
                              MySharedPreferences.instance
                                  .setStringValue('gender', 'Female');
                              Navigator.pushReplacementNamed(
                                  context, '/start4');
                            },
                          ),
                        ),
                      ),
                    ],
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
