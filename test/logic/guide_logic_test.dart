import 'package:flutter_test/flutter_test.dart';
import 'package:muslimall_app/data/prayer_guides.dart';
import 'package:muslimall_app/logic/step_manager.dart';
import 'package:muslimall_app/logic/variation_selector.dart';
import 'package:muslimall_app/model/prayer_guide.dart';

void main() {
  group('StepManager', () {
    test('includes Qunut in Subuh when enabled', () {
      const config = UserConfig(qunutEnabled: true);
      final steps = StepManager.getStepsForPrayer(subuhGuide, config);
      expect(steps.any((s) => s.conditionalType == 'qunut'), isTrue);
    });

    test('excludes Qunut from Subuh when disabled', () {
      const config = UserConfig(qunutEnabled: false);
      final steps = StepManager.getStepsForPrayer(subuhGuide, config);
      expect(steps.any((s) => s.conditionalType == 'qunut'), isFalse);
    });

    test('non-Subuh prayers never include a Qunut step, even if enabled', () {
      const config = UserConfig(qunutEnabled: true);
      for (final guide in [dzuhurGuide, asharGuide, maghribGuide, isyaGuide]) {
        final steps = StepManager.getStepsForPrayer(guide, config);
        expect(steps.any((s) => s.conditionalType == 'qunut'), isFalse, reason: guide.id);
      }
    });
  });

  group('VariationSelector', () {
    test('prefers an exact org-tag match over general', () {
      final variations = [
        const ContentVariation(
          id: 'a',
          stepIdRef: 's',
          orgTags: [OrganizationTag.general],
          content: StepContent(arabic: 'general'),
          meta: StepMeta(sourceDalil: 'x', readingMode: ReadingMode.sirr),
        ),
        const ContentVariation(
          id: 'b',
          stepIdRef: 's',
          orgTags: [OrganizationTag.muhammadiyah],
          content: StepContent(arabic: 'muhammadiyah'),
          meta: StepMeta(sourceDalil: 'x', readingMode: ReadingMode.sirr),
        ),
      ];
      final chosen = VariationSelector.select(variations, OrganizationTag.muhammadiyah);
      expect(chosen?.content.arabic, 'muhammadiyah');
    });

    test('falls back to general when no exact match exists', () {
      final variations = [
        const ContentVariation(
          id: 'a',
          stepIdRef: 's',
          orgTags: [OrganizationTag.general],
          content: StepContent(arabic: 'general'),
          meta: StepMeta(sourceDalil: 'x', readingMode: ReadingMode.sirr),
        ),
      ];
      final chosen = VariationSelector.select(variations, OrganizationTag.salafi);
      expect(chosen?.content.arabic, 'general');
    });

    test('falls back to the first available variation as a last resort', () {
      final variations = [
        const ContentVariation(
          id: 'a',
          stepIdRef: 's',
          orgTags: [OrganizationTag.nu],
          content: StepContent(arabic: 'nu-only'),
          meta: StepMeta(sourceDalil: 'x', readingMode: ReadingMode.sirr),
        ),
      ];
      final chosen = VariationSelector.select(variations, OrganizationTag.salafi);
      expect(chosen?.content.arabic, 'nu-only');
    });

    test('resolveForSteps resolves every visible step to a variation', () {
      const config = UserConfig();
      final steps = StepManager.getStepsForPrayer(dzuhurGuide, config);
      final resolved = VariationSelector.resolveForSteps(steps, dzuhurGuide.variations, config.profileType);
      for (final step in steps) {
        expect(resolved.containsKey(step.stepId), isTrue, reason: 'missing variation for ${step.stepId}');
      }
    });
  });

  group('buildGuide structural correctness', () {
    test('Dzuhur, Ashar, Isya have 4 rakaat and a tahiyat awal after rakaat 2', () {
      for (final guide in [dzuhurGuide, asharGuide, isyaGuide]) {
        expect(guide.rakaat, 4);
        expect(guide.steps.any((s) => s.stepId == '${guide.id}_s_tahiyat_awal'), isTrue);
        expect(guide.steps.any((s) => s.stepId == '${guide.id}_s_fatihah_r4'), isTrue);
      }
    });

    test('Maghrib has 3 rakaat and a tahiyat awal after rakaat 2', () {
      expect(maghribGuide.rakaat, 3);
      expect(maghribGuide.steps.any((s) => s.stepId == 'maghrib_s_tahiyat_awal'), isTrue);
      expect(maghribGuide.steps.any((s) => s.stepId == 'maghrib_s_fatihah_r3'), isTrue);
    });

    test('Subuh has 2 rakaat and no tahiyat awal', () {
      expect(subuhGuide.rakaat, 2);
      expect(subuhGuide.steps.any((s) => s.stepId == 'subuh_s_tahiyat_awal'), isFalse);
    });

    test('every prayer ends with tahiyat akhir then salam', () {
      for (final guide in allPrayerGuides) {
        final ids = guide.steps.map((s) => s.stepId).toList();
        expect(ids[ids.length - 2], '${guide.id}_s_tahiyat_akhir');
        expect(ids.last, '${guide.id}_s_salam');
      }
    });
  });
}
