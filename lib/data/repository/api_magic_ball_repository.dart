import 'package:surf_practice_magic_ball/data/model/api_magic_ball_response.dart';
import '../../domain/model/magic_ball_data.dart';
import '../../domain/repository/magic_ball_repository.dart';
import '../api/api_client.dart';
import '../mapper/magic_ball_mapper.dart';

class ApiMagicBallRepository implements IMagicBallRepository {
  final HttpRequestExecutor httpRequestExecutor;
  final IMagicBallMapper magicBallMapper;

  ApiMagicBallRepository(
    this.httpRequestExecutor,
    this.magicBallMapper,
  );

  @override
  Future<MagicBallData> getMagicBall() async {
    final response = await httpRequestExecutor.executeRequest(
      HttpMethod.get,
      Uri.parse("https://eightballapi.com/api"),
      null,
    );

    final mappedResponse = ApiMagicBallResponse.fromJson(response);
    final magicBallData = magicBallMapper.toMagicBallData(mappedResponse);
    return magicBallData;
  }
}
