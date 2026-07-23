/// Shared recitations used across all five daily prayers — the wording is
/// identical prayer-to-prayer (takbir, iftitah, ruku', i'tidal, sujud, the
/// sitting-between-prostrations dua, tahiyat, and salam are not
/// prayer-specific). Only niat (intention) and the Fatihah reading-mode
/// pattern differ per prayer, plus rakaat count and the Qunut gate (Subuh
/// only, per the `general`/`nu` tags already modeled in the source data).
///
/// FLAG FOR REVIEW: this content is a best-effort compilation of standard,
/// widely-agreed-upon prayer texts. Denominational variation beyond the
/// `general` tag (nu/muhammadiyah/salafi) has only been carried over where
/// it already existed for Subuh (iftitah, qunut) — it has not been
/// independently re-verified per-organization for the other four prayers.
/// Please review before treating this as authoritative; this is content
/// people will actually pray from.
///
/// FLAG FOR REVIEW (audio): only Al-Fatihah has a recitation audio URL,
/// sourced from the Islamic Network CDN (the same free/open
/// infrastructure that backs the alquran.cloud API — verified live,
/// widely used by other open-source Quran apps). The other nine shared
/// recitations (takbir, iftitah, ruku', i'tidal, sujud, the
/// sitting-between-prostrations dua, qunut, tahiyat, salam) are NOT
/// Quranic verses, so that CDN doesn't cover them, and no comparably
/// verified free/licensed source was found for them — audioUrl is left
/// null rather than guessed at. See MuslimAll's PROGRESS.md.
library;

import '../model/prayer_guide.dart';

const _takbir = StepContent(
  arabic: 'اللهُ أَكْبَرُ',
  transliteration: 'Allahu Akbar',
  translation: 'Allah is the Greatest',
);
const _takbirMeta = StepMeta(sourceDalil: 'HR. Bukhari', readingMode: ReadingMode.jahar);

const _iftitahKabira = StepContent(
  arabic: 'اللهُ أَكْبَرُ كَبِيرًا وَالْحَمْدُ لِلَّهِ كَثِيرًا وَسُبْحَانَ اللَّهِ بُكْرَةً وَأَصِيلاً',
  transliteration: 'Allahu akbar kabira wal-hamdu lillahi kathira wa subhanallahi bukratan wa asila',
  translation:
      'Allah is the Greatest, and praise be to Allah distinctly, and glory be to Allah morning and afternoon.',
);
const _iftitahKabiraMeta = StepMeta(sourceDalil: 'HR. Muslim', readingMode: ReadingMode.sirr);

const _iftitahAllahumma = StepContent(
  arabic:
      'اللَّهُمَّ بَاعِدْ بَيْنِي وَبَيْنَ خَطَايَايَ كَمَا بَاعَدْتَ بَيْنَ الْمَشْرِقِ وَالْمَغْرِبِ، اللَّهُمَّ نَقِّنِي مِنْ خَطَايَايَ كَمَا يُنَقَّى الثَّوْبُ الْأَبْيَضُ مِنَ الدَّنَسِ، اللَّهُمَّ اغْسِلْنِي مِنْ خَطَايَايَ بِالثَّلْجِ وَالْمَاءِ وَالْبَرَدِ',
  transliteration:
      'Allahumma baid baini wa baina khatayaya kama baadta bainal mashriqi wal maghrib. Allahumma naqqini min khatayaya kama yunaqqats tsaubul abyadhu minad danas. Allahummaghsilni min khatayaya bits tsalji wal mai wal barad.',
  translation:
      'O Allah, distance me from my sins as You have distanced the East from the West. O Allah, cleanse me from my sins as a white garment is cleansed from dirt. O Allah, wash me from my sins with snow, water, and hail.',
);
const _iftitahAllahummaMeta = StepMeta(sourceDalil: 'HR. Bukhari 744', readingMode: ReadingMode.sirr);

const _fatihah = StepContent(
  arabic:
      'بِسْمِ اللَّهِ الرَّحْمَٰنِ الرَّحِيمِ\nالْحَمْدُ لِلَّهِ رَبِّ الْعَالَمِينَ\nالرَّحْمَٰنِ الرَّحِيمِ\nمَالِكِ يَوْمِ الدِّينِ\nإِيَّاكَ نَعْبُدُ وَإِيَّاكَ نَسْتَعِينُ\nاهْدِنَا الصِّرَاطَ الْمُسْتَقِيمَ\nصِرَاطَ الَّذِينَ أَنْعَمْتَ عَلَيْهِمْ غَيْرِ الْمَغْضُوبِ عَلَيْهِمْ وَلَا الضَّالِّينَ',
  transliteration:
      'Bismillahir rahmanir rahim. Alhamdulillahi rabbil alamin. Arrahmanirrahim. Maliki yaumiddin. Iyyaka nabudu wa iyyaka nastain. Ihdinas shiratal mustaqim. Siratal ladzina an amta alaihim ghairil maghdubi alaihim waladhallin.',
  translation:
      'In the name of Allah... All praise is due to Allah... The Entirely Merciful... [Full Surah Al-Fatihah]',
  // Islamic Network CDN — Mishary Alafasy recitation, full surah, free/open.
  audioUrl: 'https://cdn.islamic.network/quran/audio-surah/128/ar.alafasy/1.mp3',
);
const _fatihahDalil = 'Al-Quran 1:1-7';

const _ruku = StepContent(
  arabic: 'سُبْحَانَ رَبِّيَ الْعَظِيمِ',
  transliteration: 'Subhana Rabbiyal Adzim (3x)',
  translation: 'Glory be to my Lord the Almighty',
);
const _rukuMeta = StepMeta(sourceDalil: 'HR. Muslim', readingMode: ReadingMode.sirr);

const _iktidal = StepContent(
  arabic: 'سَمِعَ اللَّهُ لِمَنْ حَمِدَهُ\nرَبَّنَا وَلَكَ الْحَمْدُ، حَمْدًا كَثِيرًا طَيِّبًا مُبَارَكًا فِيهِ',
  transliteration:
      "Sami allahu liman hamidah... Rabbana wa lakal hamd, hamdan katsiran tayyiban mubarakan fih",
  translation:
      'Allah listens to those who praise Him... Our Lord, and to You belongs the praise, abundant, good and blessed praise.',
);
const _iktidalMeta = StepMeta(sourceDalil: 'HR. Bukhari', readingMode: ReadingMode.jahar);

const _sujud = StepContent(
  arabic: 'سُبْحَانَ رَبِّيَ الْأَعْلَى',
  transliteration: "Subhana Rabbiyal A'la (3x)",
  translation: 'Glory be to my Lord the Most High',
);
const _sujudMeta = StepMeta(sourceDalil: 'HR. Muslim', readingMode: ReadingMode.sirr);

const _dudukAntaraSujud = StepContent(
  arabic: 'رَبِّ اغْفِرْ لِي وَارْحَمْنِي وَاجْبُرْنِي وَارْفَعْنِي وَارْزُقْنِي وَاهْدِنِي وَعَافِنِي وَاعْفُ عَنِّي',
  transliteration: "Rabbighfirli warhamni wajburni warfa'ni warzuqni wahdini wa'afini wa'fu 'anni",
  translation:
      'My Lord, forgive me, have mercy on me, make up for my shortcoming, raise my status, provide for me, guide me, grant me well-being, and pardon me.',
);
const _dudukAntaraSujudMeta = StepMeta(sourceDalil: 'HR. Abu Dawud, Ibn Majah', readingMode: ReadingMode.sirr);

const _qunut = StepContent(
  arabic:
      'اللَّهُمَّ اهْدِنِي فِيمَنْ هَدَيْتَ، وَعَافِنِي فِيمَنْ عَافَيْتَ، وَتَوَلَّنِي فِيمَنْ تَوَلَّيْتَ، وَبَارِكْ لِي فِيمَا أَعْطَيْتَ، وَقِنِي شَرَّ مَا قَضَيْتَ، فَإِنَّكَ تَقْضِي وَلَا يُقْضَى عَلَيْكَ',
  transliteration:
      "Allahummah dinii fiiman hadait, wa aafinii fiiman aafait, wa tawallanii fiiman tawallait...",
  translation:
      'O Allah, guide me among those You have guided, grant me health among those You have granted health...',
);
const _qunutMeta = StepMeta(sourceDalil: 'HR. Abu Dawud', readingMode: ReadingMode.jahar);

const _tahiyat = StepContent(
  arabic:
      'التَّحِيَّاتُ الْمُبَارَكَاتُ الصَّلَوَاتُ الطَّيِّبَاتُ لِلَّهِ، السَّلَامُ عَلَيْكَ أَيُّهَا النَّبِيُّ وَرَحْمَةُ اللَّهِ وَبَرَكَاتُهُ، السَّلَامُ عَلَيْنَا وَعَلَى عِبَادِ اللَّهِ الصَّالِحِينَ. أَشْهَدُ أَنْ لَا إِلَهَ إِلَّا اللَّهُ وَأَشْهَدُ أَنَّ مُحَمَّدًا رَسُولُ اللَّهِ',
  transliteration:
      "At-tahiyyatul mubarakatus salawatus tayyibatu lillah. Assalamu alaika ayyuhan nabiyyu wa rahmatullahi wa barakatuh...",
  translation:
      'Blessed salutations, prayers, good things are for Allah. Peace be upon you, O Prophet, and the mercy of Allah...',
);
const _tahiyatMeta = StepMeta(sourceDalil: 'HR. Muslim', readingMode: ReadingMode.sirr);

const _salam = StepContent(
  arabic: 'السَّلَامُ عَلَيْكُمْ وَرَحْمَةُ اللَّهِ',
  transliteration: 'Assalamu alaikum wa rahmatullah',
  translation: 'Peace be upon you and the mercy of Allah',
);
const _salamMeta = StepMeta(sourceDalil: 'HR. Muslim', readingMode: ReadingMode.jahar);

/// Builds a complete, structurally-correct PrayerGuide for any of the five
/// daily prayers: niat -> takbir -> iftitah (rakaat 1 only) -> per-rakaat
/// [fatihah -> ruku' -> i'tidal -> (qunut, Subuh r2 only) -> sujud ->
/// duduk-antara-sujud -> sujud] -> tahiyat awal (after rakaat 2, if
/// rakaat > 2) -> ... -> tahiyat akhir -> salam.
PrayerGuide buildGuide({
  required String id,
  required String label,
  required int rakaat,
  required StepContent niat,
  required Set<int> jaharFatihahRakaat,
  bool includeQunut = false,
}) {
  final steps = <PrayerStep>[];
  final variations = <ContentVariation>[];
  var order = 1;

  void addStep(String stepId, {bool isConditional = false, String? conditionalType}) {
    steps.add(PrayerStep(
      stepId: stepId,
      stepOrder: order++,
      isConditional: isConditional,
      conditionalType: conditionalType,
    ));
  }

  void addVariation(String id, String stepIdRef, List<OrganizationTag> tags, StepContent content, StepMeta meta) {
    variations.add(ContentVariation(id: id, stepIdRef: stepIdRef, orgTags: tags, content: content, meta: meta));
  }

  // Niat
  addStep('${id}_s_niat');
  addVariation('${id}_niat', '${id}_s_niat', const [OrganizationTag.general], niat,
      const StepMeta(sourceDalil: 'Ijma Ulama', readingMode: ReadingMode.sirr));

  // Takbiratul ihram
  addStep('${id}_s_takbir');
  addVariation('${id}_takbir', '${id}_s_takbir', const [OrganizationTag.general], _takbir, _takbirMeta);

  // Iftitah (rakaat 1 only)
  addStep('${id}_s_iftitah');
  addVariation('${id}_iftitah_kabira', '${id}_s_iftitah', const [OrganizationTag.nu, OrganizationTag.general],
      _iftitahKabira, _iftitahKabiraMeta);
  addVariation('${id}_iftitah_allahumma', '${id}_s_iftitah',
      const [OrganizationTag.muhammadiyah, OrganizationTag.salafi], _iftitahAllahumma, _iftitahAllahummaMeta);

  for (var r = 1; r <= rakaat; r++) {
    final fatihahMeta =
        StepMeta(sourceDalil: _fatihahDalil, readingMode: jaharFatihahRakaat.contains(r) ? ReadingMode.jahar : ReadingMode.sirr);
    addStep('${id}_s_fatihah_r$r');
    addVariation('${id}_fatihah_r$r', '${id}_s_fatihah_r$r', const [OrganizationTag.general], _fatihah, fatihahMeta);

    addStep('${id}_s_ruku_r$r');
    addVariation('${id}_ruku_r$r', '${id}_s_ruku_r$r', const [OrganizationTag.general], _ruku, _rukuMeta);

    addStep('${id}_s_iktidal_r$r');
    addVariation('${id}_iktidal_r$r', '${id}_s_iktidal_r$r', const [OrganizationTag.general], _iktidal, _iktidalMeta);

    if (includeQunut && r == rakaat) {
      addStep('${id}_s_qunut', isConditional: true, conditionalType: 'qunut');
      addVariation('${id}_qunut', '${id}_s_qunut', const [OrganizationTag.nu, OrganizationTag.general], _qunut, _qunutMeta);
    }

    addStep('${id}_s_sujud1_r$r');
    addVariation('${id}_sujud1_r$r', '${id}_s_sujud1_r$r', const [OrganizationTag.general], _sujud, _sujudMeta);

    addStep('${id}_s_duduk_sujud_r$r');
    addVariation('${id}_duduk_sujud_r$r', '${id}_s_duduk_sujud_r$r', const [OrganizationTag.general], _dudukAntaraSujud,
        _dudukAntaraSujudMeta);

    addStep('${id}_s_sujud2_r$r');
    addVariation('${id}_sujud2_r$r', '${id}_s_sujud2_r$r', const [OrganizationTag.general], _sujud, _sujudMeta);

    if (r == 2 && rakaat > 2) {
      addStep('${id}_s_tahiyat_awal');
      addVariation('${id}_tahiyat_awal', '${id}_s_tahiyat_awal', const [OrganizationTag.general], _tahiyat, _tahiyatMeta);
    }
  }

  addStep('${id}_s_tahiyat_akhir');
  addVariation('${id}_tahiyat_akhir', '${id}_s_tahiyat_akhir', const [OrganizationTag.general], _tahiyat, _tahiyatMeta);

  addStep('${id}_s_salam');
  addVariation('${id}_salam', '${id}_s_salam', const [OrganizationTag.general], _salam, _salamMeta);

  return PrayerGuide(id: id, label: label, rakaat: rakaat, steps: steps, variations: variations);
}
