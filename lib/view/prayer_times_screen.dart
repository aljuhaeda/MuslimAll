import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/times_controller.dart';
import '../data/indonesia_cities.dart';
import '../model/jadwal_shalat.dart';
import '../theme/app_theme.dart';
import '../widgets/islamic_pattern_painter.dart';

class PrayerTimesScreen extends StatefulWidget {
  const PrayerTimesScreen({super.key});

  @override
  State<PrayerTimesScreen> createState() => _PrayerTimesScreenState();
}

class _PrayerEntry {
  final String name;
  final String? time;
  final IconData icon;
  const _PrayerEntry(this.name, this.time, this.icon);
}

class _PrayerTimesScreenState extends State<PrayerTimesScreen> {
  final controller = Get.put(TimesController(), tag: 'times');

  String? _nextPrayerName(JadwalShalat jadwal) {
    final entries = <MapEntry<String, String?>>[
      MapEntry('Subuh', jadwal.subuh),
      MapEntry('Dzuhur', jadwal.dzuhur),
      MapEntry('Ashar', jadwal.ashar),
      MapEntry('Maghrib', jadwal.maghrib),
      MapEntry('Isya', jadwal.isya),
    ];
    final now = TimeOfDay.now();
    final nowMinutes = now.hour * 60 + now.minute;

    for (final entry in entries) {
      final minutes = _toMinutes(entry.value);
      if (minutes != null && minutes > nowMinutes) return entry.key;
    }
    return 'Subuh';
  }

  int? _toMinutes(String? hhmm) {
    if (hhmm == null) return null;
    final parts = hhmm.split(':');
    if (parts.length != 2) return null;
    final h = int.tryParse(parts[0]);
    final m = int.tryParse(parts[1]);
    if (h == null || m == null) return null;
    return h * 60 + m;
  }

  Future<void> _pickCity() async {
    final chosen = await showModalBottomSheet<String>(
      context: context,
      backgroundColor: AppColors.card,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) => _CityPickerSheet(cities: indonesianCities, current: controller.selectedCity.value),
    );
    if (chosen != null) controller.setCity(chosen);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Jadwal Sholat'),
        actions: [
          IconButton(icon: const Icon(Icons.location_on_outlined), onPressed: _pickCity),
        ],
      ),
      body: Obx(() {
        if (controller.isFetching.value) {
          return const Center(child: CircularProgressIndicator(color: AppColors.indigo));
        }
        if (controller.errorMessage.value.isNotEmpty) {
          return _ErrorState(message: controller.errorMessage.value, onRetry: controller.fetchData);
        }
        final jadwal = controller.jadwalShalat;
        if (jadwal == null) return const Center(child: Text('Data tidak tersedia'));

        final nextPrayer = _nextPrayerName(jadwal);
        final entries = [
          _PrayerEntry('Imsak', jadwal.imsak, Icons.nightlight_round),
          _PrayerEntry('Subuh', jadwal.subuh, Icons.wb_twilight),
          _PrayerEntry('Terbit', jadwal.terbit, Icons.wb_sunny_outlined),
          _PrayerEntry('Dzuhur', jadwal.dzuhur, Icons.light_mode),
          _PrayerEntry('Ashar', jadwal.ashar, Icons.wb_cloudy_outlined),
          _PrayerEntry('Maghrib', jadwal.maghrib, Icons.wb_twilight),
          _PrayerEntry('Isya', jadwal.isya, Icons.dark_mode_outlined),
        ];

        return RefreshIndicator(
          color: AppColors.indigo,
          onRefresh: controller.fetchData,
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 520),
              child: ListView(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
                children: [
                  _DateHeaderCard(tanggal: jadwal.tanggal, city: controller.selectedCity.value, onTapCity: _pickCity),
                  const SizedBox(height: 20),
                  ...entries.map((e) => Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: _PrayerCard(entry: e, isNext: e.name == nextPrayer),
                      )),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}

class _CityPickerSheet extends StatefulWidget {
  final List<IndonesianCity> cities;
  final String current;
  const _CityPickerSheet({required this.cities, required this.current});

  @override
  State<_CityPickerSheet> createState() => _CityPickerSheetState();
}

class _CityPickerSheetState extends State<_CityPickerSheet> {
  String _query = '';

  @override
  Widget build(BuildContext context) {
    final filtered = widget.cities
        .where((c) => c.name.toLowerCase().contains(_query.toLowerCase()) ||
            c.province.toLowerCase().contains(_query.toLowerCase()))
        .toList();

    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.7,
      child: Column(
        children: [
          const SizedBox(height: 12),
          Container(width: 40, height: 4, decoration: BoxDecoration(color: AppColors.divider, borderRadius: BorderRadius.circular(2))),
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              autofocus: false,
              decoration: InputDecoration(
                hintText: 'Cari kota atau provinsi',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: AppColors.sand,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
              ),
              onChanged: (v) => setState(() => _query = v),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filtered.length,
              itemBuilder: (context, i) {
                final city = filtered[i];
                final selected = city.name == widget.current;
                return ListTile(
                  title: Text(city.name, style: TextStyle(fontWeight: selected ? FontWeight.w700 : FontWeight.w400)),
                  subtitle: Text(city.province),
                  trailing: selected ? const Icon(Icons.check_circle, color: AppColors.amberDeep) : null,
                  onTap: () => Navigator.of(context).pop(city.name),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _DateHeaderCard extends StatelessWidget {
  final String? tanggal;
  final String city;
  final VoidCallback onTapCity;
  const _DateHeaderCard({required this.tanggal, required this.city, required this.onTapCity});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.indigoDeep, AppColors.indigo],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            const Positioned.fill(child: IslamicLatticeBackground(lineColor: Colors.white, opacity: 0.08)),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 22, 20, 18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(Icons.mosque, color: AppColors.amberLight, size: 30),
                  const SizedBox(height: 8),
                  Text('Jadwal Sholat', style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600, letterSpacing: 0.3)),
                  const SizedBox(height: 4),
                  Text(tanggal ?? '', style: const TextStyle(color: AppColors.amberLight, fontSize: 13)),
                  const SizedBox(height: 10),
                  InkWell(
                    onTap: onTapCity,
                    borderRadius: BorderRadius.circular(999),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.location_on, size: 14, color: AppColors.amberLight),
                          const SizedBox(width: 6),
                          Text(city, style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w600)),
                          const SizedBox(width: 4),
                          const Icon(Icons.keyboard_arrow_down, size: 16, color: Colors.white),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PrayerCard extends StatelessWidget {
  final _PrayerEntry entry;
  final bool isNext;
  const _PrayerCard({required this.entry, required this.isNext});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      decoration: BoxDecoration(
        color: isNext ? AppColors.indigo : AppColors.card,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: isNext ? AppColors.amber : AppColors.divider, width: isNext ? 1.4 : 1),
        boxShadow: [
          BoxShadow(
            color: (isNext ? AppColors.indigo : Colors.black).withValues(alpha: isNext ? 0.25 : 0.04),
            blurRadius: isNext ? 14 : 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(9),
            decoration: BoxDecoration(
              color: isNext ? Colors.white.withValues(alpha: 0.15) : AppColors.sand,
              shape: BoxShape.circle,
            ),
            child: Icon(entry.icon, size: 20, color: isNext ? AppColors.amberLight : AppColors.indigo),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(entry.name, style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: isNext ? Colors.white : AppColors.ink)),
                if (isNext) const Text('Selanjutnya', style: TextStyle(fontSize: 11.5, color: AppColors.amberLight)),
              ],
            ),
          ),
          Text(
            entry.time ?? '-',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: isNext ? AppColors.amberLight : AppColors.indigo,
              fontFeatures: const [FontFeature.tabularFigures()],
            ),
          ),
        ],
      ),
    );
  }
}

class _ErrorState extends StatelessWidget {
  final String message;
  final Future<void> Function() onRetry;
  const _ErrorState({required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.wifi_off_rounded, size: 40, color: AppColors.inkMuted),
            const SizedBox(height: 12),
            Text(message, textAlign: TextAlign.center, style: const TextStyle(color: AppColors.inkMuted)),
            const SizedBox(height: 16),
            ElevatedButton(onPressed: onRetry, child: const Text('Coba Lagi')),
          ],
        ),
      ),
    );
  }
}
