import 'package:flutter_test/flutter_test.dart';
import 'package:muslimall_app/model/jadwal_shalat.dart';
import 'package:muslimall_app/model/quran_verse.dart';

void main() {
  test('JadwalShalat.fromAladhan parses the Aladhan timingsByCity response shape', () {
    final json = {
      'data': {
        'date': {
          'readable': '21 Jul 2026',
        },
        'timings': {
          'Imsak': '04:20',
          'Fajr': '04:30',
          'Sunrise': '05:45',
          'Dhuhr': '11:50',
          'Asr': '15:10',
          'Maghrib': '17:55',
          'Isha': '19:05',
        },
      },
    };

    final jadwal = JadwalShalat.fromAladhan(json);

    expect(jadwal.tanggal, '21 Jul 2026');
    expect(jadwal.subuh, '04:30');
    expect(jadwal.dzuhur, '11:50');
    expect(jadwal.ashar, '15:10');
    expect(jadwal.maghrib, '17:55');
    expect(jadwal.isya, '19:05');
  });

  test('SuratAcak.fromEquran parses one chosen ayat out of the surah response shape', () {
    final json = {
      'data': {
        'nomor': 1,
        'nama': 'الفاتحة',
        'namaLatin': 'Al-Fatihah',
        'arti': 'Pembukaan',
        'jumlahAyat': 2,
        'ayat': [
          {'nomorAyat': 1, 'teksArab': 'بسم الله', 'teksLatin': 'Bismillah', 'teksIndonesia': 'Dengan nama Allah'},
          {'nomorAyat': 2, 'teksArab': 'الحمد لله', 'teksLatin': 'Alhamdulillah', 'teksIndonesia': 'Segala puji bagi Allah'},
        ],
      },
    };

    final surat = SuratAcak.fromEquran(json, 1);

    expect(surat.namaLatin, 'Al-Fatihah');
    expect(surat.jumlahAyat, 2);
    expect(surat.ayat?.nomorAyat, 2);
    expect(surat.ayat?.teksIndonesia, 'Segala puji bagi Allah');
  });
}
