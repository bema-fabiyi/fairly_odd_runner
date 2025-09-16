import 'package:fairly_odd_runner/src/config.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class Ground extends RectangleComponent {
  Ground(double gameWidth, double groundHeight)
      : super(
          size: Vector2(gameWidth, groundHeight),
          paint: Paint()
            ..color = const Color.fromARGB(255, 17, 17, 48), // brown
        );

  @override
  Future<void> onLoad() async {
    position = Vector2(0, gameHeight - size.y); // stick to bottom
    priority = 10; // above parallax
  }
}
