import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import 'sharedpreferences.dart';

class ID extends StatefulWidget {
  @override
  State<ID> createState() => _IDState();
}

class _IDState extends State<ID> {
  String name = '';
  String gender = '';
  int points = 0;
  int score = 0;

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
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: Text('Profile'),
        centerTitle: true,
        backgroundColor: Colors.grey[850],
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
                progressColor: Colors.orange,
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
                color: Color(0xFFB76A185),
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
                color: Color(0xFFB76A185),
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
              'Beginner',
              style: TextStyle(
                //color: Colors.amberAccent[200],
                color: Color(0xFFB76A185),
                letterSpacing: 2.0,
                fontSize: 28.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            // SizedBox(height: 30.0),
            // Row(
            //   children: <Widget>[
            //     Icon(
            //       Icons.email,
            //       color: Colors.grey[400],
            //     ),
            //     Text(
            //       'kaimosalalima@gmail.com',
            //       style: TextStyle(
            //         //color: Colors.grey[400],
            //         fontSize: 18.0,
            //         letterSpacing: 1.0,
            //       ),
            //     ),
            //   ],
            // ),
          ],
        ),
      ),
    );
  }
}
