import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:ui';

class ClockLabels extends StatelessWidget {
  ClockLabels({this.labels, this.textStyle}) : super();
  final List<int> labels;
  final TextStyle textStyle;
  @override
  Widget build(BuildContext context) {
    var indices = labels.asMap().keys.toList();
    return Stack(
      children: <Widget>[
        for (var i in indices)
          Transform.rotate(
            angle: (((i/labels.length) * 2 * pi) - pi),
            child: Column(
              children: <Widget>[
                Expanded(
                  flex: 2,
                  child: Container(),
                ),
                Transform.rotate(
                  angle: -(((i/labels.length) * 2 * pi) - pi),
                  child: Text('${labels[i]}',style: textStyle,),
                )
              ],
            ),
          )
      ],
    );
  }
}