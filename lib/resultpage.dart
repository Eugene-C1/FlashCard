import 'package:flashcard/main.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'sql_helper.dart';
import 'sharedpreferences.dart';
import 'listpage.dart';

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
  }

  @override
  Widget build(BuildContext context) {
    int? count = _journals.length;
    int totalPoints = points + score;
    double percentage = (totalPoints / 100);
    String finalPoints = (percentage * 100).toStringAsFixed(2);

    return WillPopScope(
      onWillPop: () async {
        final snack = SnackBar(
          content: Text('Not Allowed to go back'),
          duration: Duration(seconds: 2),
        );
        ScaffoldMessenger.of(context).showSnackBar(snack);
        return false;
      },
      child: Material(
        child: Scaffold(
          backgroundColor: Colors.white,
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
                  // margin: EdgeInsets.only(
                  //   bottom: 122,
                  // ),
                  child: Center(
                    child: Image.asset('assets/images/resultpage.jpg'),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    top: 60,
                  ),
                  child: Center(
                    child: Text(
                      'Congratulations!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        //color: Color(0xFFB76A185),
                        fontSize: 30,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  child: Center(
                    child: Text('You Scored $score / $count'),
                  ),
                ),
                Center(
                  child: Text('You gained a total of $score% level'),
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
                      progressColor: Colors.orange,
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
              int count = 0;
              points = points + score;
              MySharedPreferences.instance.setIntegerValue('score', 0);
              MySharedPreferences.instance.setIntegerValue('points', points);
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => const ListPage(),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
