import '../model/prayer_guide.dart';

/// Dart port of salatwebapp's src/lib/logic/variation-selector.ts.
class VariationSelector {
  /// Selects the most appropriate content variation for a step, given the
  /// user's organization profile.
  /// Priority: exact profile match > 'general' > first available.
  static ContentVariation? select(
    List<ContentVariation> variations,
    OrganizationTag userProfile,
  ) {
    if (variations.isEmpty) return null;

    for (final v in variations) {
      if (v.orgTags.contains(userProfile)) return v;
    }

    for (final v in variations) {
      if (v.orgTags.contains(OrganizationTag.general)) return v;
    }

    return variations.first;
  }

  /// Convenience: resolves the single best variation per step_id for an
  /// entire step list (what the carousel actually renders).
  static Map<String, ContentVariation> resolveForSteps(
    List<PrayerStep> steps,
    List<ContentVariation> allVariations,
    OrganizationTag userProfile,
  ) {
    final byStep = <String, List<ContentVariation>>{};
    for (final v in allVariations) {
      byStep.putIfAbsent(v.stepIdRef, () => []).add(v);
    }

    final resolved = <String, ContentVariation>{};
    for (final step in steps) {
      final candidates = byStep[step.stepId] ?? const [];
      final chosen = select(candidates, userProfile);
      if (chosen != null) resolved[step.stepId] = chosen;
    }
    return resolved;
  }
}
