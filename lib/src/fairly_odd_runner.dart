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
  double score = 0;
  late TextComponent scoreText;

  @override
  Future<void> onLoad() async {
    await Flame.device.fullScreen();
    await Flame.device.setLandscape();
    camera.viewfinder.anchor = Anchor.topLeft;

    world.add(playArea);
    //  world.add(Ground(gameWidth, 100));

    world.add(oddRunner);
    // overlays.add('PauseButton');

    _enemyTimer = Timer(4, repeat: true, onTick: () {
      world.add(Obstacle());
    });
    _enemyTimer.start();
    ui.Image jumpIcon = await images.load('jumpButton.png');
    ui.Image attackIcon = await images.load('attackButton.png');
    ui.Image pauseIcon = await images.load('pause.png');

    camera.viewport.add(
      Button(
        position: Vector2(gameWidth / 18, gameHeight / 2),
        onPressed: () {
          if (!paused) {
            oddRunner.jump();
          }
        },
        buttonSize: 370,
        iconSprite: Sprite(jumpIcon),
      )..priority = 10,
    );

    camera.viewport.add(
      Button(
        position: Vector2(gameWidth / 15, 850),
        onPressed: () {
          if (!paused) {
            oddRunner.attack();
          }
        },
        iconSprite: Sprite(attackIcon),
      ),
    );

    final pauseButton = Button(
      buttonAnchor: Anchor.topLeft,
      position: Vector2(gameWidth / 100, 10),
      buttonSize: 80,
      onPressed: () {
        if (!paused) {
          pauseEngine();
          overlays.add('PauseMenu');
        }
      },
      iconSprite: Sprite(pauseIcon),
    );
    camera.viewport.add(pauseButton);

    scoreText = TextComponent(
      text: score.toString(),
      position: Vector2(gameWidth / 2, 10),
      textRenderer: TextPaint(
        style: const TextStyle(
          fontSize: 80,
          // fontWeight: FontWeight.bold,
          fontFamily: 'Tiny5',
        ),
      ),
    );
    camera.viewport.add(scoreText);
    super.onLoad();
  }

  @override
  void update(double dt) {
    _enemyTimer.update(dt);
    score += 10 * dt;
    scoreText.text = score.toInt().toString();
    super.update(dt);
  }

  @override
  void lifecycleStateChange(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.paused:
        pauseEngine();
        break;
      case AppLifecycleState.resumed:
        resumeEngine();
        break;
      case AppLifecycleState.inactive:
        pauseEngine();

        break;
      case AppLifecycleState.detached:
        pauseEngine();

        break;
      case AppLifecycleState.hidden:
        pauseEngine();

        break;
    }
    super.lifecycleStateChange(state);
  }

  void pauseGame() {}

  void reset() {
    score = 0;
    oddRunner.state = RunnerState.running;
    oddRunner.groundY =
        gameHeight / 1.85; // set runner back to original position if in mid air
    oddRunner
        .updateAnimation(); // update animation after setting state to running
    _enemyTimer.reset();
    world.children.whereType<Obstacle>().forEach((obstacle) {
      obstacle.removeFromParent();
    });
  }
}
