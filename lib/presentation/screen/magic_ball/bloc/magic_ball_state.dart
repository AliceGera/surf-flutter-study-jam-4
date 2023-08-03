part of 'magic_ball_bloc.dart';

@immutable
abstract class MagicBallState {}

class MagicBallInitialState extends MagicBallState {
  final MagicBallScreenData? data;

  MagicBallInitialState({this.data});
}

class MagicBallLoadingState extends MagicBallState {}

class MagicBallSuccessState extends MagicBallState {
  final MagicBallScreenData data;

  MagicBallSuccessState(this.data);
}

class MagicBallFailedState extends MagicBallState {
  final dynamic error;

  MagicBallFailedState(this.error);
}
