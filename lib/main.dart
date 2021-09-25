import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import 'splash.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: "Nunito"),
      home: Splash(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.only(
                    top: 45,
                  ),
                  padding: EdgeInsets.only(
                    left: 56,
                  ),
                  child: Text(
                    'Name',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 30,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 18,
                  ),
                  margin: EdgeInsets.only(
                    top: 25,
                  ),
                  child: Center(
                    child: Image.asset('assets/images/girlSitting.png'),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    top: 60,
                  ),
                  child: Stack(
                    children: <Widget>[
                      Image(
                        image: AssetImage(
                          'assets/images/profile.png',
                        ),
                      ),
                      Positioned.fill(
                        child: Material(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(32),
                          clipBehavior: Clip.hardEdge,
                          child: InkWell(
                            onTap: () {},
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(
                        left: 5,
                        top: 30,
                      ),
                      height: 175,
                      width: 175,
                      child: Material(
                        borderRadius: BorderRadius.circular(32),
                        clipBehavior: Clip.hardEdge,
                        color: Color(0xFFB76A185),
                        child: InkWell(
                          onTap: () {},
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        left: 20,
                        top: 30,
                      ),
                      height: 175,
                      width: 175,
                      child: Material(
                        borderRadius: BorderRadius.circular(32),
                        clipBehavior: Clip.hardEdge,
                        color: Color(0xFFBB35136),
                        child: InkWell(
                          onTap: () {},
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
