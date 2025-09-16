import 'dart:async';

import 'package:fairly_odd_runner/src/fairly_odd_runner.dart';
import 'package:flame/components.dart';
import 'package:flame/parallax.dart';

class PlayArea extends ParallaxComponent<FairlyOddRunner> {
  @override
  Future<void> onLoad() async {
    parallax = await game.loadParallax(
      fill: LayerFill.none,
      [
        ParallaxImageData('clouds_1.png'),
        ParallaxImageData('clouds_2.png'),
        ParallaxImageData('sky.png'),
        ParallaxImageData('plant.png'),
        // ParallaxImageData('bg.png'),

        // ParallaxImageData('t1.png'),
        // ParallaxImageData('t2.png'),
        // ParallaxImageData('t3.png'),
        //  ParallaxImageData('trees.png'),

        ParallaxImageData('rocks.png'),
        ParallaxImageData('ground_1.png'),
        ParallaxImageData('ground_2.png'),
        ParallaxImageData('ground_3.png'),
      ],
      baseVelocity: Vector2(5, 0),
      velocityMultiplierDelta: Vector2(1.8, 1.0),
    );
  }
}
