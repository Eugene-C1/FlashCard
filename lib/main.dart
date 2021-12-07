import 'package:flashcard/flashcardpage.dart';
import 'package:flashcard/quizpage.dart';
import 'package:flashcard/resultpage.dart';
import 'package:flashcard/startup1.dart';
import 'package:flashcard/startup2.dart';
import 'package:flashcard/startup3.dart';
import 'package:flashcard/startup4.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import 'listpage.dart';
import 'profile.dart';
import 'splash.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class MyColor {
  static const MaterialColor discordPurple = MaterialColor(
    0xFFA69EBE,
    <int, Color>{
      50: Color(0xFFA69EBE),
      100: Color(0xFFA69EBE),
      200: Color(0xFFA69EBE),
      300: Color(0xFFA69EBE),
      400: Color(0xFFA69EBE),
      500: Color(0xFFA69EBE),
      600: Color(0xFFA69EBE),
      700: Color(0xFFA69EBE),
      800: Color(0xFFA69EBE),
      900: Color(0xFFA69EBE),
    },
  );
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: "Nunito"),
      routes: <String, WidgetBuilder>{
        '/start1': (BuildContext context) => StartupPage(title: 'Start Up'),
        '/start2': (BuildContext context) => StartupPage2(),
        '/start3': (BuildContext context) => StartupPage3(),
        '/start4': (BuildContext context) => StartupPage4(),
        '/home': (BuildContext context) => MyHomePage(),
        '/listpage': (BuildContext context) => ListPage(),
        '/flashcardpage': (BuildContext context) => FlashCardPage(),
        '/quizpage': (BuildContext context) => QuizPage(title: 'Quiz'),
        '/resultpage': (BuildContext context) => ResultPage(),
      },
      home: Splash(),
    );
  }
}

// Future<void> precacheImage(
//   ImageProvider<Object>provider, BuildContext context, {Size? size, ImageErrorListener? onError}
// )

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  DateTime pre_backpress = DateTime.now();
  // Image? main_menu;

  @override
  void didChangeDependencies() {
    precacheImage(AssetImage('assets/images/main_menu.gif'), context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //leadingWidth: 0,
        titleSpacing: 21,
        title: Text('Flashcard'),
        //centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xFFB2F3136),
        elevation: 0.0,
      ),
      body: WillPopScope(
        onWillPop: () async {
          final timegap = DateTime.now().difference(pre_backpress);
          final cantExit = timegap >= Duration(seconds: 2);
          pre_backpress = DateTime.now();
          if (cantExit) {
            final snack = SnackBar(
              content: Text('Press Back button again to Exit'),
              duration: Duration(seconds: 2),
            );
            ScaffoldMessenger.of(context).showSnackBar(snack);
            return false;
          } else {
            return false;
          }
        },
        child: MaterialApp(
          theme: ThemeData(
            primarySwatch: MyColor.discordPurple,
          ),
          home: Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Color(0xFFB222629),
            body: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 18,
                    ),
                    margin: EdgeInsets.only(
                      top: 25,
                    ),
                    child: Center(
                      child: Image.asset('assets/images/main_menu.gif'),
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
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => ID(),
                                  ),
                                );
                              },
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
                        margin: EdgeInsets.only(top: 30, right: 22),
                        child: Stack(
                          children: <Widget>[
                            Image(
                              image: AssetImage('assets/images/flashcard.png'),
                            ),
                            Positioned.fill(
                              child: Material(
                                borderRadius: BorderRadius.circular(32),
                                color: Colors.transparent,
                                clipBehavior: Clip.hardEdge,
                                child: InkWell(
                                  onTap: () {
                                    Navigator.pushReplacement(
                                      context,
                                      PageTransition(
                                        type: PageTransitionType.rightToLeft,
                                        child: ListPage(),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 30),
                        child: Stack(
                          children: <Widget>[
                            Image(
                              image: AssetImage('assets/images/quiz.png'),
                            ),
                            Positioned.fill(
                              child: Material(
                                borderRadius: BorderRadius.circular(32),
                                color: Colors.transparent,
                                clipBehavior: Clip.hardEdge,
                                child: InkWell(
                                  onTap: () {},
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Container(
                      //   margin: EdgeInsets.only(
                      //     left: 5,
                      //     top: 30,
                      //   ),
                      //   height: 175,
                      //   width: 175,
                      //   child: Material(
                      //     borderRadius: BorderRadius.circular(32),
                      //     clipBehavior: Clip.hardEdge,
                      //     color: Color(0xFFB76A185),
                      //     child: InkWell(
                      //       onTap: () {},
                      //     ),
                      //   ),
                      // ),
                      // Container(
                      //   margin: EdgeInsets.only(
                      //     left: 20,
                      //     top: 30,
                      //   ),
                      //   height: 175,
                      //   width: 175,
                      //   child: Material(
                      //     borderRadius: BorderRadius.circular(32),
                      //     clipBehavior: Clip.hardEdge,
                      //     color: Color(0xFFBB35136),
                      //     child: InkWell(
                      //       onTap: () {},
                      //     ),
                      //   ),
                      // ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
