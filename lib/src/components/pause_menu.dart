import 'package:fairly_odd_runner/src/fairly_odd_runner.dart';
import 'package:flutter/material.dart';

class PauseMenu extends StatelessWidget {
  const PauseMenu({super.key, required this.game});

  final FairlyOddRunner game;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black45,
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Gameplay is paused',
              style: const TextStyle(
                fontSize: 35,
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontFamily: 'Tiny5',
              ),
            ),
            const SizedBox(height: 5),
            Text(
              'Press the button to continue',
              style: const TextStyle(
                fontSize: 30,
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontFamily: 'Tiny5',
              ),
            ),
            const SizedBox(height: 5),
            IconButton(
              icon: Icon(
                Icons.play_arrow,
              ),
              iconSize: 60,
              color: Colors.white,
              // Image.asset(
              //   'assets/images/play.png',
              //   width: 50,
              //   height: 50,
              //  ),
              onPressed: () {
                game.overlays.remove('PauseMenu');
                game.resumeEngine();
              },
            ),
          ],
        ),
      ),
    );
  }
}
