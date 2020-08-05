import 'package:flutter/material.dart';

class ClockPointer extends CustomPainter {
  bool isWithTail;
  bool isFilledCenter;
  Color color;

  ClockPointer(
      {this.color = Colors.orange, this.isWithTail, this.isFilledCenter})
      : super();

  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint
    final p1 = size.center(Offset(0, 4));
    final p2 = size.center(Offset(0, size.height / 15));
    final p3 = size.center(Offset(0, -4));
    final strokePaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..color = color;

    final fillPaint = Paint()
      ..style = PaintingStyle.fill
      ..color = color;

    if (isWithTail) {
      canvas.drawLine(p1, p2, strokePaint);
    }

    if (isFilledCenter) {
      canvas.drawCircle(size.center(Offset.zero), 4, fillPaint);
    } else {
      canvas.drawCircle(size.center(Offset.zero), 4, strokePaint);
    }

    canvas.drawLine(size.topCenter(Offset.zero), p3, strokePaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return false;
  }
}
