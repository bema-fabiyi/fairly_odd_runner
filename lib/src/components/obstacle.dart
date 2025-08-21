import 'dart:developer';

import 'package:fairly_odd_runner/src/fairly_odd_runner.dart';
import 'package:flame/components.dart';
import 'package:flame/sprite.dart';

class Obstacle extends SpriteAnimationComponent
    with HasGameReference<FairlyOddRunner> {
  Obstacle() : super(size: Vector2.all(300));

  late final SpriteAnimation _runAnimation;
  final double _animationSpeed = .15;

  @override
  Future<void> onLoad() async {
    super.onLoad();
    await _loadAnimations().then((_) => {animation = _runAnimation});
    position = Vector2(game.size.x / 1, 600
        // position = Vector2(gameWidth / 1, 600
        // gameHeight / 2
        );
  }

  @override
  void update(double dt) {
    super.update(dt);
    position -= Vector2(250, 0) * dt;
    // remove enemy once it has left the screen
    if (position.x < -game.size.x) {
      removeFromParent();
      log('removed');
    }
  }

  Future<void> _loadAnimations() async {
    final runSpriteSheet = SpriteSheet.fromColumnsAndRows(
        image: await game.images.load('Mushroom-Run.png'), columns: 8, rows: 1);
    _runAnimation =
        runSpriteSheet.createAnimation(row: 0, stepTime: _animationSpeed);
  }

  @override
  void onRemove() {
    super.onRemove();
    log('removed succesfully');
  }
}
