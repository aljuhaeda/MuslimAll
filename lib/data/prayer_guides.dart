import '../model/prayer_guide.dart';
import 'guide_builder.dart';

const _niatSubuh = StepContent(
  arabic: 'اُصَلِّى فَرْضَ الصُّبْحِ رَكْعَتَيْنِ مُسْتَقْبِلَ الْقِبْلَةِ اَدَاءً لِلّٰهِ تَعَالَى',
  transliteration: "Ushalli fardhas subhi rak'ataini mustaqbilal qiblati adaa-an lillaahi ta'aala",
  translation: "I intend to pray the dawn prayer, two rak'ahs, facing the qiblah, for Allah.",
);

const _niatDzuhur = StepContent(
  arabic: 'اُصَلِّى فَرْضَ الظُّهْرِ أَرْبَعَ رَكَعَاتٍ مُسْتَقْبِلَ الْقِبْلَةِ أَدَاءً لِلّٰهِ تَعَالَى',
  transliteration: "Ushalli fardhaz zhuhri arba'a raka'aatin mustaqbilal qiblati adaa-an lillaahi ta'aala",
  translation: "I intend to pray the noon prayer, four rak'ahs, facing the qiblah, for Allah.",
);

const _niatAshar = StepContent(
  arabic: "اُصَلِّى فَرْضَ الْعَصْرِ أَرْبَعَ رَكَعَاتٍ مُسْتَقْبِلَ الْقِبْلَةِ أَدَاءً لِلّٰهِ تَعَالَى",
  transliteration: "Ushalli fardhal 'ashri arba'a raka'aatin mustaqbilal qiblati adaa-an lillaahi ta'aala",
  translation: "I intend to pray the afternoon prayer, four rak'ahs, facing the qiblah, for Allah.",
);

const _niatMaghrib = StepContent(
  arabic: 'اُصَلِّى فَرْضَ الْمَغْرِبِ ثَلاَثَ رَكَعَاتٍ مُسْتَقْبِلَ الْقِبْلَةِ أَدَاءً لِلّٰهِ تَعَالَى',
  transliteration: "Ushalli fardhal maghribi tsalaatsa raka'aatin mustaqbilal qiblati adaa-an lillaahi ta'aala",
  translation: "I intend to pray the sunset prayer, three rak'ahs, facing the qiblah, for Allah.",
);

const _niatIsya = StepContent(
  arabic: "اُصَلِّى فَرْضَ الْعِشَاءِ أَرْبَعَ رَكَعَاتٍ مُسْتَقْبِلَ الْقِبْلَةِ أَدَاءً لِلّٰهِ تَعَالَى",
  transliteration: "Ushalli fardhal 'isyaa'i arba'a raka'aatin mustaqbilal qiblati adaa-an lillaahi ta'aala",
  translation: "I intend to pray the night prayer, four rak'ahs, facing the qiblah, for Allah.",
);

/// Fatihah is recited aloud (jahar) in the first two rakaat of Subuh,
/// Maghrib, and Isya, and always silently (sirr) in Dzuhur and Ashar.
final PrayerGuide subuhGuide = buildGuide(
  id: 'subuh',
  label: 'Subuh',
  rakaat: 2,
  niat: _niatSubuh,
  jaharFatihahRakaat: const {1, 2},
  includeQunut: true,
);

final PrayerGuide dzuhurGuide = buildGuide(
  id: 'dzuhur',
  label: 'Dzuhur',
  rakaat: 4,
  niat: _niatDzuhur,
  jaharFatihahRakaat: const {},
);

final PrayerGuide asharGuide = buildGuide(
  id: 'ashar',
  label: 'Ashar',
  rakaat: 4,
  niat: _niatAshar,
  jaharFatihahRakaat: const {},
);

final PrayerGuide maghribGuide = buildGuide(
  id: 'maghrib',
  label: 'Maghrib',
  rakaat: 3,
  niat: _niatMaghrib,
  jaharFatihahRakaat: const {1, 2},
);

final PrayerGuide isyaGuide = buildGuide(
  id: 'isya',
  label: 'Isya',
  rakaat: 4,
  niat: _niatIsya,
  jaharFatihahRakaat: const {1, 2},
);

final List<PrayerGuide> allPrayerGuides = [
  subuhGuide,
  dzuhurGuide,
  asharGuide,
  maghribGuide,
  isyaGuide,
];
