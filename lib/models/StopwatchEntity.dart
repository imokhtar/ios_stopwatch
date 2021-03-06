class StopwatchEntity {
  Duration startTime;
  Duration currentTime;
  Duration previousElapsedTime = Duration(seconds: 0);
  Duration lastLapDuration = Duration(seconds: 0);
  List<Duration> laps = [];
  StopwatchEntity({
    this.startTime,
    this.currentTime,
  }) : super();
}
