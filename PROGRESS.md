# MuslimAll — Progress

## Status
**Local prototype, not yet a git repository, not yet on GitHub.**
Not part of the original 12-repo audit — discovered during progress
tracking on 2026-07-23.

## Done (per its own README — not independently verified this session)
- Merges MusliMalang (prayer times) and salatwebapp (prayer guide) into
  one app: Indonesia-wide prayer times, full 5-prayer step-by-step guide,
  themed + random Quran verses.
- Prayer-guide content model extended to all 5 prayers (Dzuhur, Ashar,
  Maghrib, Isya newly written; Subuh carried over from salatwebapp,
  which only had Subuh built out).
- New "lantern at night" design identity, distinct from MusliMalang's.
- Own test suite (`test/logic`, `test/model`, widget smoke test).

## In progress
- Presumably active development — `lib/`, `build/`, `.dart_tool/` all
  modified 2026-07-21, more recent than MusliMalang's last commit.

## Known issues / honest limitations (stated by the project's own README)
- **Religious content has not had a scholarly review.** The prayer-guide
  recitations and theme-to-verse mapping are described as "best-effort
  compilation," explicitly flagged as needing review before being
  treated as authoritative — this is content people would actually pray
  from.
- **Not in git.** No commit history, no remote, nothing pushed to
  GitHub. If this machine is lost, so is this work.
- **Conflicts with existing tracked state**: this repo's README claims
  MusliMalang and salatwebapp should be archived once MuslimAll is
  "verified working" — but both are still listed as independently live
  in [C:\dev\PROGRESS.md](../../PROGRESS.md) and still have their own
  GitHub repos with no archive notice. This needs a decision from the
  project owner, not an automatic fix.

## Verification log
- 2026-07-23: discovered while working through tracked projects in
  order. Not a git repo, so `/security-review` (diff-based) doesn't
  apply. No Flutter SDK available locally to run `flutter analyze`/`test`.
  Nothing in this entry is independently verified — it restates what
  the project's own README claims.

## Next up
- Owner decision needed: (1) initialize git + push to GitHub, (2) get
  the religious content reviewed before wider use, (3) decide whether/
  when to actually archive MusliMalang and salatwebapp per this
  project's stated intent, or keep all three live.
