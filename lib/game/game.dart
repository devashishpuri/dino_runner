import 'package:flame/components/parallax_component.dart';
import 'package:flame/game.dart';
import 'package:flame/gestures.dart';
import 'package:flutter/widgets.dart';

class DinoRunnerGame extends BaseGame with TapDetector, HasWidgetsOverlay {
  DinoRunnerGame() {
    final _parallaxComponent = ParallaxComponent([
      ParallaxImage('scene.png'),
      ParallaxImage('clouds.png'),
      ParallaxImage('ground.png', fill: LayerFill.width),
    ], baseSpeed: Offset(100, 0), layerDelta: Offset(20, 0));

    add(_parallaxComponent);
  }
}
