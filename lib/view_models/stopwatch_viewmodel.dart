import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:ios_stopwatch/models/StopwatchEntity.dart';

class StopWatchViewModel extends ChangeNotifier {

  Timer timer;
  StopwatchEntity stopwatchEntity = StopwatchEntity(startTime: Duration(seconds: 0), currentTime: Duration(seconds: 0));
  bool isRunning = false;

  List<Duration> laps() {
    return stopwatchEntity.laps.reversed.toList();
  }

  void start() {
    int startTimeInMilliSecs = DateTime.now().millisecondsSinceEpoch;
    Duration startTime = Duration(milliseconds: startTimeInMilliSecs);
    stopwatchEntity.startTime = startTime;
    stopwatchEntity.currentTime = startTime;
    stopwatchEntity.lastLapDuration = Duration(seconds: 0);
    timer = Timer.periodic(Duration(milliseconds: 16), (timer) {
      int currentTimeInMilliSecs = DateTime.now().millisecondsSinceEpoch;
      Duration currentTime = Duration(milliseconds: currentTimeInMilliSecs);
      stopwatchEntity.currentTime = currentTime;
      notifyListeners();
    });
    isRunning = true;
    notifyListeners();
  }

  void pause() {
    timer.cancel();
    timer = null;
    stopwatchEntity.previousElapsedTime = stopwatchEntity.elapsedTime();
    stopwatchEntity.startTime = Duration(seconds: 0);
    stopwatchEntity.currentTime = Duration(seconds: 0);
    isRunning = false;
    notifyListeners();
  }

  void reset() {
    stopwatchEntity.previousElapsedTime = Duration(seconds: 0);
    stopwatchEntity.startTime = Duration(seconds: 0);
    stopwatchEntity.currentTime = Duration(seconds: 0);
    stopwatchEntity.laps = [];
    notifyListeners();
  }

  void lap() {
    stopwatchEntity.lap();
    notifyListeners();
  }

}


