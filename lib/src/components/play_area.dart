import 'dart:async';

import 'package:fairly_odd_runner/src/fairly_odd_runner.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class PlayArea extends RectangleComponent
    with HasGameReference<FairlyOddRunner> {
  PlayArea()
      : super(
          paint: Paint()..color = const Color(0xFFF2E8CF),
          children: [
            RectangleHitbox(),
          ],
        );

  @override
  FutureOr<void> onLoad() async {
    super.onLoad();
    size = Vector2(game.width, game.height);
  }
}
