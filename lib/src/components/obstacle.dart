import 'package:flame/components.dart';

class Obstacle extends PositionComponent {
  Obstacle({
    required this.velocity,
    required double radius,
    required super.position,
  }) : super(
          anchor: Anchor.center,
        );

  final Vector2 velocity;

  @override
  void update(double dt) {
    super.update(dt);
    position -= velocity * dt;
  }
}
