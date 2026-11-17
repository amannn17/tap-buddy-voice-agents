# Teacher round 3 campaign report (3 Nov 2026)

**Source:** `teacher_bot_0311.csv` (VocalLabs export) and the dashboard screenshots
**Agent:** Teacher Hybrid Bot V2
**Prompt:** `teacher-v2.2-opt`
**Contacts:** the same 100 teachers as round 2 (61 reached in round 2, 39 not)
**Timing:** 5:05 to 5:13 PM, parallel calls 10, one attempt each, no retries

## Summary

The right agent ran this time, and it followed the prompt closely. But only 15 of 100 teachers heard the core message and 2 gave an accurate teach-back. Most losses came before the explanation: unanswered numbers, a poor calling time, and the first 30 seconds.

## Results

| Measure | Result | Pass mark or goal |
| --- | --- | --- |
| Answer rate | 50 of 100 (50%) | goal for next round: 65% |
| Hung up within 10 s (dashboard, of answered) | 11 of 50 (22%) | under 15% |
| Technical breaks | about 2 to 3 of 50 (4 to 6%) | under 10%: met |
| Heard the core message (full call or RAPID SUMMARY) | 15 (15%) | goal for next round: 30% |
| Reached the teach-back (calls of 60 s or more) | 11 (11%) | |
| Accurate teach-back | 2 of 11 (4 partial, 1 wrong, 1 wrong frame, 3 no answer) | goal for next round: 6% |
| Agreed to show the next video | 5 (5 of 7 who reached the close) | |
| Credits | 99 (about 2 per answered call) | |

## Funnel

| Stage | Teachers |
| --- | --- |
| Dialled | 100 |
| Answered | 50 |
| Past the greeting | 33 |
| Past identity and time check | 17 |
| Heard the core message | 15 (11 full, 4 RAPID SUMMARY) |
| Reached the teach-back | 11 |
| Reached the close | 7 |
| Agreed | 5 |
| Accurate teach-back | 2 |

**Where teachers were lost**

- Not answered: 29 no answer, 21 busy. 28 numbers have never connected across two rounds.
- At the greeting: 14 hung up within 16 s, 2 were silent until the bot ended, 1 voicemail.
- Before the explanation, mostly scripted exits: 4 in class, driving or unavailable; 3 family numbers on the teacher list; 2 asked "who is calling?" twice and hung up; 1 hold ("एक minute") ended the call; 1 said yes then went silent.
- At the teach-back: 2 hung up, 1 ended by the silence bug, 1 hung up after asking a question.

## Findings against `teacher-v2.2-opt`

**Working as designed:** RAPID SUMMARY for busy teachers (4 calls ending at 51 to 54 s), no callback promises, END for in class, driving, wrong number and not available, COORDINATOR for device problems, the wrong-frame correction.

**Real issues**

1. Silence at the teach-back ended the call (it should give the summary line and move on).
2. No hold branch: "एक minute" fell into the silence rule and ended the call.
3. Silence at the greeting took 30 to 32 s to end instead of about 12 to 15 s, so the platform timeout is probably longer than the prompt assumes.
4. Two teachers didn't recognise "Tap team".
5. Field logging: `Tap Period Started` said "not_asked" on at least 2 calls where the teacher answered; a teach-back missing two items was labelled partial; nothing marks the RAPID SUMMARY; `success_metric` was False.

**List problems:** at least 3 numbers belong to students' families; 28 numbers have never connected; one answering machine wasn't detected.

**New FAQ lines needed:** "Will all teachers get the video, or only me?", "My students aren't registered", "The videos come in a group but aren't shown".

## Effect of timing

At 5:05 PM, with all calls placed in 8 minutes, many teachers were driving or still in class. Fixing the timing alone would probably raise the core message figure to about 20 to 25 out of 100. Reaching 30% also needs retries, a cleaned list and the silence fix.

## Next round (planned)

- 200 teachers, from 11 AM, parallel calls 3, two retries at least 3 hours apart, list cleaned.
- Goals: answer rate 65%, drop-off within 10 s under 15%, core message 30%, accurate teach-back 6%, agreed 12%.
- Dashboard shortcut: calls of 60 s or more closely match teachers who reached the teach-back.
- The teacher test log was built for `teacher-v2.0` and needs updating for `teacher-v2.2-opt`.
