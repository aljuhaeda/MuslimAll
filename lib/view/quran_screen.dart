import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/quran_controller.dart';
import '../model/quran_verse.dart';
import '../theme/app_theme.dart';
import '../widgets/islamic_pattern_painter.dart';

class QuranScreen extends StatefulWidget {
  const QuranScreen({super.key});

  @override
  State<QuranScreen> createState() => _QuranScreenState();
}

enum _QuranMode { landing, theme, random }

class _QuranScreenState extends State<QuranScreen> {
  final controller = Get.put(QuranController(), tag: 'quran');
  _QuranMode _mode = _QuranMode.landing;
  VerseTheme? _selectedTheme;

  void _openTheme(VerseTheme theme) {
    setState(() {
      _mode = _QuranMode.theme;
      _selectedTheme = theme;
    });
  }

  void _openRandom() {
    setState(() => _mode = _QuranMode.random);
    controller.fetchRandom();
  }

  void _backToLanding() => setState(() => _mode = _QuranMode.landing);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Al-Qur'an"),
        leading: _mode == _QuranMode.landing
            ? null
            : IconButton(icon: const Icon(Icons.arrow_back), onPressed: _backToLanding),
        automaticallyImplyLeading: _mode != _QuranMode.landing,
      ),
      body: switch (_mode) {
        _QuranMode.landing => _LandingView(onTheme: _openTheme, onRandom: _openRandom),
        _QuranMode.theme => _ThemeVerseView(theme: _selectedTheme!, controller: controller),
        _QuranMode.random => _RandomVerseView(controller: controller),
      },
    );
  }
}

class _LandingView extends StatelessWidget {
  final void Function(VerseTheme) onTheme;
  final VoidCallback onRandom;
  const _LandingView({required this.onTheme, required this.onRandom});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 560),
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            const Text(
              'Renungan Ayat',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: AppColors.ink),
            ),
            const SizedBox(height: 4),
            const Text(
              'Pilih tema untuk menemukan ayat yang sesuai dengan keadaan hatimu.',
              style: TextStyle(color: AppColors.inkMuted),
            ),
            const SizedBox(height: 16),
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 1.25,
              children: VerseTheme.values.map((theme) => _ThemeCard(theme: theme, onTap: () => onTheme(theme))).toList(),
            ),
            const SizedBox(height: 24),
            OutlinedButton.icon(
              onPressed: onRandom,
              icon: const Icon(Icons.shuffle_rounded),
              label: const Text('Ayat Acak'),
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                side: const BorderSide(color: AppColors.indigo),
                foregroundColor: AppColors.indigo,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ThemeCard extends StatelessWidget {
  final VerseTheme theme;
  final VoidCallback onTap;
  const _ThemeCard({required this.theme, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(18),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.card,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: AppColors.divider),
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const Icon(Icons.auto_stories_outlined, color: AppColors.amberDeep),
            const SizedBox(height: 8),
            Text(theme.label, style: const TextStyle(fontWeight: FontWeight.w700, color: AppColors.ink)),
            const SizedBox(height: 2),
            Text(theme.subtitle, style: const TextStyle(fontSize: 11.5, color: AppColors.inkMuted), maxLines: 2, overflow: TextOverflow.ellipsis),
          ],
        ),
      ),
    );
  }
}

class _ThemeVerseView extends StatelessWidget {
  final VerseTheme theme;
  final QuranController controller;
  const _ThemeVerseView({required this.theme, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final verse = controller.currentThemedVerse(theme);
      return _VerseCardScaffold(
        title: theme.label,
        subtitle: verse.reference,
        arabic: verse.arabic,
        transliteration: verse.transliteration,
        translation: verse.translation,
        onNext: () => controller.nextThemedVerse(theme),
        nextLabel: 'Ayat Lainnya',
      );
    });
  }
}

class _RandomVerseView extends StatelessWidget {
  final QuranController controller;
  const _RandomVerseView({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isFetchingRandom.value) {
        return const Center(child: CircularProgressIndicator(color: AppColors.indigo));
      }
      if (controller.errorMessage.value.isNotEmpty) {
        return Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.wifi_off_rounded, size: 40, color: AppColors.inkMuted),
                const SizedBox(height: 12),
                Text(controller.errorMessage.value, textAlign: TextAlign.center, style: const TextStyle(color: AppColors.inkMuted)),
                const SizedBox(height: 16),
                ElevatedButton(onPressed: controller.fetchRandom, child: const Text('Coba Lagi')),
              ],
            ),
          ),
        );
      }
      final surat = controller.suratAcak;
      if (surat == null) return const Center(child: Text('Data tidak tersedia'));

      return _VerseCardScaffold(
        title: '${surat.namaLatin ?? ''} (${surat.arti ?? ''})',
        subtitle: 'Ayat ${surat.ayat?.nomorAyat ?? '-'} dari ${surat.jumlahAyat ?? '-'}',
        arabic: surat.ayat?.teksArab ?? '',
        transliteration: surat.ayat?.teksLatin ?? '',
        translation: surat.ayat?.teksIndonesia ?? '',
        onNext: controller.fetchRandom,
        nextLabel: 'Acak Lagi',
      );
    });
  }
}

/// Shared mushaf-page-style card used by both the themed and random verse
/// views.
class _VerseCardScaffold extends StatelessWidget {
  final String title;
  final String subtitle;
  final String arabic;
  final String? transliteration;
  final String translation;
  final VoidCallback onNext;
  final String nextLabel;

  const _VerseCardScaffold({
    required this.title,
    required this.subtitle,
    required this.arabic,
    this.transliteration,
    required this.translation,
    required this.onNext,
    required this.nextLabel,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 520),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                child: Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(colors: [AppColors.indigoDeep, AppColors.indigo], begin: Alignment.topLeft, end: Alignment.bottomRight),
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      const Positioned.fill(child: IslamicLatticeBackground(lineColor: Colors.white, opacity: 0.08)),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 22, 20, 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Icon(Icons.auto_stories, color: AppColors.amberLight, size: 28),
                            const SizedBox(height: 8),
                            Text(title, textAlign: TextAlign.center, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700)),
                            const SizedBox(height: 4),
                            Text(subtitle, textAlign: TextAlign.center, style: const TextStyle(color: AppColors.amberLight, fontSize: 13)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(24, 20, 24, 28),
                decoration: const BoxDecoration(
                  color: AppColors.card,
                  borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
                  border: Border(
                    left: BorderSide(color: AppColors.amberLight, width: 1),
                    right: BorderSide(color: AppColors.amberLight, width: 1),
                    bottom: BorderSide(color: AppColors.amberLight, width: 1),
                  ),
                ),
                child: Column(
                  children: [
                    Text(arabic, style: const TextStyle(fontSize: 24, height: 1.9, color: AppColors.ink), textAlign: TextAlign.center, textDirection: TextDirection.rtl),
                    if (transliteration != null && transliteration!.isNotEmpty) ...[
                      const SizedBox(height: 14),
                      Text(transliteration!, style: const TextStyle(fontSize: 14, fontStyle: FontStyle.italic, color: AppColors.indigo), textAlign: TextAlign.center),
                    ],
                    const SizedBox(height: 16),
                    const _GoldDiamondRow(),
                    const SizedBox(height: 16),
                    Text(translation, style: const TextStyle(fontSize: 15, color: AppColors.inkMuted, height: 1.5), textAlign: TextAlign.center),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: onNext,
                icon: const Icon(Icons.shuffle_rounded, size: 18),
                label: Text(nextLabel),
              ),
              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }
}

class _GoldDiamondRow extends StatelessWidget {
  const _GoldDiamondRow();

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisSize: MainAxisSize.min,
      children: [_Diamond(), SizedBox(width: 8), _Diamond(small: true), SizedBox(width: 8), _Diamond()],
    );
  }
}

class _Diamond extends StatelessWidget {
  final bool small;
  const _Diamond({this.small = false});

  @override
  Widget build(BuildContext context) {
    final size = small ? 7.0 : 5.0;
    return Transform.rotate(angle: 0.785398, child: Container(width: size, height: size, color: AppColors.amber));
  }
}
