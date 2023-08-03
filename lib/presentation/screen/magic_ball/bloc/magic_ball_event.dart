part of 'magic_ball_bloc.dart';

@immutable
abstract class MagicBallEvent {}

class InitMagicBallScreenEvent extends MagicBallEvent {}

class LoadMagicBallScreenEvent extends MagicBallEvent {}

class ChangeImageMagicBallScreenEvent extends MagicBallEvent {}
