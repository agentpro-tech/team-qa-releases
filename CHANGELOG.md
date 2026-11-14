# Changelog

## 1.19.0 — 2026-11-14

QA on Production by consequence: Team QA 1.19.0, QA GUI 2.19.0, QA Code 1.11.2 and the Dragon runtime 1.7.0.

- Every step is judged by what it causes, not by where it runs: R0 read, R1/R2 a change inside the test identities and the data the run created, R3 a step that reaches real people, R4 a final effect outside the test (money, stock, shipping, invoices, messages to customers, publishing, other users' data), R5 never (a real person's password, one-time codes, CAPTCHA, real cards, identity papers).
- `teamqa target init --type saas|ecommerce|finance|operations|messaging|content` writes an app's target profile from a preset: test identities, test data prefix, the channels that reach the outside world (`none`, `sandbox` or `live`), sensitive areas and limits. The owner approves it once in the run's approval channel (the chat of the root session or the host thread), with the same source check as a plan approval. A changed profile needs a new approval.
- `teamqa directive add|approve|revoke` opens one final action for one case, with a count, an amount cap, a compensation and an expiry. Revoking needs no approval.
- `teamqa action check` classes a step from its label (English and Vietnamese, with or without diacritics), URL, field and the profile, decides, and records the decision; exit 3 means the step is not done and the case is ungraded with `PROD_GRANT_REQUIRED`. GUI executors on Production get the same decision in their case prompt.
- `teamqa identity add|issue|mark|list` keeps test identities in a 0600 pool and hands a run its accounts file; passwords are read from stdin, generated at random for self sign-up, and kept out of the board, report, RTM and plan by the existing secret scan.
- `teamqa created add|plan|cleaned|residue` records the test data a run creates and its clean-up. The report adds a Production safety section and the result line adds `production_actions`, `production_denied`, `grant_waiting_cases`, `created` and `residue`.
- QA GUI 2.19.0: a test identity Team QA issued for the run may sign in; on Production it follows `teamqa action check`. Used on its own, QA GUI keeps asking before any irreversible write.
- From 1.15.0 or later, `teamqa update` installs 1.19.0; in Claude Code, `/plugin update team-qa@agentpro`.

## 1.18.0 — 2026-11-13

QA boards as Doc-Colab task boards: Team QA 1.18.0, QA GUI 2.18.0, QA Code 1.11.2 and the Dragon runtime 1.7.0.

- `teamqa board publish --to colab` now publishes the QA board as a Doc-Colab task board: every case and defect is a card in a status column, with priority, function and UI verdicts, requirement, steps, expected result, findings and evidence, so the team can use the Kanban, table and timeline views, filter, and comment on each card.
- An Overview page under the board shows the release verdict, the run facts, and live numbers and charts (cases, passed, open and closed defects, cases by function verdict, open defects by priority) that Doc-Colab keeps current as cards move.
- A new revision moves the same cards and keeps their comments and the cards people added; the board is read back field by field before the link is printed. The board shows only the statuses the run uses. A run published as a page by 1.17.0 keeps that form.
- From 1.15.0 or later, `teamqa update` installs 1.18.0; in Claude Code, `/plugin update team-qa@agentpro`.

## 1.17.0 — 2026-11-12

QA jobs from Buzz, boards on Doc-Colab: Team QA 1.17.0, QA GUI 2.18.0, QA Code 1.11.2 and the Dragon runtime 1.7.0.

- A Buzz agent session can be the root of a run. The plan is approved by a signed Buzz message in the job thread, and Team QA checks the signature.
- `teamqa board publish --to colab --channel <channel>` publishes the QA board to Doc-Colab: one task board per run, every case and defect a card people can open and comment on, evidence uploaded, and the doc read back and compared field by field before the link is printed.
- Web identity: a static HTML page counts as a deployed build, scripts a browser extension injects are not page code, and a Claude Code or Buzz root accepts a Production target the request names.
- From 1.15.0 or later, `teamqa update` installs 1.17.0; in Claude Code, `/plugin update team-qa@agentpro`.

## 1.16.2 — 2026-11-10

Claude Code and Codex side by side: Team QA 1.16.2, QA GUI 2.18.0, QA Code 1.11.2 and the Dragon runtime 1.7.0.

- With the Claude Code plugin installed, the suite installer and `teamqa update` (the Codex install) keep the `~/.codex/skills` links and move the `~/.claude/skills` links of qa-code, qa-gui and team-qa to `~/.agents/skills/.backups`. Claude Code loads Team QA once, from the plugin, and Codex keeps using `~/.agents/skills`.
- `teamqa doctor` warns `DUPLICATE_INSTALL` only when Claude Code would load Team QA twice.
- From 1.15.0 or later, `teamqa update` installs 1.16.2; in Claude Code, `/plugin update team-qa@agentpro`.

## 1.16.1 — 2026-11-10

A fix to the Dragon runtime install: Team QA 1.16.1, QA GUI 2.18.0, QA Code 1.11.2 and the Dragon runtime 1.7.0.

- `teamqa dragon install` installs for real. Before, it ran the runtime's installer by a path macOS reaches through a symlink, the installer skipped its work and exited 0, and Team QA reported the runtime installed while the old one kept running. It now passes only when the installer reports the new version running (`DRAGON_RUNTIME_INSTALL_UNCONFIRMED` otherwise).
- If you ran `teamqa dragon install` before, run it again with this release; `teamqa doctor` names the runtime version that is running.
- From 1.15.0 or later, `teamqa update` installs 1.16.1; in Claude Code, `/plugin update team-qa@agentpro`.

## 1.16.0 — 2026-11-10

QA GUI's detectors in Team QA runs: Team QA 1.16.0, QA GUI 2.18.0, QA Code 1.11.2 and the Dragon runtime 1.7.0.

- GUI cases run QA GUI's detectors through Dragon 1.7.0: forced loading and error states, a transient probe of each case's main action (fresh test values for a save, none for a delete), an entry probe of each screen, and a width sweep and overlay check once per screen.
- A screen a case reaches from a share link, with no route in the plan, gets the same screen checks. A check that never gets past the link or the sign-in page is UNGRADED (`SCREEN_ENTRY_NOT_REACHED`).
- The GUI executor proves the build in the call that opens its tab (`openTab {url, proveIdentity: true}`). The three separate identity reads still work on an older Dragon.
- On a Dragon older than 1.7.0 these checks are reported as not run.
- Also: coverage cells from state receipts, an optional adjudicator from another model family (shadow by default), speed flags that stay off unless the plan turns them on, lighter evidence, and dispatch, hook and update fixes.
- From 1.15.0 or 1.15.1, `teamqa update` installs 1.16.0; in Claude Code, `/plugin update team-qa@agentpro`.

## 1.15.1 — 2026-10-30

Fixes from a review of the 1.15 release: Team QA 1.15.1, QA GUI 2.17.1, QA Code 1.11.1 and the Dragon runtime 1.6.10.

- Roster and plan approval refuse any message that says no, not yet, wait or stop, in English or Vietnamese. "Don't approve yet" no longer counts as an approval.
- The test-password scan reads the forms real accounts files use (`ADMIN_PASSWORD=`, labels in Vietnamese, quoted values, numbers, `.env` files, linked files), scans outputs of any size, and warns `TEST_SECRETS_NOT_FOUND` when it reads no value.
- QA GUI: a board with no executed case, or one that says GO while cases are still TODO, is UNGRADED, never PASS. `qa_do` reports PASS only for a complete, clean run. Its scripts also work when run through a linked folder.
- QA Code: every PASS needs a green Gate 0; a secret or CVE scanner that fails is UNGRADED; gitleaks runs with QA Code's own config, so the reviewed repository cannot change it.
- From 1.15.0, `teamqa update` installs 1.15.1; in Claude Code, `/plugin update team-qa@agentpro`.

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
