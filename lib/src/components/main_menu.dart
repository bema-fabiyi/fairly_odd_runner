import 'package:fairly_odd_runner/src/components/components.dart';
import 'package:fairly_odd_runner/src/fairly_odd_runner.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

class MainMenu extends StatelessWidget {
  const MainMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/background.png',
              fit: BoxFit.fill,
            ),
          ),
          Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/idle.png',
                  height: 100,
                  width: 100,
                ),
                Text(
                  'FAIRLY',
                  style: const TextStyle(
                    fontSize: 50,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Tiny5',
                  ),
                ),
                Text(
                  'ODD RUNNER',
                  style: const TextStyle(
                    fontSize: 50,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Tiny5',
                  ),
                ),
                const SizedBox(height: 15),
                SizedBox(
                  height: 80,
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      final myGame = FairlyOddRunner();

                      Navigator.pushReplacement(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (context, animation1, animation2) =>
                              GameWidget(
                            game: myGame,
                            overlayBuilderMap: {
                              'GameOver': (ctx, game) => GameOver(game: myGame),
                              'PauseMenu': (ctx, game) =>
                                  PauseMenu(game: myGame),
                            },
                          ),
                          transitionDuration: Duration.zero,
                          reverseTransitionDuration: Duration.zero,
                        ),
                      );
                    },
                    icon: Image.asset(
                      'assets/images/start.png',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
