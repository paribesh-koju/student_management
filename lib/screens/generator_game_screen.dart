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
  final int maxPlays = 10;

  @override
  void initState() {
    super.initState();
    generateNumbers();
  }

  void generateNumbers() {
    number1 = _random.nextInt(100) + 1;
    number2 = _random.nextInt(100) + 1;
    while (number1 == number2) {
      // Ensure numbers are not the same
      number2 = _random.nextInt(100) + 1;
    }
  }

  void checkAnswer(bool isCorrect) {
    if (totalPlays < maxPlays) {
      setState(() {
        if (isCorrect) {
          correctAnswers++;
        } else {
          incorrectAnswers++;
        }
        totalPlays++;
        if (totalPlays < maxPlays) {
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
        title: const Text('Number Generator Game'),
        centerTitle: true,
        backgroundColor: Colors.limeAccent,
      ),
      body: Container(
        color: Colors.lime,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              if (totalPlays < maxPlays) ...[
                const Text('Choose the larger number',
                    style: TextStyle(fontSize: 22)),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white),
                      onPressed: () => checkAnswer(number1 > number2),
                      child: Text('$number1',
                          style: const TextStyle(fontSize: 24)),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white),
                      onPressed: () => checkAnswer(number2 > number1),
                      child: Text('$number2',
                          style: const TextStyle(fontSize: 24)),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Text('Questions done: $totalPlays',
                    style: const TextStyle(fontSize: 18)),
                Text('Questions remaining: ${maxPlays - totalPlays}',
                    style: const TextStyle(fontSize: 18)),
              ] else ...[
                const Text('Game Stats',
                    style:
                    TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                const SizedBox(height: 20),
                Text('Correct answers: $correctAnswers',
                    style: const TextStyle(fontSize: 18)),
                Text('Incorrect answers: $incorrectAnswers',
                    style: const TextStyle(fontSize: 18)),
              ],
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.cyanAccent),
                onPressed: restartGame,
                child: const Text('Restart', style: TextStyle(fontSize: 20)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}