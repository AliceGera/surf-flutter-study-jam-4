import 'package:flutter/material.dart';

class MagicBallScreenData {
  final String reading;
  final String imageBall;
  final Color color;

  MagicBallScreenData(
    this.reading,
    this.imageBall,
    this.color,
  );

  static MagicBallScreenData init() => MagicBallScreenData(
        '',
        '',
        Colors.transparent,
      );
}
