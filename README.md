# MuslimAll

A Flutter app merging two earlier prototypes — [MusliMalang](https://github.com/aljuhaeda/MusliMalang) (prayer times) and [salatwebapp](https://github.com/aljuhaeda/salatwebapp) (a step-by-step prayer guide) — into one: prayer times for all of Indonesia, a complete 5-prayer step-by-step guide, and curated/random Quran verses. Cross-platform: Android, iOS, Web, Windows, macOS, Linux.

![Flutter](https://img.shields.io/badge/Flutter-02569B?logo=flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-0175C2?logo=dart&logoColor=white)

## Features

- **Jadwal Sholat** — prayer times for any major Indonesian city/regency (Aladhan API, Kemenag RI method), with the current/upcoming prayer highlighted. Not limited to one region like MusliMalang was.
- **Panduan Sholat** — a step-by-step guide through all 5 daily prayers (Subuh, Dzuhur, Ashar, Maghrib, Isya): Arabic text, transliteration, translation, and a "Dalil" (evidence) reference per step, with an illustrated posture figure for each position. Denomination-aware content model (`general`/`nu`/`muhammadiyah`/`salafi` tags), a direct evolution of salatwebapp's engine — which only had Subuh built out.
- **Al-Qur'an** — themed verse reflections (Gratitude, Patience, Hope & Mercy, Ease, Forgiveness, Guidance) plus a random-verse draw (equran.id API), evolved from MusliMalang's single random-verse feature.

## Design

A "lantern at night" palette — deep indigo night sky with warm amber lantern-light accents on a warm sand ground — with hand-drawn geometric motifs (an interlocking rhombus/girih lattice, a crescent-and-arc signature mark) via `CustomPainter`, no image assets. A fresh identity distinct from MusliMalang's daytime emerald/gold theme, built for a bigger, merged app.

## Tech Stack

- **Flutter** / **Dart**
- **GetX** — state management and dependency injection
- **Dio** — HTTP client
- **shared_preferences** — local persistence (selected city, prayer-guide user config) — no on-device database needed, since guide content is static bundled reference data rather than user-editable
- **[Aladhan API](https://aladhan.com/prayer-times-api)** — prayer times
- **[equran.id API](https://equran.id/apidev)** — Quran text and translation

## Project Structure

```
MuslimAll/
├── lib/
│   ├── main.dart
│   ├── controller/            # GetX controllers (times, guide, quran)
│   ├── model/                 # Data models (times, guide, verses)
│   ├── logic/                 # StepManager, VariationSelector
│   ├── data/                  # Bundled content: indonesia_cities, prayer_guides
│   │                             (guide_builder generates all 5 prayers from
│   │                             shared recitations), quran_themes
│   ├── theme/                 # Design tokens
│   ├── widgets/                # Islamic pattern painters, posture illustrations
│   └── view/                   # Home hub + the 3 section screens
├── test/
│   ├── logic/                  # StepManager / VariationSelector / guide-structure tests
│   ├── model/                  # API response parsing tests
│   └── widget_test.dart        # Home hub smoke test
└── pubspec.yaml
```

## Getting Started

```bash
flutter pub get
flutter run             # auto-selects a connected device
flutter run -d chrome   # or target a platform directly
```

```bash
flutter analyze
flutter test
```

## Content accuracy — please review

This app's religious content (the prayer-guide recitations for Dzuhur/Ashar/Maghrib/Isya in `lib/data/guide_builder.dart`, and the theme-to-verse mapping in `lib/data/quran_themes.dart`) is a best-effort compilation of standard, widely-agreed-upon texts, not a scholarly review. Subuh's content was carried over from salatwebapp's original prototype; the other four prayers and the themed verses are new. Denominational variation beyond the `general` tag has only been modeled where it already existed for Subuh (iftitah, qunut). Please review before treating this as authoritative — this is content people will actually pray from.

## Superseded projects

MuslimAll replaces [MusliMalang](https://github.com/aljuhaeda/MusliMalang) and [salatwebapp](https://github.com/aljuhaeda/salatwebapp), both archived once this app was verified working.

## License

MIT.

## Author

**Zul Iflah Al Juhaeda** — [LinkedIn](https://linkedin.com/in/aljuhaeda) · [GitHub](https://github.com/aljuhaeda)
