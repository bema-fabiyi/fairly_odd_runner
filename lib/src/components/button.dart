import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';

class Button extends PositionComponent with TapCallbacks {
  late SpriteComponent _icon;
  final VoidCallback onPressed;

  Button({
    required Vector2 position,
    required Sprite iconSprite,
    required this.onPressed,
    double size = 200,
  }) : super(
          position: position,
          size: Vector2.all(size),
          anchor: Anchor.center,
        ) {
    _icon = SpriteComponent(
      sprite: iconSprite,
      size: Vector2.all(size),
    );

    add(_icon);
  }

  @override
  bool onTapDown(TapDownEvent event) {
    onPressed();
    return true;
  }
}
