# MuslimAll — Progress

## Status
Pushed to GitHub (private): https://github.com/aljuhaeda/MuslimAll —
backed up, but **not yet verified or reviewed**. Do not archive
MusliMalang or salatwebapp until the "Next up" items below are done.

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

## In progress
- Content review and build verification (see Next up).

## Known issues / honest limitations
- **One explicitly unfinished feature**: an audio button tooltipped
  `"Audio (coming soon)"` in `lib/view/prayer_guide_screen.dart:200`.
- **Religious content has not had a scholarly review.** The code itself
  carries a `FLAG FOR REVIEW` doc comment in `guide_builder.dart`:
  denominational variation (nu/muhammadiyah/salafi) was only carried
  over where it already existed for Subuh (iftitah, qunut) — not
  independently re-verified per-organization for the other four prayers.
  This is content people would actually pray from.
- **Build/test status unconfirmed.** No Flutter SDK available in this
  environment to run `flutter analyze`/`flutter test` — tests exist but
  have not been executed against this code.
- **Repo is private** — intentional, given the content-review gap above.
  Flip to public once reviewed, if desired.
- **Conflicts with existing tracked state**: this repo's original README
  claims MusliMalang and salatwebapp should be archived once MuslimAll
  is "verified working." That condition is not yet met (see above) —
  both remain independently live with no archive notice, and that's the
  correct state until the Next up items are done.

## Verification log
- 2026-07-23: discovered while working through tracked projects in
  order (was not part of the original 12-repo audit). Not a git repo at
  discovery time, so `/security-review` didn't apply.
- 2026-07-23: read `guide_builder.dart` and `prayer_guides.dart`
  directly to confirm content completeness (see Done above) rather than
  trusting the README's claims.
- 2026-07-23: `git init`, committed, pushed to a new private GitHub
  repo. No Flutter SDK available locally, so `flutter analyze`/`test`
  still unconfirmed.

## Next up
1. Get the religious content reviewed (recitations for Dzuhur/Ashar/
   Maghrib/Isya, Dalil references, theme-to-verse mapping) before
   treating it as authoritative.
2. Run `flutter analyze` and `flutter test` on a machine with the
   Flutter SDK installed; fix anything that surfaces.
3. Finish or remove the "Audio (coming soon)" stub.
4. Update the portfolio site's project links if MuslimAll is meant to
   replace what's featured there.
5. Only then: archive MusliMalang and salatwebapp, and flip this repo
   to public if desired.
