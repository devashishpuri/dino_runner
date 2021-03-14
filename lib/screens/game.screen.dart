import 'package:dino_runner/game/game.dart';
import 'package:flutter/material.dart';

class GameScreen extends StatefulWidget {
  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  final game = DinoRunnerGame();
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: game.widget);
  }
}
