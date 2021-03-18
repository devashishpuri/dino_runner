import 'dart:ui';

import 'package:flame/components/animation_component.dart';
import 'package:flame/spritesheet.dart';

const double nTilesAlongWidth = 24;

class Cactus extends AnimationComponent {
  SpriteSheet _spriteSheet;
  double speed = 200;
  Size _screenSize;

  List<Rect> hitboxes = [];

  Cactus() : super.empty() {
    _spriteSheet = SpriteSheet(
        imageName: 'cactus.png',
        textureWidth: 44,
        textureHeight: 93,
        columns: 1,
        rows: 1);
    animation = _spriteSheet.createAnimation(0, from: 0, to: 1, loop: false);
  }

  @override
  void resize(Size size) {
    super.resize(size);

    _screenSize = size;

    final groundHeight = 112;

    final scaleFactor =
        (size.width / nTilesAlongWidth) / _spriteSheet.textureWidth;

    height = _spriteSheet.textureHeight * scaleFactor;
    width = _spriteSheet.textureWidth * scaleFactor;
    x = size.width + width;
    y = size.height - groundHeight - height + 8;

    _setHitBoxes(x, y, width, height);

    print('Cactus: x: $x, y: $y, width: $width, height: $height');
  }

  _setHitBoxes(double x, double y, double width, double height) {
    hitboxes = [
      Rect.fromLTWH(x + width * 0.25, y, width * 0.5, height),
      Rect.fromLTWH(x, y + height - (height * 0.74), width, height * 0.74),
      Rect.fromLTWH(x + width - width * 0.25, y + height - (height * 0.74),
          width, height * 0.74),
    ];
  }

  @override
  void update(double t) {
    super.update(t);

    x -= speed * t;

    if (x <= -width) {
      x = (_screenSize?.width ?? 0) + width;
    }
    _setHitBoxes(x, y, width, height);
  }

  // @override
  // bool destroy() {
  //   return x <= -width;
  // }
}
