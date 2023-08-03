import '../../domain/model/magic_ball_data.dart';
import '../model/api_magic_ball_response.dart';

abstract class IMagicBallMapper {
  factory IMagicBallMapper() => _IMagicBallMapper();

  MagicBallData toMagicBallData(ApiMagicBallResponse data);
}

class _IMagicBallMapper implements IMagicBallMapper {
  @override
  MagicBallData toMagicBallData(ApiMagicBallResponse data) {
    return MagicBallData(
      reading: data.reading,
    );
  }
}
