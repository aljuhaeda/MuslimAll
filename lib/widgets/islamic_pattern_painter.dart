import 'dart:math' as math;
import 'package:flutter/material.dart';

/// Hand-drawn geometric motifs for MuslimAll — no image assets.
///
/// Distinct from a classic 8-point star field: an interlocking rhombus
/// "girih" lattice (the strap-work pattern common in Islamic tiling) plus a
/// crescent-and-arc motif for card/section headers.
class IslamicLatticePainter extends CustomPainter {
  final Color lineColor;
  final double opacity;
  final double cell;

  IslamicLatticePainter({
    required this.lineColor,
    this.opacity = 0.14,
    this.cell = 36,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = lineColor.withValues(alpha: opacity)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2
      ..strokeCap = StrokeCap.round;

    final cols = (size.width / cell).ceil() + 1;
    final rows = (size.height / cell).ceil() + 1;

    for (var row = -1; row < rows; row++) {
      for (var col = -1; col < cols; col++) {
        final cx = col * cell + (row.isOdd ? cell / 2 : 0);
        final cy = row * cell * 0.75;
        _drawRhombusStar(canvas, paint, Offset(cx, cy), cell * 0.5);
      }
    }
  }

  void _drawRhombusStar(Canvas canvas, Paint paint, Offset center, double r) {
    // An 8-point interlace star built from two overlapping squares.
    final path = Path();
    for (var i = 0; i < 8; i++) {
      final angle = (math.pi / 4) * i - math.pi / 8;
      final point = Offset(
        center.dx + r * math.cos(angle),
        center.dy + r * math.sin(angle),
      );
      final innerAngle = angle + math.pi / 8;
      final innerPoint = Offset(
        center.dx + (r * 0.42) * math.cos(innerAngle),
        center.dy + (r * 0.42) * math.sin(innerAngle),
      );
      if (i == 0) {
        path.moveTo(point.dx, point.dy);
      } else {
        path.lineTo(point.dx, point.dy);
      }
      path.lineTo(innerPoint.dx, innerPoint.dy);
    }
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant IslamicLatticePainter oldDelegate) =>
      oldDelegate.lineColor != lineColor ||
      oldDelegate.opacity != opacity ||
      oldDelegate.cell != cell;
}

/// A crescent tucked inside a shallow arc — used above card titles / section
/// headers as a small signature mark rather than a full scalloped arch.
class CrescentArcPainter extends CustomPainter {
  final Color arcColor;
  final Color crescentColor;

  CrescentArcPainter({required this.arcColor, required this.crescentColor});

  @override
  void paint(Canvas canvas, Size size) {
    final arcPaint = Paint()
      ..color = arcColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.6
      ..strokeCap = StrokeCap.round;

    final rect = Rect.fromLTWH(-size.width * 0.15, 0, size.width * 1.3, size.height * 2.4);
    canvas.drawArc(rect, math.pi * 1.08, math.pi * 0.84, false, arcPaint);

    final crescentCenter = Offset(size.width / 2, size.height * 0.55);
    final outerR = size.height * 0.32;
    final crescentPaint = Paint()..color = crescentColor;

    final outerPath = Path()
      ..addOval(Rect.fromCircle(center: crescentCenter, radius: outerR));
    final innerPath = Path()
      ..addOval(Rect.fromCircle(
        center: crescentCenter.translate(outerR * 0.55, -outerR * 0.15),
        radius: outerR * 0.85,
      ));

    final crescentPath = Path.combine(PathOperation.difference, outerPath, innerPath);
    canvas.drawPath(crescentPath, crescentPaint);
  }

  @override
  bool shouldRepaint(covariant CrescentArcPainter oldDelegate) =>
      oldDelegate.arcColor != arcColor || oldDelegate.crescentColor != crescentColor;
}

/// Convenience widget wrapping [IslamicLatticePainter] as a background strip.
class IslamicLatticeBackground extends StatelessWidget {
  final Color lineColor;
  final double opacity;
  final Widget? child;

  const IslamicLatticeBackground({
    super.key,
    required this.lineColor,
    this.opacity = 0.14,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: IslamicLatticePainter(lineColor: lineColor, opacity: opacity),
      child: child,
    );
  }
}
