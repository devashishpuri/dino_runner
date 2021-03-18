import 'package:flutter/material.dart';

class GameOverMenu extends StatelessWidget {
  final VoidCallback onRestartClicked;
  final int finalScore;

  GameOverMenu(this.finalScore, this.onRestartClicked);

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return Container(
        color: Colors.black45,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Game Over',
                style: Theme.of(context)
                    .textTheme
                    .headline5
                    .copyWith(color: Colors.white),
              ),
              SizedBox(height: 16),
              Text(
                'Your score is: $finalScore',
                style: Theme.of(context)
                    .textTheme
                    .headline6
                    .copyWith(color: Colors.white),
              ),
              SizedBox(height: 24),
              IconButton(
                icon: Icon(
                  Icons.refresh,
                  color: Colors.white,
                  size: 36,
                ),
                onPressed: onRestartClicked,
              )
            ],
          ),
        ),
      );
    });
  }
}
