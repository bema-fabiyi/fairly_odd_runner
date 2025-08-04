import 'dart:async';

import 'package:fairly_odd_runner/src/fairly_odd_runner.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';

class OddRunner extends SpriteAnimationComponent
    with DragCallbacks, HasGameReference<FairlyOddRunner> {
  OddRunner({required this.velocity, required super.position})
      : super(
          anchor: Anchor.center,
        );

  final Vector2 velocity;

  @override
  void update(double dt) {
    super.update(dt);
    position += velocity * dt;
  }

  @override
  FutureOr<void> onLoad() async {
    size = Vector2(500, 500);
    final image = game.images.load('idle_up.png');
    animation = SpriteAnimation.fromFrameData(
      await image,
      SpriteAnimationData.sequenced(
        amount: 8,
        stepTime: 0.15,
        textureSize: Vector2(80, 80),
      ),
    );
//print('Image size: ${image.width}x${image.height}');

    // sprite = images.loadSprite('idle_up.png');
    add(RectangleHitbox());
  }

  // @override
  // void onCollisionStart(
  //   Set<Vector2> intersectionPoints,
  //   PositionComponent other,
  // ) {
  //   super.onCollisionStart(intersectionPoints, other);
  //   if (other is PlayArea) {
  //     if (intersectionPoints.first.y <= 0) {
  //       velocity.y = -velocity.y;
  //     } else if (intersectionPoints.first.x <= 0) {
  //       velocity.x = -velocity.x;
  //     } else if (intersectionPoints.first.x >= game.width) {
  //       velocity.x = -velocity.x;
  //     } else if (intersectionPoints.first.y >= game.height) {
  //       removeFromParent();
  //     }
  //   } else {
  //     debugPrint('collision with $other');
  //   }
  // }
}
