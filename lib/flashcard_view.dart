import 'package:flutter/material.dart';

class FlashcardView extends StatelessWidget {
  final String text;

  const FlashcardView({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xFFB2F3136),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(color: Colors.white),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
