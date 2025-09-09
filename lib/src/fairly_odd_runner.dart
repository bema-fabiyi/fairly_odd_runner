import 'dart:async';
import 'dart:ui' as ui;
import 'package:fairly_odd_runner/src/components/components.dart';
import 'package:fairly_odd_runner/src/config.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
//as flutter;

class FairlyOddRunner extends FlameGame with HasCollisionDetection {
  FairlyOddRunner()
      : super(
            camera: CameraComponent.withFixedResolution(
                //withFixedResolution ensures the game sticks to the set resolution
                width: gameWidth,
                height: gameHeight));

  PlayArea playArea = PlayArea();
  OddRunner oddRunner = OddRunner();
  Obstacle mushroom = Obstacle();
  late Timer _enemyTimer;
  late Image attackIcon;
  late Image jumpIcon;
  int score = 0;
  late TextComponent scoreText;

  @override
  Future<void> onLoad() async {
    await Flame.device.fullScreen();
    await Flame.device.setLandscape();
    camera.viewfinder.anchor = Anchor.topLeft;

    world.add(playArea);
    world.add(oddRunner);

    _enemyTimer = Timer(4, repeat: true, onTick: () {
      world.add(Obstacle());
    });
    _enemyTimer.start();
    ui.Image attackIcon = await images.load('attackButton.png');
    ui.Image jumpIcon = await images.load('jumpButton.png');

    camera.viewport.add(
      Button(
        position: Vector2(gameWidth / 15, 850),
        onPressed: oddRunner.triggerAttack,
        iconSprite: Sprite(attackIcon),
      )..priority = 10,
    );
    camera.viewport.add(
      Button(
        position: Vector2(gameWidth / 18, gameHeight / 2),
        onPressed: oddRunner.jump,
        size: 370,
        iconSprite: Sprite(jumpIcon),
      )..priority = 10,
    );

    scoreText = TextComponent(
      text: score.toString(),
      position: Vector2(gameWidth / 2, 20),
      textRenderer: TextPaint(
        style: const TextStyle(
          fontSize: 60, // TODO CHANGE FONT
        ),
      ),
    );
    camera.viewport.add(scoreText);
    // overlays.add('pause');
    super.onLoad();
  }

  @override
  void update(double dt) {
    _enemyTimer.update(dt);
    score += (60 * dt).toInt();
    scoreText.text = score.toString();
    super.update(dt);
  }
}
