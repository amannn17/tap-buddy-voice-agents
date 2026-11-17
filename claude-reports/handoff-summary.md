# Tap Voice Agents: Handoff Summary

As of 2 Nov 2026. Paste or attach this at the start of a new chat to carry on.

## Context

Tap runs Tap Buddy, a school-approved learning programme on WhatsApp. Students get a short video and activity each week and send a photo of their work. Tap is building outbound Hindi voice agents (on VocalLabs) to call **parents** and **teachers** so they understand the programme. The baseline for submissions with WhatsApp alone is about 20%.

Working approach: discuss and agree on changes before building. Instructions are written in English; spoken lines in Devanagari Hindi with common English words.

## Round 1 results (19 Oct 2026)

| | Parents | Teachers |
| --- | --- | --- |
| Calls placed | 99 | 102 |
| Connected | 68 (69%) | 61 (60%) |
| Ended within seconds, incl. voicemail | 23 (median 7 s) | 15 (median 5 s) |
| Lasted 60 s or more | 34 | 24 |
| Clean calls (audit) | 14 (21% of connected) | 9 (15% of connected) |
| No-answer or busy, never retried | 31 | 38 |

- **Parents: the bot broke.** The school variable was malformed (`_name}}`) and empty on all rows. The prompt paused after "money, science या art" without asking anything. Step 1 skipped to Step 3. The opening led with "recorded".
- **Teachers: people hung up** (11 of 16 failed calls). They were called at noon on a Monday, the script mixed teacher and student actions, the call was long, and ALL-CAPS names were mispronounced.
- **Not measured:** teach-back and submissions (`success_metric` False on all rows). The export has 256 rows against 201 calls placed, which hasn't been reconciled.

## What was built

| Item | Status | Where |
| --- | --- | --- |
| Parent prompt `parent-v2.4` + change log, config checklist, open questions | Ready, untested | `prompts/parent/parent-v2.4.md` |
| Parent post-call field spec (for VocalLabs) | Ready to send | Private Claude artifact (not in repo) |
| Teacher prompt `teacher-v2.0` + change log, config checklist, open questions | Ready, untested | `prompts/teacher/teacher-v2.0.md` |
| Teacher post-call field spec | Ready to send | Private Claude artifact (not in repo) |
| Gnani.ai vendor evaluation checklist | Ready | Private Claude artifact (not in repo) |
| Round 1 review and round 2 plan (findings, prompt before/after, masked schema) | Ready | Private Claude artifact (not in repo) |
| Interaction maps (parent and teacher call flows) | Two FigJam boards in Figma drafts | "Tap Buddy parent call flow (parent-v2.4)", "Tap Buddy teacher call flow (teacher-v2.0)" |

## Key design decisions

- **Opening:** "हेलो?", wait, then name the school and child (or the Tap programme) in the first sentence. "Automated assistant" comes after the purpose; the recording notice is in Step 2.
- **Listening break** about 15 s in: one easy question where any answer is fine (parents: has the child mentioned Tap Buddy; teachers: has the Tap period started). Silence moves on after 3 s.
- **Silence rules** are set per question type: about 5 s, or 3 s at the listening break.
- **Teach-back:** at most three items. Correct once and never re-test. The first answer is what gets scored. The teacher teach-back covers only the Tap period (show the video, students do the activity, send one photo); the home message comes after it and isn't tested.
- **Commitment question** is time-neutral (parents: remind the child; teachers: show the next Monday video), and its answer is logged.
- **Close:** thanks only. No promises of future calls, no chasing.
- **Repeated lines** are defined once: CALLBACK, TEAM, UNKNOWN (cap of three per call).
- **Logging** is kept out of the prompt; the post-call fields are filled from the transcript.
- **Teacher time check:** "दो minute", with a callback at a time the teacher chooses.

## Cost and optimisation notes

- **Billing:** VocalLabs bills by duration, about 1 credit per 30 s. Prompt length doesn't affect cost; call length does.
- **Prompt size:** about 2.5k to 3.5k tokens is fine. Keep it lean for reply speed and how reliably rules are followed.
- **Script:** keep spoken lines in Devanagari. Romanised Hindi doesn't save money and is pronounced worse.

## Open questions (unresolved)

- **Facts the parent script needs:**
  - Does the recording notice have a timing rule?
  - Keep "money" as an example course?
  - Which WhatsApp number do messages come from?
  - Can the team call back in other languages?
- **Facts the teacher script needs:**
  - When is the Tap period?
  - What should a teacher do with no device in class?
  - How many photos per class?
  - How should the agent answer "Is it compulsory?"
  - Do home activities arrive on Tuesday afternoon, as parents are told?
  - Should "coding" be in the teacher course list when parents can't hear it?
  - Who handles teacher problems sent to the team?
- **For VocalLabs:** Can the export include `ended_by` and `seconds_to_end`? Can they add the new fields? Is automatic callback scheduling available?
- **Telephony:** which caller ID number series (TRAI 140 vs 1600) applies to nonprofit awareness calls? Check with an adviser.

## Round 2 plan

1. Fix configuration and data:
    - Variables in snake_case, checked by ear.
    - Names in Devanagari or title case.
    - Parents called 6:00 to 8:30 PM; teachers after school.
    - Two retries, at least 3 h apart.
    - Automatic callbacks and voicemail detection.
2. Run the eight internal test calls per agent.
3. Parent pilot with 50 to 100 parents, then a teacher pilot with 50 to 100 teachers.
4. Check against the pass marks:
    - Technical breaks under 10%.
    - Hang-ups in the first 10 s under 15%.
    - Teach-back recorded on over 90% of calls that reach it.
    - Post-call fields correct in 19 of 20 audited calls.
5. Decide on the randomised comparison: WhatsApp-only vs WhatsApp plus call, about 1,100 per arm to detect 20% → 25% across all contacts. If only those who pick up are affected, roughly 2,000 to 2,500 per arm are needed.
6. Optional: run the same prompt on Gnani.ai side by side.

## Analysing the analytics sheet (next step)

**Data checks first:**

- Filter by version.
- Count attempts and contacts separately.
- Reconcile row counts against calls placed.
- Separate voicemail from hang-ups.
- Mask phone numbers.

| Measure | Calculation | Pass mark |
| --- | --- | --- |
| Connect rate | connected ÷ placed | none |
| Early hang-ups | connected, `ended_by` = listener, `seconds_to_end` < 10, ÷ connected | under 15% |
| Technical breaks | connected, ended by agent or system before close, excluding scripted ends (callback, wrong number, opt-out, silent pickup), ÷ connected | under 10% |
| Teach-back recorded | filled ÷ calls reaching teach-back (parent step ≥ 5, teacher ≥ 4) | over 90% |
| Teach-back accuracy | accurate ÷ recorded, plus the other labels | baseline |
| Commitment | yes ÷ calls reaching Step 6 | baseline |
| Drop-off | `last_step_reached` on listener-ended calls | shows the next fix |
| Awareness | `prior_awareness` / `tap_period_started` split | baseline |
| Callbacks | `callback_required` share; teacher "later" answers and how many callbacks completed | keep time check if they complete |
| Cost | credits per connected call and per accurate teach-back | compare with round 1 |

**Cross-checks:**

- Teach-back accuracy by prior awareness.
- Early hang-ups by call time.
- `unhandled_topics` by theme (the next FAQ lines).

**Reading rules:**

- With 50 to 100 calls, only big differences matter.
- Look at where calls fail, not just how many.
- Change one thing per pilot.
- Only the randomised comparison shows an effect on submissions.
