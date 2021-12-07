import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import 'sharedpreferences.dart';

class ID extends StatefulWidget {
  @override
  State<ID> createState() => _IDState();
}

class _IDState extends State<ID> {
  List ranks = [
    'Beginner',
    'Great',
    'Expert',
    'Veteran',
    'Ultra',
    'Master',
  ];
  String name = '';
  String gender = '';
  int points = 0;
  int score = 0;
  int rank = 0;

  @override
  void initState() {
    super.initState(); // Loading the diary when the app starts
    MySharedPreferences.instance
        .getStringValue("name")
        .then((value) => setState(() {
              name = value;
            }));

    MySharedPreferences.instance
        .getStringValue("gender")
        .then((value) => setState(() {
              gender = value;
            }));

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
    precacheImage(AssetImage('assets/images/boy.png'), context);
    precacheImage(AssetImage('assets/images/girl.png'), context);

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    int totalPoints = points + score;
    double percentage = (totalPoints / 100);
    String finalPoints = (percentage * 100).toStringAsFixed(2);
    String imagePath = '';

    if (gender == 'Male') {
      imagePath = 'assets/images/boy.png';
    } else {
      imagePath = 'assets/images/girl.png';
    }
    return Scaffold(
      backgroundColor: Color(0xFFB222629),
      appBar: AppBar(
        title: Text('Profile'),
        centerTitle: true,
        backgroundColor: Color(0xFFB2F3136),
        elevation: 0.0,
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 40.0, bottom: 0.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(
              child: CircleAvatar(
                backgroundImage: AssetImage(imagePath),
                radius: 40.0,
              ),
            ),
            Container(
              padding: EdgeInsets.all(20),
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
            Divider(
              height: 90.0,
              color: Colors.grey[800],
            ),
            Text(
              'Name',
              style: TextStyle(
                color: Colors.grey,
                letterSpacing: 2.0,
              ),
            ),
            SizedBox(height: 10.0),
            Text(
              name,
              style: TextStyle(
                //color: Colors.amberAccent[200],
                color: Color(0xFFBA69EBE),
                letterSpacing: 2.0,
                fontSize: 28.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10.0),
            Text(
              'Gender',
              style: TextStyle(
                color: Colors.grey,
                letterSpacing: 2.0,
              ),
            ),
            SizedBox(height: 10.0),
            Text(
              gender,
              style: TextStyle(
                //color: Colors.amberAccent[200],
                color: Color(0xFFBA69EBE),
                letterSpacing: 2.0,
                fontSize: 28.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10.0),
            Text(
              'RANK',
              style: TextStyle(
                color: Colors.grey,
                letterSpacing: 2.0,
              ),
            ),
            SizedBox(height: 10.0),
            Text(
              ranks[rank],
              style: TextStyle(
                //color: Colors.amberAccent[200],
                color: Color(0xFFBA69EBE),
                letterSpacing: 2.0,
                fontSize: 28.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
