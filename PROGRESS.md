# MuslimAll — Progress

## Status
**Public**: https://github.com/aljuhaeda/MuslimAll — content reviewed,
code/security reviewed, build verified. MusliMalang and salatwebapp are
archived in its favor; the portfolio site's project entry points here.
Audio plumbing is now real (not a stub) for one recitation; a full
visual redesign is in scoping (see Next up).

## Done
- Merges MusliMalang (prayer times) and salatwebapp (prayer guide) into
  one app: Indonesia-wide prayer times, full 5-prayer step-by-step guide,
  themed + random Quran verses.
- Actually verified by reading the code (not just the README): all 5
  prayers (Subuh, Dzuhur, Ashar, Maghrib, Isya) have real, structurally
  correct guide content generated via a shared `buildGuide()` in
  `lib/data/guide_builder.dart` — correct rakaat counts, correct
  jahar/sirr Fatihah rules per prayer, Qunut correctly gated to Subuh
  only. This is content-complete, further along than salatwebapp
  (Subuh-only).
- New "lantern at night" design identity, distinct from MusliMalang's.
- Own test suite exists (`test/logic`, `test/model`, widget smoke test)
  — 189 lines across 3 files.
- Initialized git and pushed to a private GitHub repo (2026-07-23) —
  work is now backed up, no longer local-machine-only.
- Full pre-public code review (code-reviewer skill + manual security scan):
  no hardcoded secrets, no leaked files, no plain-HTTP calls, `dio`/`get`
  both on versions past the CVEs MusliMalang had to fix. One real minor
  issue found and fixed: neither `Dio()` client had a request timeout,
  so a hung connection would leave the loading spinner running forever
  instead of surfacing the existing error message. Fixed in both
  `TimesController` and `QuranController`; re-verified analyze/test
  clean afterward.
- **Religious content reviewed by the project owner** (2026-07-23),
  using the generated review page covering all 10 shared recitations
  and all 5 prayers' niat/rakaat/jahar-sirr/qunut configuration.
- **Flipped from private to public** (2026-07-23) —
  `gh repo edit aljuhaeda/MuslimAll --visibility public`, confirmed via
  `gh repo view` (`"visibility":"PUBLIC"`).
- **MusliMalang and salatwebapp archived** (2026-07-23) — `gh repo
  archive`, confirmed via `gh repo view` (`"isArchived":true` for both).
  Both repos' own `PROGRESS.md` updated and pushed before archiving so
  the record survives read-only status.
- **Portfolio site case study updated** (2026-07-23) — replaced both the
  MusliMalang and salatwebapp write-ups with one for MuslimAll, verified
  live.
- **Real audio playback added** (2026-07-23) — `audioplayers` wired to
  the guide controller (play/stop per step, auto-stop on step/prayer
  change). Al-Fatihah's recitation streams from the Islamic Network CDN
  (free/open, verified live — the same infrastructure behind the
  alquran.cloud API). The other 9 shared recitations aren't Quranic
  verses, so that CDN doesn't cover them, and no comparably verified
  free/licensed source was found — `audioUrl` stays `null` for those
  rather than guessing at a source. Button disables itself when no
  audio exists for the current step instead of pretending it works.
- **Fixed a real UX bug**: Panduan Sholat had no visible control to
  advance between steps — swipe was the only way to move, with no
  affordance signaling that. Added persistent Previous/Next buttons.

## In progress
- Full visual redesign — direction being scoped with the project owner
  before implementation (centered/minimalist/professional target
  aesthetic; specifics pending).

## Known issues / honest limitations
- **Audio coverage is 1 of 10 shared recitations** (Al-Fatihah only).
  The other 9 (takbir, iftitah, ruku', i'tidal, sujud, the
  sitting-between-prostrations dua, qunut, tahiyat, salam) have no
  verified free/licensed audio source yet — would need either a
  properly licensed source or real recordings.
- The live portfolio site's project entry now correctly points to
  MuslimAll (see portfolio-website's own PROGRESS.md).

## Verification log
- 2026-07-23: discovered while working through tracked projects in
  order (was not part of the original 12-repo audit). Not a git repo at
  discovery time, so `/security-review` didn't apply.
- 2026-07-23: read `guide_builder.dart` and `prayer_guides.dart`
  directly to confirm content completeness (see Done above) rather than
  trusting the README's claims.
- 2026-07-23: `git init`, committed, pushed to a new private GitHub repo.
- 2026-07-23: found the Flutter SDK was actually installed locally at
  `C:\Users\aljuh\flutter_sdk` (just not on PATH) and fully re-verified:
  `flutter analyze` — no issues. `flutter test` — all 14 tests pass,
  including structural-correctness tests for every prayer's rakaat count
  and step sequence. `flutter build web` — builds clean. Served the
  build locally and confirmed the Flutter engine actually mounts in a
  real browser (`flt-glass-pane` present, all assets 200, zero console
  errors) — not just that the build command exited 0.

## Next up
1. Full visual redesign — gathering direction from the project owner
   (color, type, layout density, tone) before touching any UI code.
2. Extend audio coverage beyond Al-Fatihah, once a real source (licensed
   or recorded) exists for the other 9 shared recitations.
3. Add a real screenshot to the portfolio case study (`images: []`
   currently — none was capturable in the working environment).
