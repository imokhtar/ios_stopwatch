
extension ClokcDuratiion on Duration {
  String digitalClockString() {
    var str = this.toString().replaceRange(10, 14, '');
    if (this.inHours < 1) {
      str = str.replaceRange(0, 2, '');
    }
    return str;
  }
}