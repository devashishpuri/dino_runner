import 'package:dino_runner/screens/game.screen.dart';
import 'package:dino_runner/screens/home.screen.dart';
import 'package:flame/flame.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Flame.util.fullScreen();
  await Flame.util.setLandscape();
  runApp(DinoRunner());
}

class DinoRunner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'PressStart2P'),
      // home: HomeScreen(),
      home: GameScreen(),
    );
  }
}
