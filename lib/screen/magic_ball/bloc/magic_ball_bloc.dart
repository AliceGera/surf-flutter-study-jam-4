import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:surf_practice_magic_ball/screen/magic_ball/data/magic_ball_screen_data.dart';
import 'package:surf_practice_magic_ball/screen/magic_ball/repository/magic_ball_repository.dart';

import '../../bloc/theme_bloc.dart';

part 'magic_ball_event.dart';

part 'magic_ball_state.dart';

class MagicBallBloc extends Bloc<MagicBallEvent, MagicBallState> {
  MagicBallScreenData screenData = MagicBallScreenData.init();

  MagicBallBloc() : super(MagicBallInitialState()) {
    final MagicBallRepository repository = MagicBallRepository();

    const String imageLightBall = 'assets/images/ball_light.png';
    const String imageDarkBall = 'assets/images/ball.png';
    final Color lightColorBall = Colors.white.withOpacity(0.8);
    final Color darkColorBall = Colors.black.withOpacity(0.8);

    on<InitMagicBallScreenEvent>((event, emit) async {
      final hasDarkTheme = await isDark();
      screenData = MagicBallScreenData(
        screenData.reading,
        hasDarkTheme ? imageDarkBall : imageLightBall,
        hasDarkTheme ? darkColorBall : lightColorBall,
      );
      emit(MagicBallInitialState(data: screenData));
    });

    on<LoadMagicBallScreenEvent>((event, emit) async {
      emit(MagicBallLoadingState());
      try {
        final answer = await repository.getMagicBallAnswer();
        screenData = MagicBallScreenData(
          answer.reading ?? '',
          screenData.imageBall,
          screenData.color,
        );
        emit(MagicBallSuccessState(screenData));
      } catch (error) {
        emit(MagicBallFailedState(error.toString()));
      }
    });

    on<ChangeImageMagicBallScreenEvent>((event, emit) async {
      try {
        final hasDarkTheme = await isDark();
        screenData = MagicBallScreenData(
          screenData.reading,
          hasDarkTheme ? imageLightBall : imageDarkBall,
          hasDarkTheme ? lightColorBall : darkColorBall,
        );
        emit(MagicBallSuccessState(screenData));
      } catch (error) {
        // emit(MagicBallFailedState(error.toString()));
      }
    });
  }
}
