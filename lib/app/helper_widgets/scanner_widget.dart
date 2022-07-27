import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_editor/app/utils/sizeconfig.dart';

class ScannerAnimation extends AnimatedWidget {
  final bool stopped;
  final double width;

  ScannerAnimation(
    this.stopped,
    this.width, {
    Key? key,
    required Animation<double> animation,
  }) : super(
          key: key,
          listenable: animation,
        );

  Widget build(BuildContext context) {
    final Animation<double> animation = listenable as Animation<double>;
    final scorePosition = (animation.value * 440) + 16;

    Color color1 = Color(0x5532CD32);
    Color color2 = Color(0x0032CD32);

    if (animation.status == AnimationStatus.reverse) {
      color1 = Color(0x0032CD32);
      color2 = Color(0x5532CD32);
    }

    return Positioned(
      bottom: scorePosition,
      // left: 16.0,
      child: Opacity(
        opacity: (stopped) ? 0.0 : 1.0,
        child: Container(
          height: 60.0,
          // width: width,
          width: SizeConfig.screenWidth,
          decoration: new BoxDecoration(
            gradient: new LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0.1, 0.9],
              colors: [color1, color2],
            ),
          ),
        ),
      ),
    );
  }
}
