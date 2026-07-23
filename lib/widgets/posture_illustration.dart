import 'package:flutter/material.dart';

/// The seven distinct body positions that occur across the five daily
/// prayers.
enum PrayerPosture { standing, takbir, ruku, iktidal, sujud, duduk, salam }

/// Maps a prayer-guide step id to which posture it depicts.
PrayerPosture postureFromStepId(String stepId) {
  if (stepId.contains('takbir')) return PrayerPosture.takbir;
  if (stepId.contains('ruku')) return PrayerPosture.ruku;
  if (stepId.contains('iktidal')) return PrayerPosture.iktidal;
  if (stepId.contains('sujud')) return PrayerPosture.sujud;
  if (stepId.contains('duduk') || stepId.contains('tahiyat')) return PrayerPosture.duduk;
  if (stepId.contains('salam')) return PrayerPosture.salam;
  // niat, iftitah, fatihah, qunut are all recited standing.
  return PrayerPosture.standing;
}

/// A rounded-limb "peg figure" illustration of a single prayer posture,
/// replacing salatwebapp's minimal/broken stick-figure SVGs (mis-bent ruku'
/// back, a stray-line sujud with no legs). Faceless and stylized by design —
/// consistent with the app's geometric-motif visual language rather than a
/// literal character — but anatomically plausible and posed correctly per
/// the position it names.
class PostureIllustration extends StatelessWidget {
  final PrayerPosture posture;
  final Color color;
  final double size;

  const PostureIllustration({
    super.key,
    required this.posture,
    required this.color,
    this.size = 140,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(
        painter: _PostureIllustrationPainter(posture: posture, color: color),
      ),
    );
  }
}

class _PostureIllustrationPainter extends CustomPainter {
  final PrayerPosture posture;
  final Color color;

  _PostureIllustrationPainter({required this.posture, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final limbPaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.052
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;
    final headPaint = Paint()..color = color;

    Offset p(double x, double y) => Offset(x * size.width, y * size.height);

    switch (posture) {
      case PrayerPosture.standing:
        _drawLimb(canvas, limbPaint, [p(0.5, 0.28), p(0.5, 0.62)]); // torso
        _drawLimb(canvas, limbPaint, [p(0.5, 0.62), p(0.4, 0.94)]); // left leg
        _drawLimb(canvas, limbPaint, [p(0.5, 0.62), p(0.6, 0.94)]); // right leg
        // arms folded across the chest (sedekap)
        _drawLimb(canvas, limbPaint, [p(0.5, 0.36), p(0.62, 0.46), p(0.42, 0.5)]);
        canvas.drawCircle(p(0.5, 0.16), size.width * 0.1, headPaint);
        break;

      case PrayerPosture.takbir:
        _drawLimb(canvas, limbPaint, [p(0.5, 0.28), p(0.5, 0.62)]);
        _drawLimb(canvas, limbPaint, [p(0.5, 0.62), p(0.42, 0.94)]);
        _drawLimb(canvas, limbPaint, [p(0.5, 0.62), p(0.58, 0.94)]);
        _drawLimb(canvas, limbPaint, [p(0.5, 0.3), p(0.28, 0.12)]); // left arm up
        _drawLimb(canvas, limbPaint, [p(0.5, 0.3), p(0.72, 0.12)]); // right arm up
        canvas.drawCircle(p(0.5, 0.16), size.width * 0.1, headPaint);
        break;

      case PrayerPosture.ruku:
        // Back bent ~90 degrees at the hip; flat back, hands on knees.
        _drawLimb(canvas, limbPaint, [p(0.28, 0.42), p(0.66, 0.42)]); // flat back
        _drawLimb(canvas, limbPaint, [p(0.66, 0.42), p(0.68, 0.9)]); // rear leg
        _drawLimb(canvas, limbPaint, [p(0.66, 0.42), p(0.5, 0.9)]); // front leg
        _drawLimb(canvas, limbPaint, [p(0.5, 0.44), p(0.55, 0.66)]); // arm to knee
        canvas.drawCircle(p(0.22, 0.4), size.width * 0.1, headPaint);
        break;

      case PrayerPosture.iktidal:
        _drawLimb(canvas, limbPaint, [p(0.5, 0.28), p(0.5, 0.62)]);
        _drawLimb(canvas, limbPaint, [p(0.5, 0.62), p(0.4, 0.94)]);
        _drawLimb(canvas, limbPaint, [p(0.5, 0.62), p(0.6, 0.94)]);
        _drawLimb(canvas, limbPaint, [p(0.5, 0.32), p(0.42, 0.58)]); // arm at side
        _drawLimb(canvas, limbPaint, [p(0.5, 0.32), p(0.58, 0.58)]);
        canvas.drawCircle(p(0.5, 0.16), size.width * 0.1, headPaint);
        break;

      case PrayerPosture.sujud:
        // Low prostration: hips raised, forehead and hands down, knees down.
        _drawLimb(canvas, limbPaint, [p(0.32, 0.9), p(0.5, 0.62), p(0.7, 0.8)]); // hips-to-shoulders arc
        _drawLimb(canvas, limbPaint, [p(0.32, 0.9), p(0.3, 0.98)]); // knee to shin
        _drawLimb(canvas, limbPaint, [p(0.7, 0.8), p(0.82, 0.94)]); // forearm to hand
        canvas.drawCircle(p(0.86, 0.94), size.width * 0.08, headPaint); // head near ground
        break;

      case PrayerPosture.duduk:
        // Seated: hips low, one leg folded under, torso upright.
        _drawLimb(canvas, limbPaint, [p(0.46, 0.9), p(0.5, 0.56)]); // torso
        _drawLimb(canvas, limbPaint, [p(0.46, 0.9), p(0.7, 0.86)]); // folded legs on the ground
        _drawLimb(canvas, limbPaint, [p(0.5, 0.66), p(0.6, 0.78)]); // arm resting on thigh
        _drawLimb(canvas, limbPaint, [p(0.5, 0.66), p(0.38, 0.78)]);
        canvas.drawCircle(p(0.5, 0.44), size.width * 0.1, headPaint);
        break;

      case PrayerPosture.salam:
        // Same seated base as duduk, head turned to one side.
        _drawLimb(canvas, limbPaint, [p(0.46, 0.9), p(0.5, 0.56)]);
        _drawLimb(canvas, limbPaint, [p(0.46, 0.9), p(0.7, 0.86)]);
        _drawLimb(canvas, limbPaint, [p(0.5, 0.66), p(0.6, 0.78)]);
        _drawLimb(canvas, limbPaint, [p(0.5, 0.66), p(0.38, 0.78)]);
        _drawLimb(canvas, limbPaint, [p(0.5, 0.5), p(0.66, 0.42)]); // neck turned toward shoulder
        canvas.drawCircle(p(0.7, 0.4), size.width * 0.1, headPaint);
        break;
    }
  }

  void _drawLimb(Canvas canvas, Paint paint, List<Offset> points) {
    final path = Path()..moveTo(points.first.dx, points.first.dy);
    for (final pt in points.skip(1)) {
      path.lineTo(pt.dx, pt.dy);
    }
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant _PostureIllustrationPainter oldDelegate) =>
      oldDelegate.posture != posture || oldDelegate.color != color;
}
