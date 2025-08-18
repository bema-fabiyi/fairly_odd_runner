import 'dart:async';

import 'package:fairly_odd_runner/src/config.dart';
import 'package:fairly_odd_runner/src/fairly_odd_runner.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/sprite.dart';

class OddRunner extends SpriteAnimationComponent
    with DragCallbacks, HasGameReference<FairlyOddRunner> {
  OddRunner() : super(size: Vector2.all(500));

  late final SpriteAnimation _idleAnimation;
  late final SpriteAnimation _runAnimation;
  late final SpriteAnimation _attackAnimation;
  final double _animationSpeed = .15;
  RunnerState _state = RunnerState.idle;

  @override
  Future<void> onLoad() async {
    super.onLoad();
    //  sprite = await game.loadSprite('idle_right.png'); /// TO LOAD A SINGLE SPRITE
    await _loadAnimations().then((_) => {animation = _runAnimation});
    // position = game.size / 2;
    position = Vector2(gameWidth / 20, gameHeight / 2);
  }

  @override
  void update(double dt) {
    super.update(dt);
  }

  Future<void> _loadAnimations() async {
    final idleSpriteSheet = SpriteSheet.fromColumnsAndRows(
        image: await game.images.load('idle.png'), columns: 8, rows: 1);
    final runSpriteSheet = SpriteSheet.fromColumnsAndRows(
        image: await game.images.load('run.png'), columns: 8, rows: 1);
    final attackSpriteSheet = SpriteSheet.fromColumnsAndRows(
        image: await game.images.load('attack.png'), columns: 8, rows: 1);

    _idleAnimation =
        idleSpriteSheet.createAnimation(row: 0, stepTime: _animationSpeed);

    _runAnimation =
        runSpriteSheet.createAnimation(row: 0, stepTime: _animationSpeed);
    _attackAnimation =
        attackSpriteSheet.createAnimation(row: 0, stepTime: _animationSpeed);
  }
}

enum RunnerState { idle, running, attack }
