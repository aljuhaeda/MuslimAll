import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/prayer_guides.dart';
import '../logic/step_manager.dart';
import '../logic/variation_selector.dart';
import '../model/prayer_guide.dart';

class GuideController extends GetxController {
  final selectedPrayerId = 'subuh'.obs;
  final userConfig = const UserConfig().obs;
  final audioOn = false.obs;
  final currentStepIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    _loadConfig();
  }

  Future<void> _loadConfig() async {
    final prefs = await SharedPreferences.getInstance();
    final qunutEnabled = prefs.getBool('qunut_enabled') ?? true;
    userConfig.value = userConfig.value.copyWith(qunutEnabled: qunutEnabled);
  }

  Future<void> setQunutEnabled(bool enabled) async {
    userConfig.value = userConfig.value.copyWith(qunutEnabled: enabled);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('qunut_enabled', enabled);
  }

  PrayerGuide get selectedGuide =>
      allPrayerGuides.firstWhere((g) => g.id == selectedPrayerId.value, orElse: () => subuhGuide);

  List<PrayerStep> get visibleSteps => StepManager.getStepsForPrayer(selectedGuide, userConfig.value);

  Map<String, ContentVariation> get resolvedVariations =>
      VariationSelector.resolveForSteps(visibleSteps, selectedGuide.variations, userConfig.value.profileType);

  void selectPrayer(String id) {
    selectedPrayerId.value = id;
    currentStepIndex.value = 0;
  }

  void toggleAudio() => audioOn.value = !audioOn.value;
}
