import 'package:flutter/material.dart';

class MagicBallScreenData {
  late final String reading;
  late final String imageBall;
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
