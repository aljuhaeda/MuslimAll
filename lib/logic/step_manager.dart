import '../model/prayer_guide.dart';

/// Dart port of salatwebapp's src/lib/logic/step-manager.ts.
class StepManager {
  /// Filters a prayer's steps based on user configuration — currently the
  /// only conditional gate is Qunut (Subuh only).
  static List<PrayerStep> getStepsForPrayer(PrayerGuide guide, UserConfig config) {
    return guide.steps.where((step) {
      if (!step.isConditional) return true;

      if (step.conditionalType == 'qunut') {
        if (guide.id == 'subuh' && config.qunutEnabled) return true;
        return false;
      }

      return true;
    }).toList();
  }
}
