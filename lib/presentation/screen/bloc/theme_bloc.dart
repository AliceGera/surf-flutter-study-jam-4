import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'theme_event.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeData> {
  final dark = ThemeData(
    primaryColor: const Color(0xFF100C2C),
    scaffoldBackgroundColor: const Color(0xFF000002),
  );
  static ThemeData light = ThemeData(
    primaryColor: const Color(0x00ffffff),
    scaffoldBackgroundColor: const Color(0xFFD3D3FF),
  );

  ThemeBloc() : super(light) {
    //when app is started
    on<InitialThemeSetEvent>((event, emit) async {
      final bool hasDarkTheme = await isDark();
      if (hasDarkTheme) {
        emit(dark);
      } else {
        emit(light);
      }
    });

    //while switch is clicked
    on<ThemeSwitchEvent>((event, emit) {
      final isDark = state == dark;
      emit(isDark ? light : dark);
      setTheme(isDark);
    });
  }
}

Future<bool> isDark() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getBool("is_dark") ?? false;
}

Future<void> setTheme(bool isDark) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setBool("is_dark", !isDark);
}
