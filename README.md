# Tap Buddy Voice Agents

**Conversation design and prompt engineering for outbound Hindi voice AI, built for The Apprentice Project (TAP).**

Tap Buddy is a school-approved learning programme on WhatsApp. Each week, a student gets a short video and an activity, then sends a photo of their work. With WhatsApp alone, about 20% of students submit. This repo documents the voice agents I designed to call **parents** and **teachers** in Hindi, explain the weekly routine in about two minutes, and check that they understood it.

> **My role:** I led the voice agent initiative: conversation design, prompt engineering, test design, campaign analysis and vendor coordination. I directed an intern on how campaign data is shared and how campaigns are set up.
> **Timeline:** October to November 2026 · **Platform:** VocalLabs · **Tools:** Claude, Excel, FigJam

The full write-up is in [`docs/case-study.md`](docs/case-study.md).

---

## At a glance

| | |
| --- | --- |
| Agents | Parent awareness, teacher awareness |
| Campaign rounds | 3 parent rounds and 3 valid teacher rounds; parent round 4 and teacher round 5 planned |
| Contacts dialled | 399 parents and 400 teachers (886 call attempts) |
| Prompt versions | 6 tracked across two agents |
| Language | Hindi (Devanagari) with common English words; English fallback |

Teacher round 2 (1 to 2 Nov) ran the parent agent by mistake, so its results aren't counted. Round numbers follow the [CHANGELOG](CHANGELOG.md).

## The problem

A voice call has no screen. Listeners can't scroll back or skim, and they decide whether to hang up in seconds. Many answer quietly ("हाँ", "जी"), are wary of scam calls, or pass the phone to a child.

Round 1 (19 Oct) broke in ways that set the brief for everything after it:

- The school name came through as `_name}}`, empty on every row.
- The script paused without asking a question, and skipped a step.
- Both agents called at about noon on a Monday, when teachers teach and many parents work.
- Nothing about understanding was measured.

## What I built

- **System prompts** structured for reliable behaviour: a variable check, a closed list of reasons a call may end, turn-taking and backchannel rules, hold handling, silence rules per question, and fixed lines defined once.
- **A teach-back step** that checks understanding instead of counting "yes" answers, scored on the first answer and corrected once.
- **Post-call field specs** so every call is logged by the step reached, teach-back result, end reason and follow-up needed.
- **Internal test suites** (14 to 17 scripted test calls per agent) that run before any real listener hears a new version.
- **Campaign reports** with a funnel for each round, showing exactly where listeners were lost.

## Results so far

| Measure | Parents R1 | Parents R2 (v2.4) | Parents R3 (v2.8) | Teachers R1 | Teachers R3 (v2.2-opt) | Teachers R4 (v2.2-opt) |
| --- | --- | --- | --- | --- | --- | --- |
| Answer rate | 69% | 73% | 62% (49.5% first attempt) | 61% | 50% | 62.5% |
| Ended within 10 s, of answered | 26% | 8% | 10% | 20% | 22% | 25% |
| Listened through to the teach-back | not measured | 24 of 100 | 44 of 200 | not measured | 11 of 100 | 40 of 200 |
| Accurate teach-back | not measured | 0 of 24 | 0 of 44 | not measured | 2 of 11 | 8 of 40 after listening (4 in the export) |

Among answered parent calls, hang-ups in the first 10 s fell from 26% to 8% after round 1, when the opening was rewritten and calls moved from noon to the evening. Technical breaks fell to about 5% of answered calls in round 2. Round 3 showed where the remaining loss sits: 46% of real people were lost at the opening and identity question, and 17 of 62 during a 45-second explanation.

Teacher round 4 (18 Nov) ran the same prompt as round 3 at 11 AM on a new list. Answers rose from 50% to 62.5% and agreement tripled from 5% to 15%, but a quarter of answered teachers still hung up within 10 s. Listening showed the export's teach-back scoring was too strict: all 4 checked "wrong" answers were accurate.

None of this yet measures weekly submissions. That needs a randomised comparison of WhatsApp only against WhatsApp plus a call (about 1,100 contacts per arm). More detail: [`campaign-analytics/round-summaries.md`](campaign-analytics/round-summaries.md).

## What changed in v2.9

| Change | Why |
| --- | --- |
| The school is named in the first sentence; "automated call" moves to Step 2 | 24% of answered calls ended at 11 to 20 s, during the old opening |
| The explanation is cut from about 45 s to 20 s | 17 of 62 parents left during it |
| The teach-back asks what the *parent* will do | 0 of 45 could repeat the child's three steps; the parent's real job is to hand over the phone and remind |

## What changes in teacher-v2.3

| Change | Why |
| --- | --- |
| The commitment asks teachers to send a photo of the class's work, not only to show the video | The photo was the step teachers most often left out of the round 4 teach-back |
| The teacher's part is written as three actions: show the video in one period, get students to do the activity, send one photo | Puts the emphasis on what the teacher does, and stops "never add duties" conflicting with the photo ask |
| Teacher questions move from the prompt to a 22-row FAQ knowledge base | Keeps the prompt under 5k tokens, so the model follows it more reliably and is less likely to make up answers |
| Teach-back scoring is rewritten in the post-call fields, judged on meaning | Round 4's export labelled accurate answers as wrong |

## Repo map

| Folder | Contents |
| --- | --- |
| [`prompts/`](prompts/) | Every prompt version, each with its change table, plus paste-ready prompts and FAQ sheets ([index](prompts/README.md)) |
| [`claude-reports/`](claude-reports/) | Campaign and internal test reports, drafted with Claude from the VocalLabs exports |
| [`campaign-analytics/`](campaign-analytics/) | Round summaries, measure definitions and redacted listening lists (round 2) |
| [`test-logs/`](test-logs/) | Scripted internal test calls for each agent |
| [`templates/`](templates/) | The template for logging each new round |
| [`docs/`](docs/) | The case study (`images/` and `call-flows/` are placeholders for diagrams) |
| [`CHANGELOG.md`](CHANGELOG.md) | Which prompt version ran in which round |

Start with [`prompts/parent/parent-v2.9.md`](prompts/parent/parent-v2.9.md) and the [parent round 3 report](claude-reports/2026-11-11_parent_round3_parent-v2.8.md), or for teachers, [`prompts/teacher/teacher-v2.3.md`](prompts/teacher/teacher-v2.3.md) and the [teacher round 4 report](claude-reports/2026-11-18_teacher_round4_teacher-v2.2-opt.md).

## How I used Claude

Claude was my drafting and analysis partner. For each round I gave it the export, the call summaries and the live prompt; it built the funnel and pointed to the calls behind each loss. I decided which changes to make, and every change was agreed before it was built. Each new version ships with a table linking the change to the number it should move.

## Keeping this log

After every round:

1. Copy [`templates/campaign-log-template.md`](templates/campaign-log-template.md) into `claude-reports/` with the dated file name.
2. Add a row to the campaign table in the [CHANGELOG](CHANGELOG.md) and to [`round-summaries.md`](campaign-analytics/round-summaries.md).
3. For a new prompt version, add `prompts/<agent>/<agent>-v<x.y>.md` with its change table, and tag the commit (`git tag parent-v3.0`).
4. Commit with a message that says *why*, for example: `parent-v3.0: shorten identity question (R4: 18 of 66 lost here)`.

## Lessons

- Most listeners are lost in the first 20 seconds, not in the middle of the call.
- "Yes" isn't understanding. Test the listener's own role, in their own words.
- Many "prompt bugs" are platform settings: timeouts, retries, call windows.
- Agree the measurement plan and export fields before the first call.
- Check automatic scoring by ear before trusting it. Speech recognition errors can turn a correct answer into a "wrong" label.
- Don't write rules for one-off cases. A shorter prompt is followed more reliably.

## Privacy

No phone numbers, recordings, call IDs or names of children, parents, teachers or schools are included. Raw exports, including Numbers files, are kept out of this repo (see [`.gitignore`](.gitignore)).

## Credits

Built for [The Apprentice Project](https://www.theapprenticeproject.org/). Prompts and campaign data are shared with TAP's permission.
