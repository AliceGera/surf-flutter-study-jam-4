import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import '../../../../domain/interactor/magic_ball_interactor.dart';
import '../../bloc/theme_bloc.dart';
import '../data/magic_ball_screen_data.dart';
import '../magic_ball_view_mapper.dart';

part 'magic_ball_event.dart';

part 'magic_ball_state.dart';

class MagicBallBloc extends Bloc<MagicBallEvent, MagicBallState> {
  MagicBallScreenData screenData = MagicBallScreenData.init();
  final MagicBallInteractor interactor;
  final MagicBallViewMapper viewMapper;

  MagicBallBloc(
    this.interactor,
    this.viewMapper,
  ) : super(MagicBallInitialState()) {
    const String imageLightBall = 'assets/images/ball_light.png';
    const String imageDarkBall = 'assets/images/ball.png';
    final Color lightColorBall = Colors.white.withOpacity(0.8);
    final Color darkColorBall = Colors.black.withOpacity(0.8);
    final Color colorBall;
    on<InitMagicBallScreenEvent>((event, emit) async {
      final hasDarkTheme = await isDark();
      screenData = MagicBallScreenData(
        screenData.reading,
        hasDarkTheme ? imageDarkBall : imageLightBall,
        hasDarkTheme ? darkColorBall : lightColorBall,
        screenData.chooseColorImageBall,
        screenData.textAnimation,
      );
      emit(MagicBallInitialState(data: screenData));
    });

    on<LoadMagicBallScreenEvent>((event, emit) async {
      emit(MagicBallLoadingState());
      try {
        final data = await interactor.getMagicBall();
        screenData = viewMapper.toScreenData(
          screenData,
          data,
        );
        screenData = MagicBallScreenData(
          screenData.reading ?? '',
          screenData.imageBall,
          screenData.color,
          screenData.chooseColorImageBall,
          screenData.textAnimation,
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
          screenData.chooseColorImageBall,
          screenData.textAnimation,
        );
        emit(MagicBallSuccessState(screenData));
      } catch (error) {
        emit(MagicBallFailedState(error.toString()));
      }
    });

    on<ChangeImageMagicBallColorScreenEvent>((event, emit) async {
      try {
        screenData = MagicBallScreenData(
          screenData.reading,
          screenData.imageBall,
          screenData.color,
          event.ballColor,
          screenData.textAnimation,
        );
        emit(MagicBallSuccessState(screenData));
      } catch (error) {
        emit(MagicBallFailedState(error.toString()));
      }
    });

    on<ChangeTextAnimationMagicBallColorScreenEvent>((event, emit) async {
      try {
        screenData = MagicBallScreenData(
          screenData.reading,
          screenData.imageBall,
          screenData.color,
          screenData.chooseColorImageBall,
          event.textAnimation,
        );
        emit(MagicBallSuccessState(screenData));
      } catch (error) {
        emit(MagicBallFailedState(error.toString()));
      }
    });
  }
}
