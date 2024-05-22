import 'package:flutter/material.dart';
import 'package:student_management/screens/details_screen.dart';
import 'package:student_management/screens/generator_game_screen.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: NumberGame(),
    );
  }
}
