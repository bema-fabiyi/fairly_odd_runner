import 'dart:async';
import 'dart:math' as math;
import 'package:fairly_odd_runner/src/components/components.dart';
import 'package:fairly_odd_runner/src/config.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';

class FairlyOddRunner extends FlameGame with HasCollisionDetection {
  FairlyOddRunner()
      : super(
            camera: CameraComponent.withFixedResolution(
                //withFixedResolution ensures the game sticks to the set resolution
                width: gameWidth,
                height: gameHeight));

  final rand = math.Random();
  double get width => size.x;
  double get height => size.y;
  late Timer _enemyTimer;

  OddRunner oddRunner = OddRunner();
  PlayArea playArea = PlayArea();
  Obstacle mushroom = Obstacle();
  MyButton button =
      MyButton(position: Vector2(gameWidth / 20, 800), onPressed: () {});

  @override
  Future<void> onLoad() async {
    await Flame.device.fullScreen();
    await Flame.device.setLandscape();
    camera.viewfinder.anchor = Anchor.topLeft;

    world.add(playArea);
    // world.add(button);
    world.add(oddRunner);

    _enemyTimer = Timer(4, repeat: true, onTick: () {
      world.add(Obstacle());
    });
    _enemyTimer.start();

    // world.add(
    //   Ball(
    //     radius: ballRadius,
    //     position: size / 2,
    //     velocity: Vector2(
    //       rand.nextDouble() - 0.5 * width,
    //       height * 0.2,
    //     ).normalized()
    //       ..scale(height / 4),
    //   ),
    // );
    super.onLoad();
  }

  @override
  void update(dt) {
    _enemyTimer.update(dt);
    super.update(dt);
  }
}
