import 'package:dino_runner/game/dino.component.dart';
import 'package:dino_runner/game/cactus.dart';
import 'package:dino_runner/widgets/game_hud.widget.dart';
import 'package:dino_runner/widgets/game_over.widget.dart';
import 'package:flame/components/parallax_component.dart';
import 'package:flame/components/text_component.dart';
import 'package:flame/game.dart';
import 'package:flame/gestures.dart';
import 'package:flame/position.dart';
import 'package:flame/text_config.dart';
import 'package:flutter/widgets.dart';

class OverlayIdentifiers {
  static const String HUD = 'hud';
  static const String PAUSE_MENU = 'pause_menu';
  static const String GAME_OVER = 'game_over';
}

class GamePallete {
  static const hudColor = Color(0xff282828);
}

class DinoRunnerGame extends BaseGame with TapDetector, HasWidgetsOverlay {
  // Game Components
  Dino _dino;
  Cactus _cactus;
  TextComponent _scoreText;

  // Game Helpers
  int score = 0;
  double _elapsedTime = 0;

  DinoRunnerGame() {
    final _parallaxComponent = ParallaxComponent([
      ParallaxImage('scene.png'),
      ParallaxImage('clouds.png'),
      ParallaxImage('ground.png', fill: LayerFill.none),
    ], baseSpeed: Offset(100, 0), layerDelta: Offset(20, 0));
    _dino = Dino();
    _cactus = Cactus();

    _scoreText = TextComponent('',
        config: TextConfig(
            color: GamePallete.hudColor,
            fontFamily: 'PressStart2P',
            fontSize: 16));
    _scoreText.setByPosition(Position(24, 24));

    add(_parallaxComponent);
    add(_dino);
    add(_cactus);
    add(_scoreText);

    addWidgetOverlay(OverlayIdentifiers.HUD, GameHud(_dino, pauseGame));
  }

  _checkCollision() {
    components.whereType<Cactus>().forEach((cactus) {
      // print(_dino.distance(cactus));
      if (_checkHitBoxCollisions(_dino.hitboxes, cactus.hitboxes) &&
          // Not the Intialisation Case
          _dino.x != 0) {
        // _dino.hit();
        print('Hit');
        _dino.hit();
        // pauseEngine();
      }
    });
  }

  bool _checkHitBoxCollisions(List<Rect> collectionA, List<Rect> collectionB) {
    bool isHit = false;
    collectionA.forEach((rect1) {
      collectionB.forEach((rect2) {
        if (rect1.left < rect2.left + rect2.width &&
            rect1.left + rect1.width > rect2.left &&
            rect1.top < rect2.top + rect2.height &&
            rect1.top + rect1.height > rect2.top) {
          isHit = true;
        }
      });
    });
    return isHit;
  }

  @override
  void onTapDown(TapDownDetails details) {
    super.onTapDown(details);

    _dino.jump();
  }

  @override
  void update(double t) {
    super.update(t);

    _setScore(t);

    _checkCollision();

    if (_dino.lives.value == 0) {
      pauseEngine();
      addWidgetOverlay(
          OverlayIdentifiers.GAME_OVER, GameOverMenu(score, reset));
    }
  }

  _setScore(double deltaT) {
    _elapsedTime += deltaT;

    if (_elapsedTime > (1 / 60)) {
      _elapsedTime = 0;
      score += 1;
      _scoreText.text = 'Score: $score';
    }
  }

  void pauseGame() {
    pauseEngine();
  }

  void reset() {
    this.score = 0;
    _dino.reset();
    // Remove Enemies
    removeWidgetOverlay(OverlayIdentifiers.GAME_OVER);
    resumeEngine();
  }
}
