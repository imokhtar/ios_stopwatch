import 'package:flutter/material.dart';
import 'dart:math';

class ClockTicks extends StatelessWidget {
  ClockTicks(
      {this.ticksPerUnit, this.tickHeight, this.tickWidth, this.maxCycle})
      : super();
  final int ticksPerUnit;
  final double tickWidth;
  final double tickHeight;
  final int maxCycle;

  @override
  Widget build(BuildContext context) {
    final ticks = Iterable<int>.generate(maxCycle * ticksPerUnit).toList();
    return Stack(
      alignment: AlignmentDirectional.center,
      children: <Widget>[
        for (var i in ticks)
          Transform.rotate(
            angle: (i / (maxCycle * ticksPerUnit)) * (2.0 * pi),
            child: Container(
              alignment: AlignmentDirectional.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    flex: 2,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.transparent, shape: BoxShape.rectangle),
                    ),
                  ),
                  Container(
                    width: tickWidth,
                    height: i % ticksPerUnit == 0 ? tickHeight : tickHeight / 2,
                    decoration: BoxDecoration(
                        color: i % (ticksPerUnit * 5) == 0
                            ? Colors.black
                            : Colors.black45,
                        shape: BoxShape.rectangle),
                  ),
                ],
              ),
            ),
          )
      ],
    );
  }
}
