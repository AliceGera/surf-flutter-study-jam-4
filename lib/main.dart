import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:surf_practice_magic_ball/presentation/screen/bloc/theme_bloc.dart';
import 'package:surf_practice_magic_ball/presentation/screen/magic_ball/magic_ball_screen.dart';

import 'di/injector.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureInjector();
  runApp(
    BlocProvider(
      create: (context) => ThemeBloc()..add(InitialThemeSetEvent()),
      child: const MyApp(),
    ),
  );
}

/// App,s main widget.
class MyApp extends StatelessWidget {
  /// Constructor for [MyApp].
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeData>(
      builder: (context, state) {
        return MaterialApp(
          theme: state,
          debugShowCheckedModeBanner: false,
          home: const MagicBallScreen(),
        );
      },
    );
  }
}
