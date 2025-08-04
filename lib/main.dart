import 'package:fairly_odd_runner/src/fairly_odd_runner.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

// void main() {
//   runApp(const MyApp());
// }

void main() {
  final game = FairlyOddRunner();
  runApp(GameWidget(game: game));
}
