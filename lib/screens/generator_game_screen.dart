import 'dart:math';
import 'package:flutter/material.dart';

class NumberGame extends StatefulWidget {
  @override
  _NumberGameState createState() => _NumberGameState();
}

class _NumberGameState extends State<NumberGame> {
  final Random _random = Random();
  int number1 = 0;
  int number2 = 0;
  int correctAnswers = 0;
  int incorrectAnswers = 0;
  int totalPlays = 0;

  @override
  void initState() {
    super.initState();
    generateNumbers();
  }

  void generateNumbers() {
    number1 = _random.nextInt(100) + 1;
    number2 = _random.nextInt(100) + 1;
    while (number1 == number2) {  // Ensure numbers are not the same
      number2 = _random.nextInt(100) + 1;
    }
  }

  void checkAnswer(bool isCorrect) {
    if (totalPlays < 10) {
      setState(() {
        if (isCorrect) {
          correctAnswers++;
        } else {
          incorrectAnswers++;
        }
        totalPlays++;
        if (totalPlays < 10) {
          generateNumbers();
        }
      });
    }
  }

  void restartGame() {
    setState(() {
      correctAnswers = 0;
      incorrectAnswers = 0;
      totalPlays = 0;
      generateNumbers();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Number Generator Game'),
        centerTitle: true,
      ),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (totalPlays < 10) ...[
              Text('Choose the larger number', style: TextStyle(fontSize: 22)),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  ElevatedButton(
                    onPressed: () => checkAnswer(number1 > number2),
                    child: Text('$number1', style: TextStyle(fontSize: 24)),
                  ),
                  ElevatedButton(
                    onPressed: () => checkAnswer(number2 > number1),
                    child: Text('$number2', style: TextStyle(fontSize: 24)),
                  ),
                ],
              ),
            ] else ...[
              Text('Game Over', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              SizedBox(height: 20),
              Text('Correct answers: $correctAnswers', style: TextStyle(fontSize: 18)),
              Text('Incorrect answers: $incorrectAnswers', style: TextStyle(fontSize: 18)),
            ],
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: restartGame,
              child: Text('Restart', style: TextStyle(fontSize: 20)),
            ),
          ],
        ),
      ),
    );
  }
}