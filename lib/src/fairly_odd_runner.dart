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

  OddRunner runner = OddRunner();

  @override
  Future<void> onLoad() async {
    //  camera.viewport.add(World());
    await Flame.device.fullScreen();
    await Flame.device.setLandscape();

    super.onLoad();

    camera.viewfinder.anchor = Anchor.topLeft;
    world.add(PlayArea());
    // world.add(World());
    world.add(
      Ball(
        radius: ballRadius,
        position: size / 2,
        velocity: Vector2(
          rand.nextDouble() - 0.5 * width,
          height * 0.2,
        ).normalized()
          ..scale(height / 4),
      ),
    );
    world.add(runner
        // OddRunner(
        //   velocity: Vector2(0, 0),
        //   position: Vector2(520, 1400),
        // ),
        );
    // world.add(OddRunner(velocity: velocity, position: position));

    // debugMode = true;
  }
}
