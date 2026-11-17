# Parent round 3 campaign report (11 Nov 2026)

**Source:** `parent_bot_11-11.csv` (VocalLabs export, 285 attempts)
**Agent:** Parent Bot v2
**Prompt:** `parent-v2.8`
**Contacts:** 200 parents
**Timing:** first attempts 6:28 to 7:04 PM; one retry about 1 hour later (7:29 to 8:00 PM) for 85 numbers

**Caveat:** the export had no post-call fields (no last step, teach-back or commitment). All stage counts come from reading the call summaries, so treat each as about ±2.

## Results against goals

| Measure | Round 2 (100 parents) | Round 3 (200 parents) | Goal | Round 3 vs goal |
| --- | --- | --- | --- | --- |
| Answer rate | 73% (one attempt) | 62% (124 of 200, with retry); 49.5% on first attempt | 80% | Missed |
| Drop-off within 10 s (of answered) | 8% | 9.7% (12 of 124) | under 10% | Met |
| Drop-off at 11 to 20 s (of answered) | not measured | 24% (30 of 124) | track | |
| Core message heard | 25% | 22.5% (45 of 200) | 40% | Missed |
| Accurate teach-back | 0% | 0% (0 of 45) | 5% | Missed |
| Agreed to give the phone and remind | 17% | 14% (28 of 200) | | |
| Credits | 202 | 335 (about 2.7 per answered call, 7 per core message, 12 per commitment) | | |

## Funnel through the script

| Stage | Parents | Lost here |
| --- | --- | --- |
| Dialled | 200 | |
| Answered | 124 | 76 not answered, even after the retry |
| Real person (not voicemail) | 122 | 2 voicemail |
| Stayed through the opening ("नमस्ते। यह एक automated call है…") | 84 | **38**, mostly at 9 to 18 s |
| Confirmed parent (Step 2 started) | 66 | **18**: about 12 no answer or unclear, 4 not the parent, 1 stop, 1 cut off |
| Reached the awareness question | 62 | 4: couldn't continue, in hospital, hung up |
| Heard the full routine (teach-back asked) | 45 | **17**: about 13 hung up during the 45-second main block; 4 scripted exits |
| Commitment asked | 36 | 9 |
| Agreed | 28 | 8 no clear yes |

## Findings

1. **The opening loses the most parents.** `v2.8` opens with "यह एक automated call है" before naming the school or child. Together with the identity question, it loses 56 of 122 real people (46%).
2. **The main block is the second leak.** About 45 seconds without a pause (learning line, role line, three steps, recap): 17 of 62 left during it.
3. **The teach-back tests the wrong thing.** 0 of 45 named all three of the child's steps; the photo was almost always missing. Parents said "the child will know", "explain it to her directly", "I'm not educated". Their real role is to hand over the phone and remind the child, which is what 28 agreed to.
4. **The retry helped:** 25 more parents connected, 7 of them for full calls. But a 1-hour gap is too short.
5. **The bot handled real situations well:** driving, hospital, a family away for Chhath Puja, a sick child, "not interested". There were no hang-ups on hold or on questions.

## Issues to check

- **Explained to a non-parent (call A).** A daughter answered, and the agent explained the programme and asked her for a teach-back. The `student_name` column may also hold a parent's name on some rows (as in calls A and B). Most rows hold student names.
- **Team-contact promises.** TEAM, UNKNOWN and the distress line all promise the team will contact the parent. With no post-call fields, nobody can see who was promised a call.
- **Post-call fields missing from the export,** and `success_metric` still False.

## Decisions for round 4

The prioritised changes are built into `parent-v2.9`:

1. Remove "automated call" from the first line; move it into the Step 2 opener.
2. Shorten the main block from about 45 s to about 20 s.
3. Change the teach-back to the parent's own action: "मंगलवार को video आने पर आप क्या करेंगे?"

Round 4 settings: 7:00 to 8:30 PM, concurrency 3, retry the next evening, first-attempt answer rate reported separately, post-call fields restored.
