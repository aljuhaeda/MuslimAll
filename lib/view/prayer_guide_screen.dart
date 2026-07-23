import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/guide_controller.dart';
import '../data/prayer_guides.dart';
import '../model/prayer_guide.dart';
import '../theme/app_theme.dart';
import '../widgets/islamic_pattern_painter.dart';
import '../widgets/posture_illustration.dart';

class PrayerGuideScreen extends StatefulWidget {
  const PrayerGuideScreen({super.key});

  @override
  State<PrayerGuideScreen> createState() => _PrayerGuideScreenState();
}

class _PrayerGuideScreenState extends State<PrayerGuideScreen> {
  final GuideController controller = Get.put(GuideController(), tag: 'guide');
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  void _goToPrayer(String id) {
    controller.selectPrayer(id);
    _pageController.jumpToPage(0);
  }

  void _goToStep(int index) {
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Panduan Sholat')),
      body: Column(
        children: [
          _PrayerPicker(onSelect: _goToPrayer, controller: controller),
          Expanded(
            child: Obx(() {
              final steps = controller.visibleSteps;
              final variations = controller.resolvedVariations;
              return PageView.builder(
                key: ValueKey(controller.selectedPrayerId.value),
                controller: _pageController,
                onPageChanged: (i) => controller.currentStepIndex.value = i,
                itemCount: steps.length,
                itemBuilder: (context, index) {
                  final step = steps[index];
                  final variation = variations[step.stepId];
                  if (variation == null) {
                    return const Center(child: Text('Missing content for this step'));
                  }
                  return _StepCard(
                    step: step,
                    variation: variation,
                    index: index,
                    total: steps.length,
                    controller: controller,
                  );
                },
              );
            }),
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
          child: Obx(() {
            final index = controller.currentStepIndex.value;
            final total = controller.visibleSteps.length;
            final isFirst = index <= 0;
            final isLast = index >= total - 1;
            return Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: isFirst ? null : () => _goToStep(index - 1),
                    icon: const Icon(Icons.arrow_back),
                    label: const Text('Sebelumnya'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: FilledButton.icon(
                    onPressed: isLast ? null : () => _goToStep(index + 1),
                    icon: const Icon(Icons.arrow_forward),
                    label: const Text('Selanjutnya'),
                  ),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}

class _PrayerPicker extends StatelessWidget {
  final void Function(String id) onSelect;
  final GuideController controller;

  const _PrayerPicker({required this.onSelect, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.indigoDeep,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
      child: SizedBox(
        height: 40,
        child: Obx(() => ListView(
              scrollDirection: Axis.horizontal,
              children: allPrayerGuides.map((guide) {
                final selected = controller.selectedPrayerId.value == guide.id;
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: ChoiceChip(
                    label: Text(guide.label),
                    selected: selected,
                    onSelected: (_) => onSelect(guide.id),
                    selectedColor: AppColors.amber,
                    backgroundColor: AppColors.indigoLight,
                    labelStyle: TextStyle(
                      color: selected ? AppColors.indigoDeep : Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                );
              }).toList(),
            )),
      ),
    );
  }
}

class _StepCard extends StatelessWidget {
  final PrayerStep step;
  final ContentVariation variation;
  final int index;
  final int total;
  final GuideController controller;

  const _StepCard({
    required this.step,
    required this.variation,
    required this.index,
    required this.total,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final posture = postureFromStepId(step.stepId);
    final fontScale = controller.userConfig.value.fontScale;

    return Stack(
      children: [
        Positioned.fill(
          child: IslamicLatticeBackground(lineColor: AppColors.indigo, opacity: 0.05),
        ),
        SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 90),
          child: Column(
            children: [
              Text('Langkah ${index + 1} dari $total', style: const TextStyle(color: AppColors.inkMuted)),
              const SizedBox(height: 12),
              PostureIllustration(posture: posture, color: AppColors.indigo, size: 130),
              const SizedBox(height: 20),
              Card(
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  side: const BorderSide(color: AppColors.divider),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        variation.content.arabic,
                        textAlign: TextAlign.center,
                        textDirection: TextDirection.rtl,
                        style: TextStyle(fontSize: 24 * fontScale, height: 1.8, color: AppColors.ink),
                      ),
                      if (variation.content.transliteration != null) ...[
                        const SizedBox(height: 14),
                        Text(
                          variation.content.transliteration!,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14 * fontScale,
                            fontStyle: FontStyle.italic,
                            color: AppColors.indigo,
                          ),
                        ),
                      ],
                      if (variation.content.translation != null) ...[
                        const SizedBox(height: 10),
                        Text(
                          variation.content.translation!,
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 13 * fontScale, color: AppColors.inkMuted),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 14),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Chip(
                    avatar: const Icon(Icons.menu_book, size: 16, color: AppColors.amberDeep),
                    label: Text('Dalil: ${variation.meta.sourceDalil}'),
                    backgroundColor: AppColors.amberLight.withValues(alpha: 0.4),
                  ),
                  const SizedBox(width: 8),
                  Obx(() {
                    final hasAudio = variation.content.audioUrl != null;
                    final playing = hasAudio && controller.audioOn.value;
                    return IconButton(
                      onPressed: hasAudio ? controller.toggleAudio : null,
                      icon: Icon(
                        playing ? Icons.volume_up : Icons.volume_off,
                        color: hasAudio ? AppColors.indigo : AppColors.inkMuted,
                      ),
                      tooltip: hasAudio
                          ? (playing ? 'Hentikan audio' : 'Putar audio')
                          : 'Audio belum tersedia untuk langkah ini',
                    );
                  }),
                ],
              ),
              if (step.isConditional && step.conditionalType == 'qunut')
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Obx(() => SwitchListTile(
                        value: controller.userConfig.value.qunutEnabled,
                        onChanged: controller.setQunutEnabled,
                        title: const Text('Baca Qunut'),
                        activeThumbColor: AppColors.amber,
                      )),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
