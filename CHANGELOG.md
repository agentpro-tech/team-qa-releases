# Changelog

## 1.15.0 — 2026-10-30

Team QA as a Claude Code plugin: Team QA 1.15.0, QA GUI 2.17.0, QA Code 1.11.0 and the Dragon runtime 1.6.10.

- Install in Claude Code with `/plugin marketplace add agentpro-tech/team-qa-releases` and `/plugin install team-qa@agentpro`. The plugin holds the same signed packages as the suite download.
- `teamqa` is on the PATH of the commands Claude runs; the Team QA hooks are on for the runs you register, and do nothing for any other session.
- Each skill uses the QA GUI, QA Code or Team QA installed next to it, never a copy from another install.
- In the plugin, `teamqa doctor` notes how Team QA is installed, warns about a second install or a hook staged earlier, and names the Dragon runtime of the release (`dragon-runtime.dbrc` on each release page).
- The suite installer works as before for Codex and for installs by hand.
- `teamqa update` now also fetches the Dragon runtime a suite carries and only installs the suite the signed channel names. Coming from 1.14.0, whose `teamqa update` stops with `SUITE_DRAGON_RUNTIME_DRIFT`, install 1.15.0 once with its `install.sh` (or move to the plugin); later updates work from 1.15.0 on.

## 1.14.0 — 2026-10-29

First public release of the Team QA suite: Team QA 1.14.0, QA GUI 2.16.0, QA Code 1.10.0 and the Dragon runtime 1.6.10.

- One signed bundle with a one-command installer; every package is verified against the publisher key before anything is installed.
- `teamqa doctor` checks the machine in order and names the fix for the first gap; `teamqa doctor --bundle` writes a diagnostic file for support.
- `teamqa update` reads this repository's signed channel at most once a day and installs a newer suite only when you ask.
- The signed Dragon runtime installs with `teamqa dragon install`, checked before it runs.
- A cost estimate before you approve a run, an optional cost cap, and the actual cost per role in the report.
- Boards and reports never carry test-account passwords.
- Free for now: no licence needed.
