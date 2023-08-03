import 'dart:io';
import '../../domain/repository/magic_ball_repository.dart';
import '../api/api_client.dart';
import '../mapper/magic_ball_mapper.dart';
import '../repository/api_magic_ball_repository.dart';
import 'package:get_it/get_it.dart';

Future<void> configureDataDependencies() async {
  final getIt = GetIt.I;

  getIt.registerLazySingleton<HttpRequestExecutor>(
    () => HttpRequestExecutor(
      HttpClient(),
    ),
  );
  getIt.registerLazySingleton<IMagicBallMapper>(
    () => IMagicBallMapper(),
  );

  getIt.registerLazySingleton<IMagicBallRepository>(
    () => ApiMagicBallRepository(
      getIt.get<HttpRequestExecutor>(),
      getIt.get<IMagicBallMapper>(),
    ),
  );
}
