import 'dart:ui';

import 'package:flame/animation.dart';
import 'package:flame/components/animation_component.dart';
import 'package:flame/spritesheet.dart';
import 'package:flame/time.dart';
import 'package:flutter/foundation.dart';

const double nTilesAlongWidth = 16;
const double gravity = 1000;

const int DINO_LIVES = 3;

class Dino extends AnimationComponent {
  SpriteSheet _runSpriteSheet;
  SpriteSheet _crouchSpriteSheet;
  double speedY = 0.0;
  double yMax;
  bool isJumping = false;
  Timer _hitTimer;
  bool _isHit = false;

  Animation _crouchAnimation;
  Animation _runAnimation;
  Animation _idleAnimation;

  ValueNotifier<int> lives;

  List<Rect> hitboxes = [];

  Dino() : super.empty() {
    _runSpriteSheet = SpriteSheet(
        imageName: 'dino_run_sprite.png',
        textureWidth: 82,
        textureHeight: 86,
        columns: 3,
        rows: 1);

    _crouchSpriteSheet = SpriteSheet(
        imageName: 'dino_cr_sprite.png',
        textureWidth: 110,
        textureHeight: 52,
        columns: 2,
        rows: 1);

    _idleAnimation =
        _runSpriteSheet.createAnimation(0, from: 0, to: 1, loop: false);

    _runAnimation = _runSpriteSheet.createAnimation(0,
        from: 1, to: 3, stepTime: 0.1, loop: true);

    _crouchAnimation =
        _crouchSpriteSheet.createAnimation(0, from: 0, to: 2, stepTime: 0.1);

    // animation = _idleAnimation;
    animation = _runAnimation;

    // anchor = Anchor.center;
    lives = ValueNotifier(DINO_LIVES);
    _hitTimer = Timer(1, callback: hitReset);
  }

  @override
  void resize(Size size) {
    super.resize(size);

    final scaleFactor =
        (size.width / nTilesAlongWidth) / _runSpriteSheet.textureWidth;
    // final groundHeight = size.height * 0.30;
    final groundHeight = 112;

    height = _runSpriteSheet.textureHeight * scaleFactor;
    width = _runSpriteSheet.textureWidth * scaleFactor;
    x = size.width * 0.20;
    // y = size.height - groundHeight - (height / 2);
    y = size.height - groundHeight - height;
    yMax = y;

    print('Dino: x: $x, y: $y, width: $width, height: $height');

    _setHitBoxes(x, y, width, height);
  }

  _setHitBoxes(double x, double y, double width, double height) {
    hitboxes = [
      Rect.fromLTWH(x, y, width * 0.7, height),
      Rect.fromLTWH(x, y, width, height * 0.33),
    ];
  }

  @override
  void update(double t) {
    super.update(t);

    if (isJumping) {
      // v = u + at
      speedY += gravity * t;
      // d = s * t
      y += speedY * t;

      if (onGround) {
        animation = _runAnimation;
        y = yMax;
        speedY = 0.0;
        isJumping = false;
      }
      _setHitBoxes(x, y, width, height);
    }

    _hitTimer.update(t);
  }

  bool get onGround {
    return y >= yMax;
  }

  void run() {
    _isHit = false;
    animation = _runAnimation;
  }

  void hitReset() {
    if (_isHit) {
      _isHit = false;
      run();
    }
  }

  void hit() {
    if (!_isHit) {
      _isHit = true;
      lives.value -= 1;
      // animation = _hitAnimation;
      _hitTimer.start();

      // AudioManager().playSfx('hurt7.wav');
    }
  }

  void reset() {
    lives.value = DINO_LIVES;
    run();
  }

  void crouch() {
    animation = _crouchAnimation;
  }

  void jump() {
    if (onGround && !isJumping) {
      animation = _idleAnimation;
      isJumping = true;
      speedY = -500;
      // AudioManager().playSfx('jump14.wav');
    }
  }
}
