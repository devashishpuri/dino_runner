import 'package:dino_runner/game/dino.component.dart';
import 'package:dino_runner/game/game.dart';
import 'package:flutter/material.dart';

class GameHud extends StatelessWidget {
  final VoidCallback onPauseClick;
  final Dino dino;

  GameHud(this.dino, this.onPauseClick);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        children: [
          Spacer(flex: 1),
          ValueListenableBuilder(
              valueListenable: dino.lives,
              builder: (context, value, child) {
                return Row(
                    children: List.generate(
                        DINO_LIVES,
                        (index) => Icon(
                              value <= index
                                  ? Icons.favorite_border
                                  : Icons.favorite,
                              color: GamePallete.hudColor,
                            )).toList());
              }),
          SizedBox(width: 8),
          IconButton(
            icon: Icon(
              Icons.pause,
              color: GamePallete.hudColor,
            ),
            onPressed: onPauseClick,
          ),
        ],
      ),
    );
  }
}
