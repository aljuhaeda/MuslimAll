import 'dart:math';

import 'package:dio/dio.dart';
import 'package:get/get.dart';

import '../data/quran_themes.dart';
import '../model/quran_verse.dart';

class QuranController extends GetxController {
  var isFetchingRandom = false.obs;
  var errorMessage = ''.obs;
  SuratAcak? suratAcak;

  final themeIndex = <VerseTheme, int>{}.obs;

  // ===== Random verse (ported as-is from MusliMalang's services.dart) =====
  Future<void> fetchRandom() async {
    isFetchingRandom.value = true;
    errorMessage.value = '';
    try {
      suratAcak = await _getSuratAcak();
    } catch (e) {
      errorMessage.value = 'Gagal memuat data. Periksa koneksi internet Anda.';
    } finally {
      isFetchingRandom.value = false;
    }
  }

  Future<SuratAcak> _getSuratAcak() async {
    final random = Random();
    final nomorSurat = random.nextInt(114) + 1;
    final dio = Dio();
    final res = await dio.get('https://equran.id/api/v2/surat/$nomorSurat');
    final int jumlahAyat = res.data['data']['jumlahAyat'];
    final ayatIndex = random.nextInt(jumlahAyat);
    return SuratAcak.fromEquran(res.data, ayatIndex);
  }

  // ===== Themed verses (curated, bundled — see data/quran_themes.dart) =====
  ThemedVerse currentThemedVerse(VerseTheme theme) {
    final verses = quranThemes[theme]!;
    final index = themeIndex[theme] ?? 0;
    return verses[index % verses.length];
  }

  void nextThemedVerse(VerseTheme theme) {
    final verses = quranThemes[theme]!;
    final current = themeIndex[theme] ?? 0;
    themeIndex[theme] = (current + 1) % verses.length;
  }
}
