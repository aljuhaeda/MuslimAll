import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import '../widgets/islamic_pattern_painter.dart';
import 'prayer_guide_screen.dart';
import 'prayer_times_screen.dart';
import 'quran_screen.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  String _greetingSubtext() {
    final hour = DateTime.now().hour;
    if (hour < 4) return 'Semoga malammu tenang.';
    if (hour < 10) return 'Selamat pagi, semoga harimu berkah.';
    if (hour < 15) return 'Selamat siang, jangan lupa istirahat sejenak.';
    if (hour < 18) return 'Selamat sore, tetap semangat.';
    return 'Selamat malam, semoga Allah menjaga langkahmu.';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 520),
            child: ListView(
              padding: const EdgeInsets.fromLTRB(24, 48, 24, 32),
              children: [
                Stack(
                  children: [
                    Positioned.fill(
                      child: IslamicLatticeBackground(lineColor: AppColors.teal, opacity: 0.035),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(14),
                            decoration: const BoxDecoration(color: AppColors.tealSoft, shape: BoxShape.circle),
                            child: const Icon(Icons.mosque_rounded, color: AppColors.tealDeep, size: 26),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            "Assalamu'alaikum",
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: AppColors.ink),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            _greetingSubtext(),
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontSize: 14.5, color: AppColors.inkMuted, height: 1.5),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 40),
                _HomeOptionCard(
                  icon: Icons.access_time_filled_rounded,
                  title: 'Jadwal Sholat',
                  subtitle: 'Waktu sholat untuk seluruh Indonesia',
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const PrayerTimesScreen())),
                ),
                const SizedBox(height: 12),
                _HomeOptionCard(
                  icon: Icons.self_improvement_rounded,
                  title: 'Panduan Sholat',
                  subtitle: 'Tuntunan langkah demi langkah, lengkap 5 waktu',
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const PrayerGuideScreen())),
                ),
                const SizedBox(height: 12),
                _HomeOptionCard(
                  icon: Icons.auto_stories_rounded,
                  title: "Al-Qur'an",
                  subtitle: 'Renungan ayat pilihan atau ayat acak',
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const QuranScreen())),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _HomeOptionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _HomeOptionCard({required this.icon, required this.title, required this.subtitle, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.card,
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: AppColors.divider),
          ),
          padding: const EdgeInsets.all(18),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(11),
                decoration: BoxDecoration(color: AppColors.tealSoft, borderRadius: BorderRadius.circular(11)),
                child: Icon(icon, color: AppColors.tealDeep, size: 22),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontFamily: AppTheme.displayFontFamily,
                        fontSize: 16.5,
                        fontWeight: FontWeight.w600,
                        color: AppColors.ink,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(subtitle, style: const TextStyle(fontSize: 12.5, color: AppColors.inkMuted)),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right_rounded, color: AppColors.inkFaint),
            ],
          ),
        ),
      ),
    );
  }
}
