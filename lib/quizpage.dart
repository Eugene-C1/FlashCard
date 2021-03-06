import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:quiver/async.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'main.dart';
import 'flashcard_view.dart';
import 'resultpage.dart';
import 'sql_helper.dart';
import 'sharedpreferences.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({Key? key, required String title}) : super(key: key);

  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> with TickerProviderStateMixin {
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

  String controller = '';
  bool check = false;
  int score = 0;
  int _currentIndex = 0;
  int points = 0;

  @override
  void initState() {
    super.initState();
    _refreshJournals();

    _controller = AnimationController(
        vsync: this,
        duration: Duration(
            seconds:
                levelClock) // gameData.levelClock is a user entered number elsewhere in the applciation
        );

    _controller.forward();

    _controller.addStatusListener(
      (status) {
        if (status == AnimationStatus.completed) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => ResultPage(),
            ),
          );
        }
      },
    ); // Loading the diary when the app starts
  }

  late AnimationController _controller;
  int levelClock = 600;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("Cancel", style: TextStyle(color: MyColor.discordPurple)),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = TextButton(
      child: Text("Continue", style: TextStyle(color: MyColor.discordPurple)),
      onPressed: () {
        controller = _answerController.text.toString();
        check = _journals[_currentIndex]['answer'] == controller;

        if (check) {
          score++;
          MySharedPreferences.instance.setIntegerValue('score', score);
          MySharedPreferences.instance.setIntegerValue('counter', score);
        }
        Navigator.pushReplacementNamed(context, '/resultpage');
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      backgroundColor: Color(0xFFB2F3136),
      title: Text("Alert", style: TextStyle(color: Colors.white)),
      content: Text("Would you like to submit your answer?",
          style: TextStyle(color: Colors.white)),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  TextEditingController _answerController = new TextEditingController();
  TextEditingController _oldAnswerController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    int? count = _journals.length;
    int currentNumber = _currentIndex + 1;
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacementNamed(context, '/flashcardpage');
        return false;
      },
      child: MaterialApp(
        theme: ThemeData(
          primarySwatch: MyColor.discordPurple,
        ),
        home: Scaffold(
          backgroundColor: Color(0xFFB222629),
          body: _isLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Center(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Row(
                          //mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              '$currentNumber / $count',
                              style: TextStyle(color: Colors.white),
                            ),
                            Countdown(
                              animation: StepTween(
                                begin:
                                    levelClock, // THIS IS A USER ENTERED NUMBER
                                end: 0,
                              ).animate(_controller),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 250,
                          height: 250,
                          child: FlipCard(
                            front: FlashcardView(
                              text: _journals[_currentIndex]['question'],
                            ),
                            back: Container(
                              decoration: BoxDecoration(
                                color: Color(0xFFB2F3136),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(4.0),
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.white.withOpacity(0.4),
                                    spreadRadius: .1,
                                    blurRadius: .1,
                                    offset: Offset(
                                        0.0, 0), // changes position of shadow
                                  ),
                                ],
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 30),
                                    child: TextField(
                                      controller: _answerController,
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                      decoration: InputDecoration(
                                        hintText: 'Enter Answer',
                                        hintStyle:
                                            TextStyle(color: Colors.white),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: Color(0xFFBA69EBE)),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: Color(0xFFBA69EBE)),
                                        ),
                                        filled: true,
                                        fillColor: Color(0xFFB36393F),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            OutlinedButton.icon(
                              onPressed: showPreviousCard,
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                Color(0xFFB2F3136),
                              )),
                              icon:
                                  Icon(Icons.chevron_left, color: Colors.white),
                              label: Text('Prev',
                                  style: TextStyle(color: Colors.white)),
                            ),
                            OutlinedButton.icon(
                              onPressed: showNextCard,
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                Color(0xFFB2F3136),
                              )),
                              icon: Icon(Icons.chevron_right,
                                  color: Colors.white),
                              label: Text('Next',
                                  style: TextStyle(color: Colors.white)),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
          floatingActionButton: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FloatingActionButton(
                //backgroundColor: Color(0xFFB76A185),
                heroTag: 'Next Page Button',
                child: Icon(Icons.check),
                onPressed: () {
                  // Navigator.of(context).push(
                  //   MaterialPageRoute(
                  //     builder: (context) => const ResultPage(),
                  //   ),
                  // );

                  showAlertDialog(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showNextCard() {
    setState(
      () {
        controller = _answerController.text.toString();
        check = _journals[_currentIndex]['answer'] == controller;

        if (check && _currentIndex + 1 < _journals.length) {
          score++;
          MySharedPreferences.instance.setIntegerValue('score', score);
          MySharedPreferences.instance.setIntegerValue('counter', score);
          //MySharedPreferences.instance.setIntegerValue('score', score);
        }

        // _currentIndex =
        //     (_currentIndex + 1 < _journals.length) ? _currentIndex + 1 : 0;
        if (_currentIndex + 1 < _journals.length) {
          _currentIndex = _currentIndex + 1;
          _answerController.clear();
        }
      },
    );
  }

  void showPreviousCard() {
    setState(
      () {
        if (score != 0) {
          score--;
          MySharedPreferences.instance.setIntegerValue('score', score);
          MySharedPreferences.instance.setIntegerValue('counter', score);
        }
        //MySharedPreferences.instance.setIntegerValue('score', score);

        // _currentIndex =
        //     (_currentIndex - 1 >= 0) ? _currentIndex - 1 : _journals.length - 1;
        if (_currentIndex > 0) {
          _currentIndex = _currentIndex - 1;
        }
        //_answerController.text = controller;
      },
    );
  }
}

class Countdown extends AnimatedWidget {
  Countdown({Key? key, required this.animation})
      : super(key: key, listenable: animation);
  Animation<int> animation;

  @override
  build(BuildContext context) {
    Duration clockTimer = Duration(seconds: animation.value);

    String timerText =
        '${clockTimer.inMinutes.remainder(60).toString()}:${clockTimer.inSeconds.remainder(60).toString().padLeft(2, '0')}';

    print('animation.value  ${animation.value} ');
    print('inMinutes ${clockTimer.inMinutes.toString()}');
    print('inSeconds ${clockTimer.inSeconds.toString()}');
    print(
        'inSeconds.remainder ${clockTimer.inSeconds.remainder(60).toString()}');

    return Text(
      "$timerText",
      style: TextStyle(
        fontSize: 20,
        color: Colors.red,
      ),
    );
  }
}
