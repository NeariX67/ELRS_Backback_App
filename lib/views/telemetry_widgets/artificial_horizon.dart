import 'package:flutter/material.dart';
import 'dart:math';

class ArtificialHorizon extends StatelessWidget {
  final double pitch; // degrees
  final double roll; // degrees

  const ArtificialHorizon({super.key, required this.pitch, required this.roll});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Container(
              width: constraints.maxWidth,
              height: constraints.maxWidth,
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.black,
              ),
              child: CustomPaint(painter: _HorizonPainter(pitch, roll)),
            );
          },
        ),
      ),
    );
  }
}

class _HorizonPainter extends CustomPainter {
  final double pitch;
  final double roll;

  _HorizonPainter(this.pitch, this.roll);

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final double radius = size.width / 2 - 10;
    const double pitchScale = 2.5;
    const int maxPitch = 60;

    final Paint skyPaint = Paint()..color = Colors.blue.shade700;
    final Paint groundPaint = Paint()..color = Colors.brown.shade700;
    final Paint linePaint =
        Paint()
          ..color = Colors.white
          ..strokeWidth = 2;
    final Paint thickLinePaint =
        Paint()
          ..color = Colors.white
          ..strokeWidth = 3;

    final textStyle = TextStyle(color: Colors.white, fontSize: 10);

    // === CLIP CIRCLE FOR HORIZON ===
    canvas.save();
    canvas.clipPath(
      Path()..addOval(Rect.fromCircle(center: center, radius: radius)),
    );

    // === MOVING HORIZON ===
    canvas.save();
    canvas.translate(center.dx, center.dy);
    canvas.rotate(-roll * pi / 180);
    canvas.translate(0, pitch * pitchScale);

    Rect sky = Rect.fromLTWH(
      -size.width,
      -size.height * 2,
      size.width * 2,
      size.height * 2,
    );
    Rect ground = Rect.fromLTWH(
      -size.width,
      0,
      size.width * 2,
      size.height * 2,
    );
    canvas.drawRect(sky, skyPaint);
    canvas.drawRect(ground, groundPaint);
    canvas.drawLine(Offset(-size.width, 0), Offset(size.width, 0), linePaint);

    for (int angle = -maxPitch; angle <= maxPitch; angle += 10) {
      if (angle == 0) continue;
      double y = -angle * pitchScale;
      double lineLength = angle % 20 == 0 ? 20 : 10;
      canvas.drawLine(
        Offset(-lineLength.toDouble(), y),
        Offset(lineLength.toDouble(), y),
        linePaint,
      );

      final textSpan = TextSpan(text: angle.abs().toString(), style: textStyle);
      final tp = TextPainter(text: textSpan, textDirection: TextDirection.ltr)
        ..layout();
      tp.paint(canvas, Offset(lineLength + 4, y - tp.height / 2));
      tp.paint(canvas, Offset(-lineLength - tp.width - 4, y - tp.height / 2));
    }

    canvas.restore(); // restore after pitch/roll
    canvas.restore(); // restore clipping

    // === FIXED AIRCRAFT MARKERS ===
    canvas.drawLine(
      Offset(center.dx - 30, center.dy),
      Offset(center.dx + 30, center.dy),
      thickLinePaint,
    );
    canvas.drawLine(
      Offset(center.dx, center.dy - 10),
      Offset(center.dx, center.dy + 10),
      thickLinePaint,
    );

    // === ROLL TICKS OUTSIDE CIRCLE ===
    for (double angle = -90; angle <= 90; angle += 7.5) {
      bool isMajor = angle % 30 == 0;
      bool isMinor = angle % 15 == 0;
      double tickLength =
          isMajor
              ? 15
              : isMinor
              ? 12.5
              : 10;
      double tickAngleRad = (angle - roll) * pi / 180;

      double outerR = radius + 8;
      double innerR = outerR - tickLength;

      Offset start = Offset(
        center.dx + innerR * sin(tickAngleRad),
        center.dy - innerR * cos(tickAngleRad),
      );
      Offset end = Offset(
        center.dx + outerR * sin(tickAngleRad),
        center.dy - outerR * cos(tickAngleRad),
      );

      canvas.drawLine(start, end, isMajor ? thickLinePaint : linePaint);
    }

    // === TOP TRIANGLE ===
    Path triangle = Path();
    triangle.moveTo(center.dx, center.dy - radius - 14);
    triangle.lineTo(center.dx - 6, center.dy - radius - 2);
    triangle.lineTo(center.dx + 6, center.dy - radius - 2);
    triangle.close();
    canvas.drawPath(triangle, linePaint);

    // === METALLIC BEZEL ===
    final Paint bezelPaint =
        Paint()
          ..shader = RadialGradient(
            colors: [Colors.grey.shade800, Colors.grey.shade300, Colors.black],
            stops: [0.6, 0.9, 1.0],
          ).createShader(Rect.fromCircle(center: center, radius: radius + 12))
          ..style = PaintingStyle.stroke
          ..strokeWidth = 10;

    canvas.drawCircle(center, radius + 6, bezelPaint);

    // === FIXED ROLL INDICATOR LINE AT TOP CENTER ===
    final Paint rollPointerPaint =
        Paint()
          ..color = Colors.yellowAccent
          ..strokeWidth = 3;

    const double pointerLength = 20;
    final double pointerX = center.dx;
    final double pointerY = center.dy - radius - 20;

    canvas.drawLine(
      Offset(pointerX, pointerY),
      Offset(pointerX, pointerY + pointerLength),
      rollPointerPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
