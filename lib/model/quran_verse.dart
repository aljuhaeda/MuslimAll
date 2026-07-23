/// Random-verse models — direct port of MusliMalang's
/// lib/model/suratacak.dart (equran.id integration, unchanged).
class AyatAcak {
  int? nomorAyat;
  String? teksArab;
  String? teksLatin;
  String? teksIndonesia;

  AyatAcak({this.nomorAyat, this.teksArab, this.teksLatin, this.teksIndonesia});

  factory AyatAcak.fromJson(Map<String, dynamic> json) {
    return AyatAcak(
      nomorAyat: json['nomorAyat'],
      teksArab: json['teksArab'],
      teksLatin: json['teksLatin'],
      teksIndonesia: json['teksIndonesia'],
    );
  }
}

class SuratAcak {
  int? nomor;
  String? namaArab;
  String? namaLatin;
  String? arti;
  int? jumlahAyat;
  AyatAcak? ayat;

  SuratAcak({this.nomor, this.namaArab, this.namaLatin, this.arti, this.jumlahAyat, this.ayat});

  // Parses one surah + one randomly-chosen ayat from equran.id's
  // https://equran.id/api/v2/surat/{nomor} response.
  factory SuratAcak.fromEquran(Map<String, dynamic> json, int ayatIndex) {
    final data = json['data'];
    final ayatList = data['ayat'] as List;
    final chosen = ayatList[ayatIndex] as Map<String, dynamic>;
    return SuratAcak(
      nomor: data['nomor'],
      namaArab: data['nama'],
      namaLatin: data['namaLatin'],
      arti: data['arti'],
      jumlahAyat: data['jumlahAyat'],
      ayat: AyatAcak.fromJson(chosen),
    );
  }
}

/// A single curated, bundled verse for the themed-reflection section — see
/// lib/data/quran_themes.dart.
class ThemedVerse {
  final String reference; // e.g. 'QS. Ibrahim 14:7'
  final String arabic;
  final String transliteration;
  final String translation;

  const ThemedVerse({
    required this.reference,
    required this.arabic,
    required this.transliteration,
    required this.translation,
  });
}

enum VerseTheme { gratitude, patience, hope, ease, forgiveness, guidance }

extension VerseThemeLabel on VerseTheme {
  String get label => switch (this) {
        VerseTheme.gratitude => 'Bersyukur',
        VerseTheme.patience => 'Melalui Kesulitan',
        VerseTheme.hope => 'Harapan & Rahmat',
        VerseTheme.ease => 'Ketenangan Hati',
        VerseTheme.forgiveness => 'Ampunan',
        VerseTheme.guidance => 'Petunjuk',
      };

  String get subtitle => switch (this) {
        VerseTheme.gratitude => 'Belajar bersyukur atas nikmat-Nya',
        VerseTheme.patience => 'Kekuatan menghadapi ujian',
        VerseTheme.hope => 'Jangan berputus asa dari rahmat Allah',
        VerseTheme.ease => 'Menenangkan hati yang gelisah',
        VerseTheme.forgiveness => 'Memohon dan memberi maaf',
        VerseTheme.guidance => 'Memohon jalan yang lurus',
      };
}
