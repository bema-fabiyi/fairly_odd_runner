import 'package:fairly_odd_runner/src/fairly_odd_runner.dart';
import 'package:flutter/material.dart';

class GameOver extends StatelessWidget {
  const GameOver({super.key, required this.game});

  final FairlyOddRunner game;

  @override
  Widget build(BuildContext context) {
    final String gameOver = 'GameOver';

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            child: Image.asset('assets/images/game_over_g.png'),
          ),
          Flexible(
            child: IconButton(
              icon: Image.asset('assets/images/restart.png'),
              onPressed: () {
                game.overlays.remove(gameOver);
              },
            ),
          ),
        ],
      ),
    );
  }
}
