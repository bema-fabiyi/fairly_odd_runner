import 'dart:developer';

import 'package:fairly_odd_runner/src/fairly_odd_runner.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/sprite.dart';

class Obstacle extends SpriteAnimationComponent
    with CollisionCallbacks, HasGameReference<FairlyOddRunner> {
  Obstacle() : super(size: Vector2.all(300));

  late final SpriteAnimation _runAnimation;
  late final SpriteAnimation _dieAnimation;

  final double _animationSpeed = .10;

  bool isDead = false;

  @override
  Future<void> onLoad() async {
    super.onLoad();

    await _loadAnimations().then((_) => {animation = _runAnimation});
    position = Vector2(game.size.x / 1, 650
        // position = Vector2(gameWidth / 1, 600
        // gameHeight / 2
        );
    add(
      RectangleHitbox(
        size: Vector2(70, 130),
        anchor: Anchor.topCenter,
        position: size / 2,
        collisionType: CollisionType.passive,
      ),
    );
  }

  @override
  void update(double dt) {
    super.update(dt);
    position -= Vector2(260, 0) * dt;
    // remove enemy once it has left the screen
    if (position.x < -game.size.x) {
      removeFromParent();
      log('mushroom removed');
    }
  }

  Future<void> _loadAnimations() async {
    final runSpriteSheet = SpriteSheet.fromColumnsAndRows(
        image: await game.images.load('Mushroom-Run.png'), columns: 8, rows: 1);
    _runAnimation =
        runSpriteSheet.createAnimation(row: 0, stepTime: _animationSpeed);
    final dieSpriteSheet = SpriteSheet.fromColumnsAndRows(
      image: await game.images.load('Mushroom-Die.png'),
      columns: 15,
      rows: 1,
    );
    _dieAnimation = dieSpriteSheet.createAnimation(
      row: 0,
      stepTime: .09,
      loop: false,
    );
  }

  void die() async {
    isDead = true;
    animation = _dieAnimation;
    game.score += 100; // increase player score
  }
}
