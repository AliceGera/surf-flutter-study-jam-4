import 'package:get_it/get_it.dart';

import 'magic_ball_view_mapper.dart';

void initMagicBallModule() {
  final getIt = GetIt.I;
  getIt.registerLazySingleton<MagicBallViewMapper>(() => MagicBallViewMapper());
}
