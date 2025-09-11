import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';

class Button extends PositionComponent with TapCallbacks {
  late SpriteComponent _icon;
  final VoidCallback onPressed;
  final double? buttonSize;
  final Anchor? buttonAnchor;

  Button({
    this.buttonAnchor,
    super.position,
    required Sprite iconSprite,
    required this.onPressed,
    this.buttonSize,
  }) : super(
          size: Vector2.all(buttonSize ?? 200),
          anchor: buttonAnchor ?? Anchor.center,
        ) {
    _icon = SpriteComponent(
      sprite: iconSprite,
      size: size,
    );

    add(_icon);
  }

  @override
  void onTapDown(TapDownEvent event) {
    onPressed();
  }
}
