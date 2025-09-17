import 'package:fairly_odd_runner/src/components/main_menu.dart';
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
                fontSize: 40,
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontFamily: 'Tiny5',
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 60,
              child: IconButton(
                padding: EdgeInsets.zero,
                icon: Image.asset(
                  'assets/images/resume.png',
                ),
                onPressed: () {
                  game.overlays.remove('PauseMenu');
                  game.resumeEngine();
                },
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 80,
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
      ),
    );
  }
}
