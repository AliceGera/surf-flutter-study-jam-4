import 'package:flutter/material.dart';

class MagicBallScreenData {
  late final String reading;
  late final String imageBall;
  final Color color;
  late final Color chooseColorImageBall;

  MagicBallScreenData(
    this.reading,
    this.imageBall,
    this.color,
    this.chooseColorImageBall,
  );

  static MagicBallScreenData init() => MagicBallScreenData(
        '',
        '',
        Colors.transparent,
        Colors.transparent,
      );
}
