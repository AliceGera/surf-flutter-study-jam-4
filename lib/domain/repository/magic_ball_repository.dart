import '../model/magic_ball_data.dart';

abstract class IMagicBallRepository {
  Future<MagicBallData> getMagicBall();
}
