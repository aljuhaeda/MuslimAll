/// Prayer-guide domain models — Dart port of salatwebapp's
/// src/types/index.ts, adapted for bundled const data instead of a
/// Dexie/IndexedDB-backed store (no local DB needed: step/variation content
/// is static reference data, and UserConfig is a single small record kept
/// in shared_preferences).
library;

enum OrganizationTag { nu, muhammadiyah, salafi, general }

enum ReadingMode { jahar, sirr }

class PrayerStep {
  final String stepId; // e.g. 's01_niat'
  final int stepOrder;
  final bool isConditional;
  final String? conditionalType; // e.g. 'qunut'

  const PrayerStep({
    required this.stepId,
    required this.stepOrder,
    this.isConditional = false,
    this.conditionalType,
  });
}

class StepContent {
  final String arabic;
  final String? transliteration;
  final String? translation;
  // Streamed, not bundled — same pattern as prayer times/Quran verses
  // elsewhere in the app. Null where no verified free/licensed source
  // exists yet (see FLAG FOR REVIEW in guide_builder.dart).
  final String? audioUrl;

  const StepContent({
    required this.arabic,
    this.transliteration,
    this.translation,
    this.audioUrl,
  });
}

class StepMeta {
  final String sourceDalil;
  final ReadingMode readingMode;

  const StepMeta({required this.sourceDalil, required this.readingMode});
}

class ContentVariation {
  final String id; // e.g. 'iftitah_allahumma_baid'
  final String stepIdRef;
  final List<OrganizationTag> orgTags;
  final StepContent content;
  final StepMeta meta;

  const ContentVariation({
    required this.id,
    required this.stepIdRef,
    required this.orgTags,
    required this.content,
    required this.meta,
  });
}

class UserConfig {
  final OrganizationTag profileType;
  final bool qunutEnabled;
  final ReadingMode basmalahMode;
  final double fontScale; // 0.75 to 1.5

  const UserConfig({
    this.profileType = OrganizationTag.general,
    this.qunutEnabled = true,
    this.basmalahMode = ReadingMode.sirr,
    this.fontScale = 1.0,
  });

  UserConfig copyWith({
    OrganizationTag? profileType,
    bool? qunutEnabled,
    ReadingMode? basmalahMode,
    double? fontScale,
  }) {
    return UserConfig(
      profileType: profileType ?? this.profileType,
      qunutEnabled: qunutEnabled ?? this.qunutEnabled,
      basmalahMode: basmalahMode ?? this.basmalahMode,
      fontScale: fontScale ?? this.fontScale,
    );
  }
}

/// One of the five daily prayers, each with its own step list + variations.
class PrayerGuide {
  final String id; // e.g. 'subuh'
  final String label; // e.g. 'Subuh'
  final int rakaat;
  final List<PrayerStep> steps;
  final List<ContentVariation> variations;

  const PrayerGuide({
    required this.id,
    required this.label,
    required this.rakaat,
    required this.steps,
    required this.variations,
  });
}
