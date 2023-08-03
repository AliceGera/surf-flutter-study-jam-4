import 'package:get_it/get_it.dart';
import '../interactor/magic_ball_interactor.dart';
import '../repository/magic_ball_repository.dart';

Future<void> configureDomainDependencies() async {
  final getIt = GetIt.I;

  getIt.registerLazySingleton<MagicBallInteractor>(
    () => MagicBallInteractor(
      getIt.get<IMagicBallRepository>(),
    ),
  );
}
