class MagicBallData {
  final String? reading;

  const MagicBallData({
    required this.reading,
  });

  MagicBallData.fromJson(Map<String, dynamic> json) : reading = json['reading'];
}
