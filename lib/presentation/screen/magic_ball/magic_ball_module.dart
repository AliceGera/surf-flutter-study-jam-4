import 'package:get_it/get_it.dart';

import '../../../domain/interactor/magic_ball_interactor.dart';
import 'bloc/magic_ball_bloc.dart';
import 'magic_ball_view_mapper.dart';

void initMagicBallModule() {
  final getIt = GetIt.I;
  getIt.registerLazySingleton<MagicBallViewMapper>(() => MagicBallViewMapper());
  getIt.registerFactory<MagicBallBloc>(
    () => MagicBallBloc(
      GetIt.I.get<MagicBallInteractor>(),
      GetIt.I.get<MagicBallViewMapper>(),
    ),
  );
}
