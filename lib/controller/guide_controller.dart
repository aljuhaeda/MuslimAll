import 'package:audioplayers/audioplayers.dart';
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

  final AudioPlayer _player = AudioPlayer();

  @override
  void onInit() {
    super.onInit();
    _loadConfig();
    _player.onPlayerComplete.listen((_) => audioOn.value = false);
    // Stop playback whenever the visible step changes, so audio from a
    // previous step never keeps playing under a new one.
    ever(currentStepIndex, (_) => _stopAudio());
    ever(selectedPrayerId, (_) => _stopAudio());
  }

  @override
  void onClose() {
    _player.dispose();
    super.onClose();
  }

  /// The URL for the step currently on screen, if one exists.
  String? get currentStepAudioUrl {
    if (currentStepIndex.value >= visibleSteps.length) return null;
    final step = visibleSteps[currentStepIndex.value];
    return resolvedVariations[step.stepId]?.content.audioUrl;
  }

  Future<void> toggleAudio() async {
    final url = currentStepAudioUrl;
    if (url == null) return;
    if (audioOn.value) {
      await _stopAudio();
    } else {
      audioOn.value = true;
      await _player.play(UrlSource(url));
    }
  }

  Future<void> _stopAudio() async {
    if (audioOn.value) {
      audioOn.value = false;
      await _player.stop();
    }
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
}
