import '../model/quran_verse.dart';

/// Curated, bundled verses per reflection theme — hand-picked well-known
/// ayat rather than fetched from an API, for reliability and so the
/// selection actually fits each theme.
///
/// FLAG FOR REVIEW: this is my best-effort selection of widely-cited verses
/// per theme, not a scholarly curation — worth a pass from you before
/// treating it as authoritative, same caveat as the prayer-guide content.
const Map<VerseTheme, List<ThemedVerse>> quranThemes = {
  VerseTheme.gratitude: [
    ThemedVerse(
      reference: 'QS. Ibrahim 14:7',
      arabic: 'لَئِن شَكَرْتُمْ لَأَزِيدَنَّكُمْ',
      transliteration: "La'in syakartum la-azidannakum",
      translation: 'If you are grateful, I will surely increase you [in favor].',
    ),
    ThemedVerse(
      reference: 'QS. An-Naml 27:19',
      arabic: 'رَبِّ أَوْزِعْنِي أَنْ أَشْكُرَ نِعْمَتَكَ الَّتِي أَنْعَمْتَ عَلَيَّ',
      transliteration: "Rabbi awzi'ni an ashkura ni'matakal-lati an'amta 'alayya",
      translation: 'My Lord, enable me to be grateful for Your favor which You have bestowed upon me.',
    ),
    ThemedVerse(
      reference: 'QS. Ad-Duha 93:11',
      arabic: 'وَأَمَّا بِنِعْمَةِ رَبِّكَ فَحَدِّثْ',
      transliteration: 'Wa amma bini\'mati rabbika fahaddits',
      translation: 'And as for the favor of your Lord, report it.',
    ),
  ],
  VerseTheme.patience: [
    ThemedVerse(
      reference: 'QS. Al-Baqarah 2:153',
      arabic: 'إِنَّ اللَّهَ مَعَ الصَّابِرِينَ',
      transliteration: 'Innallaha ma\'as-sabirin',
      translation: 'Indeed, Allah is with the patient.',
    ),
    ThemedVerse(
      reference: 'QS. Al-Baqarah 2:286',
      arabic: 'لَا يُكَلِّفُ اللَّهُ نَفْسًا إِلَّا وُسْعَهَا',
      transliteration: "La yukallifullahu nafsan illa wus'aha",
      translation: 'Allah does not burden a soul beyond that it can bear.',
    ),
    ThemedVerse(
      reference: 'QS. Ash-Sharh 94:5-6',
      arabic: 'فَإِنَّ مَعَ الْعُسْرِ يُسْرًا . إِنَّ مَعَ الْعُسْرِ يُسْرًا',
      transliteration: "Fa inna ma'al 'usri yusra, inna ma'al 'usri yusra",
      translation: 'For indeed, with hardship [will be] ease. Indeed, with hardship [will be] ease.',
    ),
  ],
  VerseTheme.hope: [
    ThemedVerse(
      reference: 'QS. Az-Zumar 39:53',
      arabic: 'لَا تَقْنَطُوا مِن رَّحْمَةِ اللَّهِ إِنَّ اللَّهَ يَغْفِرُ الذُّنُوبَ جَمِيعًا',
      transliteration: 'La taqnatu mir rahmatillah, innallaha yaghfirudz dzunuba jami\'a',
      translation: 'Do not despair of the mercy of Allah. Indeed, Allah forgives all sins.',
    ),
    ThemedVerse(
      reference: 'QS. Al-Baqarah 2:186',
      arabic: 'وَإِذَا سَأَلَكَ عِبَادِي عَنِّي فَإِنِّي قَرِيبٌ',
      transliteration: "Wa idza sa'alaka 'ibadi 'anni fa inni qarib",
      translation: 'And when My servants ask you concerning Me, indeed I am near.',
    ),
    ThemedVerse(
      reference: 'QS. Ghafir 40:60',
      arabic: 'ادْعُونِي أَسْتَجِبْ لَكُمْ',
      transliteration: "Ud'uni astajib lakum",
      translation: 'Call upon Me; I will respond to you.',
    ),
  ],
  VerseTheme.ease: [
    ThemedVerse(
      reference: "QS. Ar-Ra'd 13:28",
      arabic: 'أَلَا بِذِكْرِ اللَّهِ تَطْمَئِنُّ الْقُلُوبُ',
      transliteration: "Ala bidzikrillahi tathma'innul qulub",
      translation: 'Verily, in the remembrance of Allah do hearts find rest.',
    ),
    ThemedVerse(
      reference: 'QS. At-Talaq 65:2-3',
      arabic: 'وَمَن يَتَّقِ اللَّهَ يَجْعَل لَّهُ مَخْرَجًا',
      transliteration: 'Wa may yattaqillaha yaj\'al lahu makhraja',
      translation: 'And whoever fears Allah, He will make for him a way out.',
    ),
    ThemedVerse(
      reference: 'QS. At-Taubah 9:40',
      arabic: 'لَا تَحْزَنْ إِنَّ اللَّهَ مَعَنَا',
      transliteration: "La tahzan innallaha ma'ana",
      translation: 'Do not grieve; indeed Allah is with us.',
    ),
  ],
  VerseTheme.forgiveness: [
    ThemedVerse(
      reference: "QS. Ali 'Imran 3:135",
      arabic: 'وَالَّذِينَ إِذَا فَعَلُوا فَاحِشَةً ... اسْتَغْفَرُوا لِذُنُوبِهِمْ',
      transliteration: "Walladzina idza fa'alu fahisyatan ... istaghfaru lidzunubihim",
      translation: 'And those who, when they commit an immorality ... seek forgiveness for their sins.',
    ),
    ThemedVerse(
      reference: 'QS. An-Nisa 4:110',
      arabic: 'وَمَن يَعْمَلْ سُوءًا أَوْ يَظْلِمْ نَفْسَهُ ثُمَّ يَسْتَغْفِرِ اللَّهَ يَجِدِ اللَّهَ غَفُورًا رَّحِيمًا',
      transliteration:
          'Wa may ya\'mal su\'an aw yazhlim nafsahu tsumma yastaghfirillaha yajidillaha ghafurar rahima',
      translation:
          'And whoever does a wrong or wrongs himself but then seeks forgiveness of Allah will find Allah Forgiving and Merciful.',
    ),
    ThemedVerse(
      reference: 'QS. Al-Baqarah 2:222',
      arabic: 'إِنَّ اللَّهَ يُحِبُّ التَّوَّابِينَ',
      transliteration: 'Innallaha yuhibbut tawwabin',
      translation: 'Indeed, Allah loves those who repent.',
    ),
  ],
  VerseTheme.guidance: [
    ThemedVerse(
      reference: 'QS. Al-Fatihah 1:6',
      arabic: 'اهْدِنَا الصِّرَاطَ الْمُسْتَقِيمَ',
      transliteration: 'Ihdinash shiratal mustaqim',
      translation: 'Guide us to the straight path.',
    ),
    ThemedVerse(
      reference: 'QS. Al-Baqarah 2:2',
      arabic: 'ذَٰلِكَ الْكِتَابُ لَا رَيْبَ ۛ فِيهِ ۛ هُدًى لِّلْمُتَّقِينَ',
      transliteration: 'Dzalikal kitabu la rayba fih, hudal lil muttaqin',
      translation: 'This is the Book about which there is no doubt, a guidance for those conscious of Allah.',
    ),
    ThemedVerse(
      reference: 'QS. Yunus 10:57',
      arabic: 'قَدْ جَاءَتْكُم مَّوْعِظَةٌ مِّن رَّبِّكُمْ وَشِفَاءٌ ... وَهُدًى وَرَحْمَةٌ لِّلْمُؤْمِنِينَ',
      transliteration:
          "Qad ja'atkum mau'izhatum mir rabbikum wa syifa'... wa hudaw wa rahmatul lil mu'minin",
      translation:
          'There has come to you instruction from your Lord and healing ... and guidance and mercy for the believers.',
    ),
  ],
};
