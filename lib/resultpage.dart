import 'package:flashcard/main.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:page_transition/page_transition.dart';

import 'sql_helper.dart';
import 'sharedpreferences.dart';
import 'listpage.dart';
import 'flashcardpage.dart';

class ResultPage extends StatefulWidget {
  const ResultPage({Key? key}) : super(key: key);

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  List<Map<String, dynamic>> _journals = [];

  bool _isLoading = true;

  // This function is used to fetch all data from the database
  void _refreshJournals() async {
    final data = await SQLHelper.getItems();
    setState(() {
      _journals = data;
      _isLoading = false;
    });
  }

  int score = 0;
  int points = 0;
  int rank = 0;
  @override
  void initState() {
    super.initState();
    _refreshJournals();

    MySharedPreferences.instance
        .getIntegerValue("score")
        .then((value) => setState(() {
              score = value;
            }));

    MySharedPreferences.instance
        .getIntegerValue("points")
        .then((value) => setState(() {
              points = value;
            }));

    MySharedPreferences.instance
        .getIntegerValue("rank")
        .then((value) => setState(() {
              rank = value;
            }));
  }

  @override
  void didChangeDependencies() {
    precacheImage(AssetImage('assets/images/success.gif'), context);
    precacheImage(AssetImage('assets/images/fail.gif'), context);

    super.didChangeDependencies();
    // main_menu = Image.asset('assets/images/main_menu.gif');
  }

  @override
  Widget build(BuildContext context) {
    int? count = _journals.length;
    int totalPoints = points + score;
    double percentage = (totalPoints / 100);
    double check = 0.7 * count;
    double scorePercent = (score / count) * 100;

    if (percentage >= 1) {
      percentage = 1;
    }

    String finalPoints = (percentage * 100).toStringAsFixed(2);

    if (scorePercent < check) {
      return WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: MaterialApp(
          theme: ThemeData(
            primarySwatch: MyColor.discordPurple,
          ),
          home: Scaffold(
              backgroundColor: Color(0xFFB222629),
              body: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 32,
                      ),
                      margin: EdgeInsets.only(
                        top: 100,
                      ),
                      child: Center(
                        child: Image.asset('assets/images/fail.gif'),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        top: 60,
                      ),
                      child: Center(
                        child: Text(
                          'Fail!',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10),
                      child: Center(
                        child: Text('You Scored $score / $count',
                            style: TextStyle(color: Colors.white)),
                      ),
                    ),
                    Center(
                      child: Text('You must score more than 70%',
                          style: TextStyle(color: Colors.white)),
                    ),
                    Center(
                      child: Text(
                          'Click the button to review and retry the quiz',
                          style: TextStyle(color: Colors.white)),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 80, bottom: 50),
                      padding: EdgeInsets.all(15),
                      //margin: EdgeInsets.symmetric(),
                      child: Padding(
                        padding: EdgeInsets.all(10.0),
                        child: LinearPercentIndicator(
                          width: MediaQuery.of(context).size.width - 50,
                          animation: true,
                          lineHeight: 25.0,
                          animationDuration: 2500,
                          percent: percentage,
                          center: Text(
                            '$finalPoints%',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          linearStrokeCap: LinearStrokeCap.roundAll,
                          progressColor: Color(0xFFB7289DA),
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
                            Navigator.pushReplacement(
                              context,
                              PageTransition(
                                type: PageTransitionType.fade,
                                child: FlashCardPage(),
                              ),
                            );
                          },
                          child: Center(
                            child: Text(
                              'Retry',
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
              )),
        ),
      );
    } else {
      return WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: MaterialApp(
          theme: ThemeData(
            primarySwatch: MyColor.discordPurple,
          ),
          home: Scaffold(
            backgroundColor: Color(0xFFB222629),
            body: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 32,
                    ),
                    margin: EdgeInsets.only(
                      top: 100,
                    ),
                    child: Center(
                      child: Image.asset('assets/images/success.gif'),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      top: 110,
                    ),
                    child: Center(
                      child: Text(
                        'Congratulations!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    child: Center(
                      child: Text('You Scored $score / $count',
                          style: TextStyle(color: Colors.white)),
                    ),
                  ),
                  Center(
                    child: Text('You gained a total of $score% level',
                        style: TextStyle(color: Colors.white)),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 50),
                    padding: EdgeInsets.all(15),
                    //margin: EdgeInsets.symmetric(),
                    child: Padding(
                      padding: EdgeInsets.all(10.0),
                      child: LinearPercentIndicator(
                        width: MediaQuery.of(context).size.width - 50,
                        animation: true,
                        lineHeight: 25.0,
                        animationDuration: 2500,
                        percent: percentage,
                        center: Text(
                          '$finalPoints%',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        linearStrokeCap: LinearStrokeCap.roundAll,
                        progressColor: Color(0xFFB7289DA),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            floatingActionButton: new FloatingActionButton(
              heroTag: 'Next Page Button',
              child: Icon(Icons.check),
              onPressed: () {
                if (percentage * 100 == 100) {
                  points = 0;
                  if (rank == 4) {
                    MySharedPreferences.instance.setIntegerValue('score', 0);
                    MySharedPreferences.instance
                        .setIntegerValue('points', points);
                    MySharedPreferences.instance.setIntegerValue('rank', rank);
                  } else {
                    rank = rank + 1;
                    MySharedPreferences.instance.setIntegerValue('score', 0);
                    MySharedPreferences.instance
                        .setIntegerValue('points', points);
                    MySharedPreferences.instance.setIntegerValue('rank', rank);
                    Navigator.pushReplacementNamed(context, '/listpage');
                  }
                } else {
                  int count = 0;
                  points = points + score;
                  MySharedPreferences.instance.setIntegerValue('score', 0);
                  MySharedPreferences.instance
                      .setIntegerValue('points', points);
                  Navigator.pushReplacementNamed(context, '/listpage');
                }
              },
            ),
          ),
        ),
      );
    }
  }
}
