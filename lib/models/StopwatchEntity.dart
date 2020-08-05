
class StopwatchEntity {
  Duration startTime;
  Duration currentTime;
  Duration previousElapsedTime;
  Duration lastLapDuration;
  List<Duration> laps = [];
  StopwatchEntity({this.startTime, this.currentTime,}):super();


  Duration elapsedTime() {
    if (previousElapsedTime == null) {
      return currentTime - startTime;
    } else {
      return (currentTime - startTime) + previousElapsedTime;
    }
  }

  void lap() {
    Duration lapTime = elapsedTime() - lastLapDuration;
    laps.add(lapTime);
    lastLapDuration = lapTime;
  }
}