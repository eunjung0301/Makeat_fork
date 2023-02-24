import 'package:flutter/material.dart';

class CircleIndiCatorPaint extends CustomPainter {
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    throw UnimplementedError();
  }

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.purple
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    var rect = Rect.fromCenter(
        center: Offset(size.width / 2, size.height / 2),
        width: size.width,
        height: size.height);
    var startAngle = 3.14 / 180 * 0;
    var sweepAngle = 3.14 / 180 * 359;
    canvas.drawArc(rect, startAngle, sweepAngle, false, paint);

    /// [case 2]
    // Path path = Path();
    // path.arcTo(rect, pi / 180 * 0, pi / 180 * 359, true);
    // canvas.drawPath(path, paint);
  }
}
