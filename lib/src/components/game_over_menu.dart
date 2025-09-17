import 'package:fairly_odd_runner/src/components/components.dart';
import 'package:fairly_odd_runner/src/fairly_odd_runner.dart';
import 'package:flutter/material.dart';

class GameOver extends StatelessWidget {
  const GameOver({super.key, required this.game});

  final FairlyOddRunner game;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/images/game_over_g.png'),
          const SizedBox(height: 15),
          SizedBox(
            height: 90,
            child: IconButton(
              icon: Image.asset(
                'assets/images/restart.png',
              ),
              onPressed: () {
                game.reset();
                game.overlays.remove('GameOver');
                game.resumeEngine();
              },
              //   ),
            ),
          ),
          SizedBox(
            height: 90,
            child: IconButton(
              icon: Image.asset(
                'assets/images/main_menu.png',
              ),
              onPressed: () {
                game.overlays.remove('PauseMenu');
                Navigator.pushReplacement(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation1, animation2) =>
                        MainMenu(),
                    transitionDuration: Duration.zero,
                    reverseTransitionDuration: Duration.zero,
                  ),
                );
              },
              // ),
            ),
          ),
        ],
      ),
    );
  }
}
