part of 'magic_ball_bloc.dart';

@immutable
abstract class MagicBallEvent {}

class InitMagicBallScreenEvent extends MagicBallEvent {}

class LoadMagicBallScreenEvent extends MagicBallEvent {}

class ChangeImageMagicBallScreenEvent extends MagicBallEvent {}

class ChangeImageMagicBallColorScreenEvent extends MagicBallEvent {
  final Color ballColor;

  ChangeImageMagicBallColorScreenEvent(this.ballColor);
}

class ChangeTextAnimationMagicBallColorScreenEvent extends MagicBallEvent {
  final String textAnimation;

  ChangeTextAnimationMagicBallColorScreenEvent(this.textAnimation);
}
