import '../model/magic_ball_data.dart';
import '../repository/magic_ball_repository.dart';

class MagicBallInteractor {
  final IMagicBallRepository magicBallRepository;

  MagicBallInteractor(this.magicBallRepository);

  Future<MagicBallData> getMagicBall() {
    return magicBallRepository.getMagicBall();
  }
}
