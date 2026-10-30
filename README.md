# Team QA

Team QA runs QA on your app the way a small QA team would: it plans the testing, gets your sign-off on the plan, runs separate agents for each role, checks every verdict against evidence, and ends with a GO or NO_GO you can trace back to screenshots, network logs and recordings. It runs inside your own Claude Code or Codex session on your Mac.

This repository holds the signed releases and the `agentpro` plugin marketplace. Team QA is free to use for now, with no licence needed.

**Latest: Team QA 1.15.0** (with QA GUI 2.17.0, QA Code 1.11.0 and the Dragon runtime 1.6.10). See [Releases](../../releases).

## What you need

- A Mac (macOS). The Dragon browser runtime runs as a macOS LaunchAgent.
- Node.js 20 or later.
- Claude Code or Codex, signed in with your own plan.
- Google Chrome with the **Dragon Browser** extension from the [Chrome Web Store](https://chromewebstore.google.com/detail/dmgoldioklileddehbjpbfacojckfkjo).
- An app to test, and test accounts for it. Team QA reports bugs; it does not fix them.

## Install in Claude Code

Team QA is a Claude Code plugin. In Claude Code:

```text
/plugin marketplace add agentpro-tech/team-qa-releases
/plugin install team-qa@agentpro
```

The plugin holds the same signed suite as the download below (source: [agentpro-tech/team-qa-plugin](https://github.com/agentpro-tech/team-qa-plugin)). Claude Code does not update plugins from other marketplaces on its own until you allow it: open `/plugin`, go to **Marketplaces**, pick **agentpro** and choose **Enable auto-update**. Otherwise run `/plugin update team-qa@agentpro` when a new version is out.

Then ask Claude to run `teamqa doctor`: the `teamqa` command is on the PATH of the commands Claude runs. When the doctor reports the Dragon runtime missing, it prints the command that installs the signed runtime of this release, for example:

```bash
teamqa dragon install --from https://github.com/agentpro-tech/team-qa-releases/releases/download/team-qa-1.15.0/dragon-runtime.dbrc
```

Then install the Dragon extension (see [Dragon](#dragon) below) and ask for your first run.

## Install with the suite installer (Codex, or by hand)

1. Download `teamqa-suite-1.15.0.tar.gz` from the [latest release](../../releases/latest) and unpack it:

   ```bash
   tar xzf ~/Downloads/teamqa-suite-1.15.0.tar.gz -C ~/Downloads
   cd ~/Downloads/teamqa-suite-1.15.0
   ```

2. Run the installer. It checks Node, prints the publisher key id, verifies every signature, then installs QA Code, QA GUI and Team QA into `~/.agents/skills` (SCROLL, the runtime Team QA uses to confirm its writes, ships inside Team QA):

   ```bash
   bash install.sh
   ```

   The publisher key id must be `0cf79a5cf736467e17536e403e95fa66d9b901f29457b98d3111452329b3caa8`. If it is not, stop: the package is not ours.

3. Add a short name for the Team QA command (or use the full `node` command each time):

   ```bash
   alias teamqa="node ~/.agents/skills/team-qa/scripts/teamqa.mjs"
   ```

4. Check the machine. The doctor walks through what is missing, one item at a time, and names the fix:

   ```bash
   teamqa doctor
   ```

   It checks macOS, Node.js, the SCROLL runtime, Claude Code or Codex, QA GUI and QA Code, the Dragon runtime, the Dragon extension, and the Dragon commands Team QA needs.

### Dragon

- **Runtime.** If the doctor reports `DRAGON_RUNTIME_MISSING`, install the signed runtime: in the plugin, the command the doctor prints (the release's `dragon-runtime.dbrc`); with the suite installer, the runtime that ships in the suite folder. Team QA checks its signature before running any of it:

  ```bash
  teamqa dragon install --from ~/Downloads/teamqa-suite-1.15.0
  ```

- **Extension.** Install Dragon Browser from the Chrome Web Store, then open the extension's options and click **Connect**; a dialog on your Mac asks you to allow it once. If your version has no Connect button yet, paste the token from `~/.dragon-browser/auth/token` into the options instead.

Team QA uses the Chrome Web Store build of Dragon only. An unpacked extension or another browser-control tool is refused.

## Your first run

In Claude Code or Codex, open your app's repository and ask for a QA run, for example: "Run Team QA on the checkout flow of this app." Team QA then:

1. reads what the app should do and drafts a test plan with exit criteria;
2. shows you the plan, the roles, the models and a cost estimate before anything runs, and waits for your approval;
3. runs each case with independent agents (one drives the browser through Dragon, one reviews code), each with its own evidence;
4. builds a board and a report: every verdict links to its evidence, and the run ends with GO or NO_GO.

## Reading the results

| Verdict | Meaning |
|---|---|
| PASS | The case ran and the evidence shows the expected result. |
| FAIL | The case ran and the evidence shows a defect. |
| BLOCKED | The case could not run because something outside it failed (environment, data, a broken step before it). |
| NOT RUN | The case was planned but not executed in this run. |
| DEFERRED | The case was moved out of this run on purpose, with a reason. |
| PARTIAL | Only part of the case's checks could be graded. |
| UNGRADED | There is no evidence strong enough to grade the case. Team QA never turns missing evidence into PASS. |

GO means every case in scope met the exit criteria of the signed plan; NO_GO means at least one did not, and the report says which.

## Cost

Before you approve the roles, Team QA shows what the run is likely to cost at API list prices, measured on earlier Team QA runs: the planning roles per round and each GUI case. Your Claude or ChatGPT plan pays for it in usage instead. To cap a run, ask for a budget or run `teamqa cost cap --run <id> --usd <amount>`: once the run has spent it, no new case starts, finished cases keep their evidence and the run reports NOT COMPLETE. The report ends with the actual tokens and cost per role (`teamqa cost report --run <id>`).

## Updates

In Claude Code, the plugin updates as described under [Install in Claude Code](#install-in-claude-code); `teamqa update` leaves it to Claude Code.

With the suite installer, point Team QA at this repository once:

```bash
mkdir -p ~/.agentpro/teamqa
echo '{"channel":"https://raw.githubusercontent.com/agentpro-tech/team-qa-releases/main"}' > ~/.agentpro/teamqa/config.json
```

Then:

```bash
teamqa update --check     # is a newer suite published?
teamqa update             # install it (refused while a run is in progress)
```

Coming from 1.14.0: its `teamqa update` stops with `SUITE_DRAGON_RUNTIME_DRIFT`. Install 1.15.0 once with `bash install.sh` from the download above (or move to the plugin); `teamqa update` works from 1.15.0 on.

Team QA checks the channel at most once a day and never blocks a run. The channel index is signed with the same publisher key. The previous version is kept for rollback.

## Your data

- Screenshots, network and console logs, recordings, boards and reports stay in the run folder on your Mac.
- Prompts and outputs go only to the AI provider you use (Anthropic or OpenAI), under your own account.
- Team QA sends nothing to us and has no telemetry. The only request it makes for updates is reading this repository's signed channel index, and only once you set the channel. Claude Code downloads the plugin from GitHub; `teamqa dragon install --from <URL>` downloads the runtime from this repository's release page.
- The plugin's hooks act only for a session you registered to a Team QA run (`teamqa continuation register`); for every other session they answer at once and change nothing.
- The passwords of your test accounts never appear in the board, the report, the RTM or the plan: Team QA refuses to build a report that holds one (`teamqa secrets scan --run <id>` shows where). They may appear in the workers' own prompts and logs inside the run folder on your Mac.
- The Dragon runtime asks before destructive actions (delete, pay, submit) unless you choose otherwise.

## Getting help

Open an [issue](../../issues/new/choose) and attach the diagnostic file from `teamqa doctor --bundle diagnostics.json`. The file has tokens, passwords, e-mail addresses and your home path removed; read it before you attach it.

## Limits

- Team QA finds and reports defects; it does not change your code.
- Your app may need test accounts; use accounts made for testing.
- Runs use your Claude or ChatGPT plan and count toward its limits. Long runs with several agents can use a lot of it; see Cost above.
- macOS only for now.

Terms of use and a privacy policy will be published here.
