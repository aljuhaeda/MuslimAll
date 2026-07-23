# MuslimAll — Progress

## Status
Pushed to GitHub (private): https://github.com/aljuhaeda/MuslimAll —
backed up, and now build-verified (analyze/test/build/run all clean).
**Still not reviewed for religious content accuracy** — that's the only
remaining blocker before considering archiving MusliMalang/salatwebapp.

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
- **Repo is private** — intentional, given the content-review gap above.
  **Confirmed instruction: flip to public as soon as the religious
  content review is done** — not conditional, just waiting on that one
  trigger.
- **Conflicts with existing tracked state**: this repo's original README
  claims MusliMalang and salatwebapp should be archived once MuslimAll
  is "verified working." Build verification is now done (see below) —
  the remaining blocker is specifically the content review, not the
  code. Both predecessors remain independently live with no archive
  notice until that review happens.

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
1. Get the religious content reviewed (recitations for Dzuhur/Ashar/
   Maghrib/Isya, Dalil references, theme-to-verse mapping) before
   treating it as authoritative. **This is now the only remaining
   blocker** — code is verified working.
2. **As soon as #1 is done: flip this repo from private to public**
   (`gh repo edit aljuhaeda/MuslimAll --visibility public --accept-visibility-change-consequences`).
   Confirmed standing instruction from the project owner — do this
   without waiting for a fresh ask once the review is confirmed done.
3. Finish or remove the "Audio (coming soon)" stub.
4. Update the portfolio site's project links if MuslimAll is meant to
   replace what's featured there.
5. Only then: archive MusliMalang and salatwebapp — that's a separate,
   still-open decision from the public/private flip.
