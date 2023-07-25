import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:surf_practice_magic_ball/screen/magic_ball/data/magic_ball_screen_data.dart';
import 'package:surf_practice_magic_ball/screen/magic_ball/repository/magic_ball_repository.dart';

part 'magic_ball_event.dart';

part 'magic_ball_state.dart';

class MagicBallBloc extends Bloc<MagicBallEvent, MagicBallState> {
  MagicBallBloc() : super(MagicBallInitialState()) {
    final MagicBallRepository repository = MagicBallRepository();

    on<InitMagicBallScreenEvent>((event, emit) async {
      emit(MagicBallInitialState());
    });

    on<LoadMagicBallScreenEvent>((event, emit) async {
      emit(MagicBallLoadingState());
      try {
        final answer = await repository.getMagicBallAnswer();
        emit(
          MagicBallSuccessState(
            MagicBallScreenData(answer.reading ?? ''),
          ),
        );
      } catch (error) {
        emit(MagicBallFailedState(error.toString()));
      }
    });
  }
}
