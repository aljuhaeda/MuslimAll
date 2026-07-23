# MuslimAll — Progress

## Status
**Public**: https://github.com/aljuhaeda/MuslimAll — content reviewed,
code/security reviewed, build verified. Remaining open item is the
audio stub and the still-separate archive decision for
MusliMalang/salatwebapp (see Next up).

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

## In progress
- Nothing currently active. Remaining items are tracked under Next up.

## Known issues / honest limitations
- **One explicitly unfinished feature**: an audio button tooltipped
  `"Audio (coming soon)"` in `lib/view/prayer_guide_screen.dart:200`.
- **Conflicts with existing tracked state**: this repo's original README
  claims MusliMalang and salatwebapp should be archived once MuslimAll
  is "verified working." Code and content are now both verified — but
  archiving the predecessors is tracked as a separate, still-open
  decision (see Next up), not something done automatically alongside
  the public flip.

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
1. Finish or remove the "Audio (coming soon)" stub.
2. Update the portfolio site's project links if MuslimAll is meant to
   replace what's featured there.
3. Decide whether/when to archive MusliMalang and salatwebapp — still a
   separate, open decision from the public flip (which is now done).
