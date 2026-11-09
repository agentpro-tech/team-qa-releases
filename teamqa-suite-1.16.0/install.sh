#!/usr/bin/env bash
# Team QA suite installer.  bash install.sh [--license <license.json>] [--dest-root <dir> --compat-root <dir>]
set -euo pipefail
HERE="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)"
command -v node >/dev/null || { echo 'SUITE_NODE_MISSING: install Node.js 20 or later (nodejs.org), then run this again' >&2; exit 20; }
MIN="$(node -p "require(process.argv[1]).requirements.node.min" "$HERE/suite.json")"
node -e "const [a,b]=process.argv.slice(1).map(v=>v.split('.').map(Number));process.exit(a[0]>b[0]||a[0]===b[0]&&(a[1]>b[1]||a[1]===b[1]&&a[2]>=b[2])?0:1)" "$(node -p process.versions.node)" "$MIN" || { echo "SUITE_NODE_TOO_OLD: Node.js $MIN or later is needed; nothing was installed" >&2; exit 20; }
WORK="$(mktemp -d "${TMPDIR:-/tmp}/teamqa-suite-boot.XXXXXX")"
read -r ZIP FOLDER < <(node -p "const s=require(process.argv[1]).skills.find(x=>x.skill==='team-qa');s.zip+' '+s.folder" "$HERE/suite.json")
/usr/bin/unzip -q "$HERE/$ZIP" -d "$WORK/env" && /usr/bin/unzip -q "$WORK/env/$FOLDER/payload.zip" -d "$WORK/p"
echo "publisher key: $(node -p "require(process.argv[1]).key_id" "$WORK/p/team-qa/security/owner-grant-key.json")"
exec node "$WORK/p/team-qa/scripts/teamqa.mjs" suite install --dir "$HERE" "$@"
