import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:ios_stopwatch/models/StopwatchEntity.dart';

class StopWatchViewModel extends ChangeNotifier {

  Timer timer;
  StopwatchEntity stopwatchEntity = StopwatchEntity(startTime: Duration(seconds: 0), currentTime: Duration(seconds: 0));
  bool isRunning = false;

  List<Duration> laps() {
    if (lapTime().inMilliseconds == 0)  {
      return stopwatchEntity.laps.reversed.toList();
    } else {
      return (stopwatchEntity.laps + [lapTime()]).reversed.toList();
    }
  }

  Duration elapsedTime() {
    if (stopwatchEntity.previousElapsedTime == null) {
      return stopwatchEntity.currentTime - stopwatchEntity.startTime;
    } else {
      return (stopwatchEntity.currentTime - stopwatchEntity.startTime) + stopwatchEntity.previousElapsedTime;
    }
  }

  Duration lapTime() {
    return elapsedTime() - stopwatchEntity.lastLapDuration;
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
    stopwatchEntity.previousElapsedTime = elapsedTime();
    stopwatchEntity.startTime = Duration(seconds: 0);
    stopwatchEntity.currentTime = Duration(seconds: 0);
    isRunning = false;
    notifyListeners();
  }

  void reset() {
    stopwatchEntity = StopwatchEntity(startTime: Duration(seconds: 0), currentTime: Duration(seconds: 0));
    notifyListeners();
  }

  void lap() {
    stopwatchEntity.laps.add(lapTime());
    stopwatchEntity.lastLapDuration = elapsedTime();
    notifyListeners();
  }

}


