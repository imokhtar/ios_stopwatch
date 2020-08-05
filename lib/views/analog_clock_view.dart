import 'package:flutter/material.dart';
import 'package:ios_stopwatch/view_models/stopwatch_viewmodel.dart';
import 'analog_clock_labels_view.dart';
import 'analog_clock_ticks_view.dart';
import 'package:ios_stopwatch/painters/clock_pointer.dart';
import 'package:provider/provider.dart';
import 'package:ios_stopwatch/extensions/duration_extension.dart';
import 'dart:math';
import 'dart:ui';

class AnalogClock extends StatelessWidget {
  final labels = [60] + List<int>.generate(11, (int i) => (i + 1) * 5);
  final labels2 = [30] + List<int>.generate(5, (int i) => (i + 1) * 5);

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
        widthFactor: 1,
        child: LayoutBuilder(builder: (context, constraints) {
          return Container(
            height: constraints.maxWidth - 40,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 0),
              child: Stack(
                alignment: AlignmentDirectional.center,
                children: <Widget>[
                  ClockTicks(
                    ticksPerUnit: 4,
                    tickWidth: 2,
                    tickHeight: 15,
                    maxCycle: 60,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: ClockLabels(
                      labels: labels,
                      textStyle: TextStyle(fontSize: 20),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        bottom: (constraints.maxWidth - 100) / 2.0),
                    child: Container(
                        width: (4.0 / 15) * constraints.maxWidth,
                        height: (4.0 / 15) * constraints.maxWidth,
                        child: Stack(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(12),
                              child: ClockLabels(
                                labels: labels2,
                                textStyle: TextStyle(fontSize: 14),
                              ),
                            ),
                            ClockTicks(
                              ticksPerUnit: 2,
                              tickWidth: 1.5,
                              tickHeight: 10,
                              maxCycle: 30,
                            ),
                            Consumer<StopWatchViewModel>(
                              builder: (context, viewmodel, child) {
                                return Transform.rotate(
                                  angle: viewmodel
                                          .elapsedTime()
                                          .inMilliseconds
                                          .toDouble() /
                                      1000 /
                                      60 /
                                      30 *
                                      (2 * pi),
                                  child: CustomPaint(
                                    painter: ClockPointer(
                                        isWithTail: false,
                                        isFilledCenter: true),
                                    child: Container(),
                                  ),
                                );
                              },
                            )
                          ],
                        )),
                  ),
                  Padding(
                      padding: EdgeInsets.only(
                          top: (constraints.maxWidth - 100) / 2.0),
                      child: Consumer<StopWatchViewModel>(
                        builder: (context, viewmodel, child) {
                          return Text(
                            ClokcDuratiion(viewmodel.elapsedTime())
                                .digitalClockString(),
                            style: TextStyle(
                                fontSize: 24,
                                fontFeatures: [FontFeature.tabularFigures()]),
                          );
                        },
                      )),
                  Consumer<StopWatchViewModel>(
                    builder: (context, viewmodel, child) {
                      return Stack(
                        children: <Widget>[
                          Transform.rotate(
                            angle:
                                viewmodel.lapTime().inMilliseconds.toDouble() / 1000 / 60 * (2 * pi),
                            child: CustomPaint(
                              painter: ClockPointer(
                                  color: Colors.blueAccent,
                                  isWithTail: true,
                                  isFilledCenter: false),
                              child: Container(),
                            ),
                          ),
                          Transform.rotate(
                            angle: viewmodel.elapsedTime().inMilliseconds.toDouble() / 1000 / 60 * (2 * pi),
                            child: CustomPaint(
                              painter: ClockPointer(
                                  isWithTail: true, isFilledCenter: false),
                              child: Container(),
                            ),
                          ),
                        ],
                      );
                    },
                  )
                ],
              ),
            ),
          );
        }));
  }
}
