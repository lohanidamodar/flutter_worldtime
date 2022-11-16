import 'package:flutter/material.dart';
import 'package:flutter_worldtime/res/constants.dart';

class ClockContainer extends StatelessWidget {
  final Widget child;

  ClockContainer({required this.child});
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Center(
          child: Container(
            width: 270,
            height: 270,
            decoration: BoxDecoration(
              color: AppColors.darkClockBg,
              shape: BoxShape.circle,
            ),
          ),
        ),
        Center(
          child: this.child,
        ),
        Center(
          child: Container(
            width: 10.0,
            height: 10.0,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.red,
            ),
          ),
        ),
      ],
    );
  }
}
