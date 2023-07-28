class MagicBallData {
  final String? reading;
 // final String? imageBall;
  const MagicBallData({
    required this.reading,
   // required this.imageBall,
  });

  MagicBallData.fromJson(Map<String, dynamic> json) : reading = json['reading'];
}
