# Changelog

## 1.14.0 — 2026-10-29

First public release of the Team QA suite: Team QA 1.14.0, QA GUI 2.16.0, QA Code 1.10.0 and the Dragon runtime 1.6.10.

- One signed bundle with a one-command installer; every package is verified against the publisher key before anything is installed.
- `teamqa doctor` checks the machine in order and names the fix for the first gap; `teamqa doctor --bundle` writes a diagnostic file for support.
- `teamqa update` reads this repository's signed channel at most once a day and installs a newer suite only when you ask.
- The signed Dragon runtime installs with `teamqa dragon install`, checked before it runs.
- A cost estimate before you approve a run, an optional cost cap, and the actual cost per role in the report.
- Boards and reports never carry test-account passwords.
- Free for now: no licence needed.
