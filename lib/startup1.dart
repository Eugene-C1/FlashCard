import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'main.dart';
import 'startup2.dart';

class StartupPage extends StatefulWidget {
  const StartupPage({Key? key, required String title}) : super(key: key);

  @override
  _StartupPageState createState() => _StartupPageState();
}

class _StartupPageState extends State<StartupPage> {
  @override
  void didChangeDependencies() {
    precacheImage(AssetImage('assets/images/start1.gif'), context);
    super.didChangeDependencies();
    // main_menu = Image.asset('assets/images/main_menu.gif');
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: MaterialApp(
        theme: ThemeData(
          primarySwatch: MyColor.discordPurple,
        ),
        home: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Color(0xFFB202427),
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
                            color: Color(0xFFBA69EBE),
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
                            color: Color(0xFFBA69EBE),
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
                    top: 42,
                    bottom: 89,
                  ),
                  child: Center(
                    child: Image.asset(
                      'assets/images/start1.gif',
                      height: 305,
                      width: 241,
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
                        Navigator.pushReplacementNamed(context, '/start2');
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
      ),
    );
  }
}
