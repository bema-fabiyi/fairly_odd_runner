import 'dart:async';

import 'package:fairly_odd_runner/src/components/components.dart';
import 'package:fairly_odd_runner/src/config.dart';
import 'package:fairly_odd_runner/src/fairly_odd_runner.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/sprite.dart';

class OddRunner extends SpriteAnimationComponent
    with CollisionCallbacks, HasGameReference<FairlyOddRunner> {
  OddRunner() : super(size: Vector2.all(500));

  late final SpriteAnimation _idleAnimation;
  late final SpriteAnimation _runAnimation;
  late final SpriteAnimation _attackAnimation;
  final double _animationSpeed = .10;
  RunnerState state = RunnerState.running;
  Timer? _attackTimer;
  final String gameOver = 'GameOver';
  double gravity = 1400;
  double jumpForce = -950; // negative because Y increases downwards
  double verticalVelocity = 0.0;
  late double groundY;

  @override
  Future<void> onLoad() async {
    super.onLoad();
    //  sprite = await game.loadSprite('idle_right.png'); /// TO LOAD A SINGLE SPRITE
    await _loadAnimations().then((_) => {animation = _runAnimation});
    position = Vector2(gameWidth / 20, gameHeight / 2);
    groundY = position.y;
    add(
      RectangleHitbox(
        size: Vector2(120, 180),
        anchor: Anchor.center,
        position: size / 2,
      ),
    );
  }

  @override
  void update(double dt) {
    super.update(dt);
    _attackTimer?.update(dt);

    verticalVelocity += gravity * dt;
    position.y += verticalVelocity * dt;

    // Check landing
    if (position.y >= groundY) {
      position.y = groundY;
      state = RunnerState.running;
      updateAnimation();
      verticalVelocity = 0.0;
    }
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

  @override
  Future<void> onCollision(
    Set<Vector2> intersectionPoints,
    PositionComponent other,
  ) async {
    super.onCollision(intersectionPoints, other);
    if (other is Obstacle &&
        // state != RunnerState.attack &&
        other.isDead != true) {
      game.pauseEngine();
      game.overlays.add(gameOver);
    } else {}
  }

  void updateAnimation() {
    switch (state) {
      case RunnerState.attack:
        animation = _attackAnimation;
        break;
      case RunnerState.running:
        animation = _runAnimation;
        break;
      case RunnerState.idle:
        animation = _idleAnimation;
        break;
      case RunnerState.jump:
        animation = _runAnimation;
        break;
    }
  }

  void attack() {
    state = RunnerState.attack;
    updateAnimation();

    // Set a timer to return to running state after attack completes
    _attackTimer = Timer(0.8, onTick: () {
      state = RunnerState.running;
      updateAnimation();
      _attackTimer = null;
    });
    _attackTimer!.start(); // Add this line to start the timer
    for (var enemy in game.world.children.whereType<Obstacle>()) {
      final distance = position.distanceTo(enemy.position);
      if (distance < 350) {
        enemy.die();
      }
    }
  }

  void jump() {
    state = RunnerState.jump;
    updateAnimation();
    verticalVelocity = jumpForce;
  }
}
