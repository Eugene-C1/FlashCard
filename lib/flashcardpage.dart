import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';
import 'package:sqflite/sqflite.dart';

import 'flashcard.dart';
import 'flashcard_view.dart';
import 'sql_helper.dart';
import 'quizpage.dart';
import 'main.dart';

class FlashCardPage extends StatefulWidget {
  const FlashCardPage({Key? key}) : super(key: key);

  @override
  _FlashCardPageState createState() => _FlashCardPageState();
}

class _FlashCardPageState extends State<FlashCardPage> {
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

  @override
  void initState() {
    super.initState();
    _refreshJournals(); // Loading the diary when the app starts
  }

  //TextEditingController _titleController = new TextEditingController();
  //TextEditingController _descriptionController = new TextEditingController();

  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    int? count = _journals.length;
    int currentNumber = _currentIndex + 1;
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacementNamed(context, '/listpage');
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
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '$currentNumber / $count',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        width: 250,
                        height: 250,
                        child: FlipCard(
                          front: FlashcardView(
                            text: _journals[_currentIndex]['question'],
                          ),
                          back: FlashcardView(
                            text: _journals[_currentIndex]['answer'],
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          OutlinedButton.icon(
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                Color(0xFFB2F3136),
                              )),
                              onPressed: showPreviousCard,
                              icon: Icon(
                                Icons.chevron_left,
                                color: Colors.white,
                              ),
                              label: Text(
                                'Prev',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              )),
                          OutlinedButton.icon(
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                Color(0xFFB2F3136),
                              )),
                              onPressed: showNextCard,
                              icon: Icon(
                                Icons.chevron_right,
                                color: Colors.white,
                              ),
                              label: Text(
                                'Next',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              )),
                        ],
                      ),
                    ],
                  ),
                ),
          floatingActionButton: FloatingActionButton(
            heroTag: 'Next Page Button',
            child: Icon(Icons.check),
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/quizpage');
            },
          ),
        ),
      ),
    );
  }

  void showNextCard() {
    setState(() {
      _currentIndex =
          (_currentIndex + 1 < _journals.length) ? _currentIndex + 1 : 0;
    });
  }

  void showPreviousCard() {
    setState(() {
      _currentIndex =
          (_currentIndex - 1 >= 0) ? _currentIndex - 1 : _journals.length - 1;
    });
  }
}
