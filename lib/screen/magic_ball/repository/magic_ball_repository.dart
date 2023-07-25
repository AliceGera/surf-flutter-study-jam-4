import 'package:dio/dio.dart';
import 'package:surf_practice_magic_ball/screen/magic_ball/models/magic_ball_data.dart';

const String baseUrl = "https://eightballapi.com";

class MagicBallRepository {
  Future<MagicBallData> getMagicBallAnswer() async {
    Dio dio = Dio();
    dio.options.baseUrl = baseUrl;
    dio.options.responseType = ResponseType.json;

    Response response = await dio.get('/api');
    if (response.statusCode == 200) {
      final answer = response.data as Map<String, dynamic>;
      return MagicBallData.fromJson(answer);
    } else {
      throw Exception("failed request");
    }
  }
}
