import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';

class MyButton extends ButtonComponent {
  MyButton({
    required Vector2 position,
    required VoidCallback onPressed,
  }) : super(
          position: position,
          size: Vector2(120, 50),
          anchor: Anchor.center,
          button: CircleComponent(
            radius: 100,
            paint: Paint()..color = const Color(0xFF4285F4), // normal state
          ),
          buttonDown: RectangleComponent(
            size: Vector2(120, 50),
            paint: Paint()..color = const Color(0xFF3367D6), // pressed state
          ),
          onPressed: onPressed,
        );
}
