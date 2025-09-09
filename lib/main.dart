import 'package:fairly_odd_runner/src/components/components.dart';
import 'package:fairly_odd_runner/src/fairly_odd_runner.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

void main() {
  final myGame = FairlyOddRunner();
  runApp(
    GameWidget(
      game: myGame,
      overlayBuilderMap: {
        'GameOver': (ctx, game) => GameOver(
              game: myGame,
            ),
      },
    ),
  );
}
