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
            constraints: const BoxConstraints(maxWidth: 560),
            child: ListView(
              padding: const EdgeInsets.fromLTRB(24, 32, 24, 24),
              children: [
                Stack(
                  children: [
                    Positioned.fill(
                      child: IslamicLatticeBackground(lineColor: AppColors.indigo, opacity: 0.06),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(Icons.mosque, color: AppColors.amberDeep, size: 34),
                          const SizedBox(height: 12),
                          const Text(
                            "Assalamu'alaikum",
                            style: TextStyle(fontSize: 26, fontWeight: FontWeight.w800, color: AppColors.ink),
                          ),
                          const SizedBox(height: 6),
                          Text(_greetingSubtext(), style: const TextStyle(fontSize: 14, color: AppColors.inkMuted)),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                _HomeOptionCard(
                  icon: Icons.access_time_filled_rounded,
                  title: 'Jadwal Sholat',
                  subtitle: 'Waktu sholat untuk seluruh Indonesia',
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const PrayerTimesScreen())),
                ),
                const SizedBox(height: 14),
                _HomeOptionCard(
                  icon: Icons.self_improvement_rounded,
                  title: 'Panduan Sholat',
                  subtitle: 'Tuntunan langkah demi langkah, lengkap 5 waktu',
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const PrayerGuideScreen())),
                ),
                const SizedBox(height: 14),
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
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.card,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppColors.divider),
          boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 10, offset: const Offset(0, 3))],
        ),
        padding: const EdgeInsets.all(18),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(color: AppColors.sand, borderRadius: BorderRadius.circular(14)),
              child: Icon(icon, color: AppColors.indigo, size: 26),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: AppColors.ink)),
                  const SizedBox(height: 3),
                  Text(subtitle, style: const TextStyle(fontSize: 12.5, color: AppColors.inkMuted)),
                ],
              ),
            ),
            const Icon(Icons.chevron_right_rounded, color: AppColors.inkMuted),
          ],
        ),
      ),
    );
  }
}
