import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

class AnimatedTextWidget extends StatelessWidget {
  final String text;
  final String animatedText;
  final bool isMobile;
  final double smallStarSize;

  const AnimatedTextWidget(
    this.text,
    this.animatedText,
    this.isMobile,
    this.smallStarSize, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: smallStarSize,
      child: AnimatedTextKit(
        animatedTexts: [
          if (animatedText == "TypewriterAnimatedText") ...[
            TypewriterAnimatedText(
              text,
              textStyle: TextStyle(
                color: Colors.white,
                fontSize: isMobile ? 32 : 56,
                height: 1.125,
                overflow: TextOverflow.ellipsis,
              ),
              speed: const Duration(milliseconds: 150),
              textAlign: TextAlign.center,
            ),
          ] else if (animatedText == "TyperAnimatedText") ...[
            TyperAnimatedText(
              text,
              textStyle: TextStyle(
                color: Colors.white,
                fontSize: isMobile ? 32 : 56,
                height: 1.125,
                overflow: TextOverflow.ellipsis,
              ),
              speed: const Duration(milliseconds: 150),
              textAlign: TextAlign.center,
            ),
          ] else if (animatedText == "ScaleAnimatedText") ...[
            ScaleAnimatedText(
              text,
              textStyle: TextStyle(
                color: Colors.white,
                fontSize: isMobile ? 32 : 56,
                height: 1.125,
                overflow: TextOverflow.ellipsis,
              ),
              //speed: const Duration(milliseconds: 150),
              textAlign: TextAlign.center,
            ),
          ] else if (animatedText == '') ...[
            TypewriterAnimatedText(
              text,
              textStyle: TextStyle(
                color: Colors.white,
                fontSize: isMobile ? 32 : 56,
                height: 1.125,
                overflow: TextOverflow.ellipsis,
              ),
              speed: const Duration(milliseconds: 150),
              textAlign: TextAlign.center,
            ),
          ],
        ],
        totalRepeatCount: 1,
      ),
    );
  }
}
