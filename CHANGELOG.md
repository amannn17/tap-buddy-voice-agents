# Tap voice agents: version and campaign log

Last updated: 17 Nov 2026

## Folder layout

| Folder | What goes in it | File naming |
| --- | --- | --- |
| `prompts/<agent>/` | One file per prompt version, with its change table | `<agent>-v<x.y>.md` |
| `claude-reports/` | Campaign reports and internal test reports | `YYYY-MM-DD_<agent>_round<n>_<prompt-version>.md` |
| `campaign-analytics/` | Round summaries, measure definitions, redacted listening lists | `YYYY-MM-DD_<agent>_round<n>_listening_list_redacted.xlsx` |
| `test-logs/` | Scripted internal test calls | `<agent>_bot_test_log_<prompt-version>.xlsx` |
| `raw-exports/` (local only, git-ignored) | VocalLabs CSV and XLSX exports, unchanged | Keep VocalLabs' file name, prefixed with the date |

**Rule of thumb:** every campaign report names the exact prompt version that was live, and every prompt file says which campaign results it responds to.

## Prompt versions

### Parent bot

| Version | Date | What changed | Tested in | File |
| --- | --- | --- | --- | --- |
| parent-v2.4 | 2 Nov | Fixed round 1 breakage: school variable, step order, opening order ("automated" after the purpose), listening break, teach-back of at most three items, no promises at the close | Round 2 (1 to 2 Nov); internal tests (3 Nov) | `prompts/parent/parent-v2.4.md` |
| parent-v2.5 | proposed 3 Nov | When the call may end, fraud line, English UNKNOWN, busy or exams line | Not run separately; folded into later versions | — |
| parent-v2.8 | before 11 Nov | Rule on when the call may end, holds, backchannels, turn blocks, variable check, SHORT VERSION, phone-and-remind commitment, exams line. Opening moved "automated call" to the first line | Round 3 (11 Nov) | `prompts/parent/parent-v2.8.md` |
| parent-v2.9 | 12 Nov | Opening: school first, "automated" moved into Step 2. Main block shortened to about 20 s. Teach-back asks about the parent's own action. New post-call field definitions | Round 4 (planned, 7 PM) | `prompts/parent/parent-v2.9.md` |

### Teacher bot

| Version | Date | What changed | Tested in | File |
| --- | --- | --- | --- | --- |
| teacher-v2.0 | 2 Nov | Teacher-only script, "दो minute" time check with callback, teach-back on the class period only | Never ran: round 2 used the parent agent by mistake | `prompts/teacher/teacher-v2.0.md` |
| teacher-v2.2-opt | before 3 Nov | "Tap team" identity, RAPID SUMMARY for busy teachers, COORDINATOR instead of TEAM, no callback promises, rule on when the call may end, English lines, empty-name fallback | Round 3 (3 Nov) | `prompts/teacher/teacher-v2.2-opt.md` |

## Internal tests

| Date | Agent and prompt | Result | File |
| --- | --- | --- | --- |
| 3 Nov | Parent, parent-v2.4 | 31 of 35 marked steps passed. Hang-ups on OTP and English questions; silence didn't move the call on; flat exams reply. Calls 8 to 14 and export checks not run | `claude-reports/2026-11-03_parent-v2.4_internal-test-report.md`, `test-logs/parent_bot_test_log.xlsx` |
| — | Teacher, teacher-v2.0 | Test log built; needs updating for teacher-v2.2-opt | `test-logs/teacher_bot_test_log_teacher-v2.0.xlsx` |

## Measure definitions

These keep rounds comparable. If a definition changes, note it here.

- **Answer rate:** answered contacts ÷ contacts dialled. From round 3 on, report first attempt and with retries separately.
- **Drop-off within 10 s:** answered calls of 10 s or less ÷ answered calls.
- **Drop-off at 11 to 20 s:** answered calls of 11 to 20 s ÷ answered calls. Added in round 3.
- **Core message heard:** contacts who heard the full routine (or, for teachers, the RAPID SUMMARY) ÷ contacts dialled.
- **Accurate teach-back:** accurate first answers ÷ contacts dialled.
  - Parent, up to v2.8: all three of the child's steps (video, activity, photo).
  - Parent, from v2.9: the parent's own action (give the phone, remind or encourage). **Not comparable with earlier rounds.**
  - Teacher: video shown in a class period, students do the activity, one photo of the class's work sent.

## Open items

- Post-call fields missing from the 11 Nov export. Restore them before parent round 4.
- Someone to follow up TEAM, UNKNOWN and distress promises (parent-v2.8 and v2.9).
- Retries: set to 3 hours apart or the next evening.
- Teacher list: remove family numbers and check the 28 numbers that never connected.
- Teacher prompt: fix teach-back silence and add a hold branch; update the teacher test log for teacher-v2.2-opt.
- Randomised comparison (WhatsApp only vs WhatsApp plus call): needs the number of teachers available and the current weekly photo rate.
