import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shake/shake.dart';
import 'package:text_to_speech/text_to_speech.dart';
import '../bloc/theme_bloc.dart';
import 'bloc/magic_ball_bloc.dart';

class MagicBallScreen extends StatefulWidget {
  const MagicBallScreen({Key? key}) : super(key: key);

  @override
  MagicBallScreenState createState() => MagicBallScreenState();
}

class MagicBallScreenState extends State<MagicBallScreen> with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 2),
    vsync: this,
  )..repeat(reverse: true);
  late final Animation<Offset> _offsetAnimation = Tween<Offset>(
    begin: const Offset(0.0, -0.1),
    end: const Offset(0.0, 0.1),
  ).animate(
    CurvedAnimation(
      parent: _controller,
      curve: Curves.linear,
    ),
  );
  late final _animationController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 500),
  );
  bool isMusicAllow = true;
  double shadowProportion = 1;
  final tts = TextToSpeech();

  bool isThemeChanged = true;
  Color boxShadowColor = Colors.transparent;

  @override
  void initState() {
    super.initState();
    _animationController.forward();
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.shortestSide < 600;
    final size = MediaQuery.of(context).size;
    //for adaptation when phone is vertical or horizontal
    final isWidthApplied = size.height * 0.393 < size.width && size.width < size.height;
    //position of ball in mobile and tablets
    final centerOfBall = size.height * (isMobile ? 0.5 : 0.3);
    final imageSize = !isWidthApplied ? size.height * (isMobile ? 0.5 : 0.7) : size.width;
    final bigStarSize = !isWidthApplied ? size.height * (isMobile ? 0.3 : 0.43) : size.width * 0.61;
    final smallStarSize = !isWidthApplied ? size.height * (isMobile ? 0.337 : 0.478) : size.width * 0.73;
    final smallEllipseSize = imageSize * 0.03;
    final bigEllipseSize = imageSize * 0.656;

    return BlocProvider(
      create: (context) => MagicBallBloc()..add(InitMagicBallScreenEvent()),
      child: BlocConsumer<MagicBallBloc, MagicBallState>(
        listener: (context, state) {
          if (state is MagicBallInitialState) {
            ShakeDetector.autoStart(
              onPhoneShake: () {
                if (state is! MagicBallLoadingState) {
                  BlocProvider.of<MagicBallBloc>(context).add(LoadMagicBallScreenEvent());
                }
              },
            );
            _controller.addListener(() {
              setState(() {
                shadowProportion = _controller.value;
              });
            });
          } else if (state is MagicBallSuccessState && isMusicAllow) {
            tts.speak(state.data.reading);
          }
        },
        builder: (context, state) {
          final isFailed = state is MagicBallFailedState;
          final isLoading = state is MagicBallLoadingState;

          if (state is MagicBallInitialState && state.data != null) {
            boxShadowColor = state.data?.color ?? Colors.transparent;
          } else if (state is MagicBallSuccessState) {
            boxShadowColor = state.data.color;
          }

          return Scaffold(
            extendBodyBehindAppBar: true,
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.transparent,
              actions: [
                BlocBuilder<ThemeBloc, ThemeData>(
                  builder: (context, themeData) {
                    return CupertinoSwitch(
                      value: themeData == BlocProvider.of<ThemeBloc>(context).dark,
                      onChanged: (bool val) {
                        BlocProvider.of<MagicBallBloc>(context).add(ChangeImageMagicBallScreenEvent());
                        BlocProvider.of<ThemeBloc>(context).add(ThemeSwitchEvent());
                      },
                    );
                  },
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      isMusicAllow = !isMusicAllow;
                    });
                  },
                  child: Icon(
                    size: 30,
                    isMusicAllow ? Icons.music_note : Icons.music_off,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(width: 20),
              ],
            ),
            body: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Theme.of(context).primaryColor,
                    Theme.of(context).scaffoldBackgroundColor,
                  ],
                ),
              ),
              child: Stack(
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: size.height * 0.03),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Text(
                        'Нажмите на шар\nили потрясите телефон',
                        style: TextStyle(
                          color: const Color(0xFF727272),
                          fontSize: isMobile ? 16 : 32,
                          height: 1.06,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  Center(
                    child: Column(
                      children: [
                        SizedBox(height: centerOfBall + imageSize * 0.5),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Stack(
                                alignment: Alignment.center,
                                children: <Widget>[
                                  Image.asset(
                                    'assets/images/big_ellipse.png',
                                    color: isFailed ? const Color(0xFFDA1319) : null,
                                    width: bigEllipseSize * shadowProportion,
                                  ),
                                  Image.asset(
                                    'assets/images/small_ellipse.png',
                                    color: isFailed ? const Color(0xFFDA1319) : null,
                                    width: smallEllipseSize * shadowProportion,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Center(
                    child: Column(
                      children: [
                        SizedBox(height: (centerOfBall - (imageSize * 0.5)).abs()),
                        InkWell(
                          child: SlideTransition(
                            position: _offsetAnimation,
                            child: Stack(
                              alignment: Alignment.center,
                              children: <Widget>[
                                if (BlocProvider.of<MagicBallBloc>(context).screenData.imageBall.isNotEmpty)
                                  Image.asset(
                                    BlocProvider.of<MagicBallBloc>(context).screenData.imageBall,
                                    height: imageSize,
                                    width: imageSize,
                                  ),
                                AnimatedOpacity(
                                  duration: const Duration(milliseconds: 500),
                                  opacity: isFailed ? 1 : 0,
                                  child: Container(
                                    height: smallStarSize,
                                    width: smallStarSize,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(smallStarSize / 2),
                                      boxShadow: [
                                        BoxShadow(
                                          color: const Color(0xFFDA1319),
                                          blurRadius: isMobile ? 30 : 60,
                                          offset: const Offset(1, 1), // Shadow position
                                        ),
                                      ],
                                    ),
                                  ),
                                ),

                                SvgPicture.asset(
                                  'assets/images/small_star.svg',
                                  height: smallStarSize,
                                  width: smallStarSize,
                                ),
                                AnimatedBuilder(
                                  animation: _animationController,
                                  child: SvgPicture.asset(
                                    'assets/images/star.svg',
                                    height: bigStarSize,
                                    width: bigStarSize,
                                  ),
                                  builder: (context, child) {
                                    return Transform.rotate(
                                      angle: 0.5 * pi * _animationController.value,
                                      child: child,
                                    );
                                  },
                                ),
                                AnimatedOpacity(
                                  duration: const Duration(milliseconds: 500),
                                  opacity: isLoading ? 1 : 0,
                                  child: Container(
                                    height: smallStarSize,
                                    width: smallStarSize,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(smallStarSize / 2),
                                      boxShadow: [
                                        BoxShadow(
                                          color: boxShadowColor,
                                          blurRadius: isMobile ? 30 : 60,
                                          offset: const Offset(1, 1), // Shadow position
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: smallStarSize,
                                  child: Text(
                                    state is MagicBallSuccessState ? state.data.reading : '',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: isMobile ? 32 : 56,
                                      height: 1.125,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.center,
                                  ),
                                )
                              ],
                            ),
                          ),
                          onTap: () {
                            if (!isLoading) {
                              BlocProvider.of<MagicBallBloc>(context).add(LoadMagicBallScreenEvent());
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
