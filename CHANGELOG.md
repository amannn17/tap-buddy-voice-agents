# Tap voice agents: version and campaign log

Last updated: 19 Nov 2026

## Folder layout

| Folder | What goes in it | File naming |
| --- | --- | --- |
| `prompts/<agent>/` | One file per prompt version, with its change table, plus the paste-ready prompt and FAQ sheet where a version has them | `<agent>-v<x.y>.md`, `<agent>-v<x.y>_clean.txt`, `<agent>-v<x.y>_FAQ.xlsx` |
| `claude-reports/` | Campaign reports and internal test reports | `YYYY-MM-DD_<agent>_round<n>_<prompt-version>.md` |
| `campaign-analytics/` | Round summaries, measure definitions, redacted listening lists | `YYYY-MM-DD_<agent>_round<n>_listening_list_redacted.xlsx` |
| `test-logs/` | Scripted internal test calls | `<agent>_bot_test_log_<prompt-version>.xlsx` |
| `raw-exports/` (local only, git-ignored) | VocalLabs CSV and XLSX exports, unchanged | Keep VocalLabs' file name, prefixed with the date |

**Rule of thumb:** every campaign report names the exact prompt version that was live, and every prompt file says which campaign results it responds to.

## Campaign rounds

| Agent | Round | Date | Prompt | Contacts (attempts) | Timing | Report |
| --- | --- | --- | --- | --- | --- | --- |
| Parent | 1 | 19 Oct | earlier version | 99 (99) | Noon | — |
| Parent | 2 | 1 to 2 Nov | parent-v2.4 | 100 (100) | 6:30 PM | — |
| Parent | 3 | 11 Nov | parent-v2.8 | 200 (285) | 6:28 PM, retry about 1 h later | `claude-reports/2026-11-11_parent_round3_parent-v2.8.md` |
| Parent | 4 | planned | parent-v2.9 | 200 | 7:00 to 8:30 PM, retry next evening | — |
| Teacher | 1 | 19 Oct | earlier version | 100 (102) | Noon, Monday | — |
| Teacher | 2 | 1 to 2 Nov | parent-v2.4 (**wrong agent; not valid**) | 100 (100) | 6:30 PM | — |
| Teacher | 3 | 3 Nov | teacher-v2.2-opt | 100 (100), same list as round 2 | 5:05 PM, concurrency 10, no retries | — |
| Teacher | 4 | 18 Nov | teacher-v2.2-opt (unchanged) | 200 (200), new cleaned list | 11:26 AM to 12:04 PM, concurrency 6, retries off by mistake | `claude-reports/2026-11-18_teacher_round4_teacher-v2.2-opt.md` |
| Teacher | 5 | planned | teacher-v2.3 | 200, new list | From 11 AM, concurrency 3 to 4, retry 2 to 3 PM | — |

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
| teacher-v2.2-opt | before 3 Nov | "Tap team" identity, RAPID SUMMARY for busy teachers, COORDINATOR instead of TEAM, no callback promises, rule on when the call may end, English lines, empty-name fallback | Rounds 3 (3 Nov) and 4 (18 Nov), unchanged | `prompts/teacher/teacher-v2.2-opt.md` |
| teacher-v2.3 | 19 Nov | Commitment asks for the photo ("class के काम की एक photo", without "पूरी" so the ask sounds small). Teacher's part rewritten as three actions: show the video in one class period, get students to do the activity, send one photo of the class's work. TEACHER QUESTIONS and answer-type SITUATIONS moved to a 22-row FAQ knowledge base to bring the prompt under 5k tokens. Hold branch and WhatsApp call rule considered and left out (one call each per round). New teach-back scoring in the post-call fields | Round 5 (planned) | `prompts/teacher/teacher-v2.3.md`, `teacher-v2.3_clean.txt`, `teacher-v2.3_FAQ.xlsx`, `teacher-v2.3_post-call-fields.md` |

## Internal tests

| Date | Agent and prompt | Result | File |
| --- | --- | --- | --- |
| 3 Nov | Parent, parent-v2.4 | 31 of 35 marked steps passed. Hang-ups on OTP and English questions; silence didn't move the call on; flat exams reply. Calls 8 to 14 and export checks not run | `claude-reports/2026-11-03_parent-v2.4_internal-test-report.md`, `test-logs/parent_bot_test_log.xlsx` |
| — | Teacher, teacher-v2.0 | Test log built; needs updating for teacher-v2.3 (both commitment variants, English speaker, FAQ questions, a question outside the FAQ, extra work, fraud, busy teacher, empty name) | `test-logs/teacher_bot_test_log_teacher-v2.0.xlsx` |

## Measure definitions

These keep rounds comparable. If a definition changes, note it here.

- **Answer rate:** answered contacts ÷ contacts dialled. From round 3 on, report first attempt and with retries separately.
- **Drop-off within 10 s:** answered calls of 10 s or less ÷ answered calls.
- **Drop-off at 11 to 20 s:** answered calls of 11 to 20 s ÷ answered calls. Added in round 3.
- **Core message heard:** contacts who heard the full routine (or, for teachers, the RAPID SUMMARY) ÷ contacts dialled.
- **Accurate teach-back:** accurate first answers ÷ contacts dialled.
  - Parent, up to v2.8: all three of the child's steps (video, activity, photo).
  - Parent, from v2.9: the parent's own action (give the phone, remind or encourage). **Not comparable with earlier rounds.**
  - Teacher, up to round 4: video shown in a class period, students do the activity, one photo of the class's work sent, as labelled by the export. Round 4 listening showed this labelling is too strict, so report the listened figure alongside it.
  - Teacher, from v2.3: the same three steps, scored on meaning by the post-call rubric. "Photo or video" counts; agreeing without stating a step is **agreed_only**, not partial; **wrong** only for an incorrect action. **Compare with round 4 rescored, not with the export figure.**
- **Agreed to act:** contacts who said yes to the commitment question ÷ contacts dialled.
  - Teacher, up to v2.2-opt: agreed to show the next video.
  - Teacher, from v2.3: agreed to send the photo; "will show the video" only counts as unclear. **Not comparable with earlier rounds.**
- **Technical breaks:** answered calls ended by an agent or platform fault (silence end, hold end, timeout) ÷ answered calls. Pass mark under 10%.

## Open items

Parent:
- Post-call fields missing from the 11 Nov export. Restore them before parent round 4.
- Someone to follow up TEAM, UNKNOWN and distress promises (parent-v2.8 and v2.9).
- Retries: set to 3 hours apart or the next evening.

Teacher, before round 5:
- Retries: round 4 ran with retries off. Set busy and no-answer to retry at 2 to 3 PM, and answered calls to "Retry Eligible equals yes". Check a test export shows unanswered calls as Rescheduled.
- Post-call fields: add RAPID Summary, Teach-back Missing, Correction Given, Teacher Feedback and Retry Eligible; update Teach-back Result, Commitment Given and Unhandled Topics; delete the duplicate Last Step Reached.
- Load the FAQ sheet as the knowledge base and check the prompt's token count in VocalLabs (cut ENGLISH LINES if over 5k).
- Update the teacher test log for v2.3 and run it.
- Rescore the 40 round 4 teach-backs with the new rubric; listen to db49f19e, 67977ec6 and a539a839.

Teacher, later:
- Early hang-ups: 25% of answered teachers end within 10 s. Listen to the 7 early hang-ups before choosing round 6's change. 658bf539 and 95fb72b5 picked up and stayed silent: check whether the teacher could hear the bot.
- Silence: the platform nudges after 7 s and hangs up after 25 s, but the prompt's own silence rules (5 s, and 3 s at the "started yet?" question) fire first. Consider letting the platform handle silence.
- Hold branch: left out of v2.3 (about one call per round). Revisit if it recurs. Keep teach-back silence on the test list.
- FAQ gaps needing answers from the programme team: "all teachers or only me?", "students not registered", "videos arrive in a group but aren't shown".
- Teacher list: check the 28 numbers that never connected if the round 3 list is reused.

Both:
- Randomised comparison (WhatsApp only vs WhatsApp plus call): needs the number of teachers available and the current weekly photo rate.
