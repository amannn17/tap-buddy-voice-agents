#!/usr/bin/env bash
# Creates the first commits in story order, so the history reads as a timeline.
# Run once from the repo root after unzipping:  bash scripts/first-commits.sh
set -euo pipefail

if [ -d .git ]; then echo "This folder is already a git repo. Stopping."; exit 1; fi

# Safety check: refuse to commit anything that looks like a 10-digit phone number.
if grep -rIEn --exclude-dir=.git --exclude=first-commits.sh '(\+?91[ -]?)?[6-9][0-9]{9}' . ; then
  echo "Possible phone numbers found above. Remove them before committing."; exit 1
fi

git init -b main
git add .gitignore README.md
git commit -m "Repo setup: README and .gitignore (raw exports never committed)"

git add claude-reports/handoff-summary.md
git commit -m "Round 1 (19 Oct): handoff summary with round 1 audit and round 2 plan"

git add claude-reports/2026-11-02_round2_parent-v2.4_and_teacher.md campaign-analytics/listening-lists
git commit -m "Round 2 (1 to 2 Nov): parent-v2.4 report; teacher run used the wrong agent"

git add test-logs claude-reports/2026-11-03_parent-v2.4_internal-test-report.md
git commit -m "Internal tests (3 Nov): parent and teacher test logs; parent-v2.4 31 of 35 steps passed"

git add claude-reports/2026-11-03_teacher_round3_teacher-v2.2-opt.md
git commit -m "Teacher round 3 (3 Nov): teacher-v2.2-opt, 15 of 100 heard the core message"

git add claude-reports/2026-11-11_parent_round3_parent-v2.8.md
git commit -m "Parent round 3 (11 Nov): parent-v2.8, 46% of real people lost at the opening"

git add prompts
git commit -m "parent-v2.9 (12 Nov): school first, 20 s main block, teach-back on the parent's action"
git tag parent-v2.9

git add campaign-analytics docs templates CHANGELOG.md scripts
git commit -m "Case study, round summaries, measure definitions, CHANGELOG and log template"

echo
echo "Done. Next: create an empty private repo on GitHub, then run:"
echo "  git remote add origin https://github.com/<you>/tap-buddy-voice-agents.git"
echo "  git push -u origin main --tags"
