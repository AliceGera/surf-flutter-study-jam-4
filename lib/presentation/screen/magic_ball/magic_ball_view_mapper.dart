import '../../../domain/model/magic_ball_data.dart';
import 'data/magic_ball_screen_data.dart';

abstract class MagicBallViewMapper {
  factory MagicBallViewMapper() => _MagicBallViewMapper();

  MagicBallScreenData toScreenData(
    MagicBallScreenData screenData,
    MagicBallData data,
  );
}

class _MagicBallViewMapper implements MagicBallViewMapper {
  @override
  MagicBallScreenData toScreenData(
    MagicBallScreenData screenData,
    MagicBallData data,
  ) {
    return screenData = MagicBallScreenData(
      data.reading ?? '',
      screenData.imageBall,
      screenData.color,
    );
  }
}
