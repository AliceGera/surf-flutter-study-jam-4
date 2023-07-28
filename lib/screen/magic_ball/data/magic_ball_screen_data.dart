class MagicBallScreenData {
  final String reading;
  final String imageBall;

  MagicBallScreenData(
    this.reading,
    this.imageBall,
  );

  static MagicBallScreenData init() => MagicBallScreenData(
        '',
        '',
      );
}
