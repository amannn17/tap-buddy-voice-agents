# Round summaries

All figures are recomputed from the VocalLabs exports. Measures are defined in [`measure-definitions.md`](measure-definitions.md). Per-round detail is in [`claude-reports/`](../claude-reports/).

## Parent bot

| Measure | R1 (19 Oct) | R2 (1 to 2 Nov) | R3 (11 Nov) | R4 (planned) |
| --- | --- | --- | --- | --- |
| Prompt | earlier version | parent-v2.4 | parent-v2.8 | parent-v2.9 |
| Contacts (attempts) | 99 (99) | 100 (100) | 200 (285) | 200 |
| Calling time | Noon | 6:30 PM | 6:28 PM, retry about 1 h later | 7:00 to 8:30 PM, retry next evening |
| Answer rate | 69% | 73% | 62% (49.5% first attempt) | goal 80% |
| Ended within 10 s, of answered | 26% | 8% | 10% | goal under 10% |
| Ended at 11 to 20 s, of answered | 3% | 15% | 24% | track |
| Listened through to the teach-back | not measured | 24 | 44 | |
| Accurate teach-back | not measured | 0 of 24 | 0 of 44 | goal 5% (new definition) |
| Agreed to act | not measured | 17 | 28 | |
| Credits per answered call | 3.0 | 2.8 | 2.7 | |

## Teacher bot

| Measure | R1 (19 Oct) | R2 (1 to 2 Nov) | R3 (3 Nov) | R4 (18 Nov) | R5 (planned) |
| --- | --- | --- | --- | --- | --- |
| Prompt | earlier version | parent-v2.4 (wrong agent) | teacher-v2.2-opt | teacher-v2.2-opt (unchanged) | teacher-v2.3: photo in the commitment, FAQ moved to a knowledge base |
| Contacts (attempts) | 100 (102) | 100 (100) | 100 (100) | 200 (200), new cleaned list | 200, new list |
| Calling time | Noon, Monday | 6:30 PM | 5:05 PM, concurrency 10 | 11:26 AM to 12:04 PM, concurrency 6, no retries | From 11 AM, concurrency 3 to 4, retry 2 to 3 PM |
| Answer rate | 61% | not valid | 50% | 62.5% (first attempt only) | goal 60% first attempt, 70% with retries |
| Ended within 10 s, of answered | 20% | not valid | 22% | 25% | goal under 15% |
| Ended at 11 to 20 s, of answered | 13% | not valid | 18% | 11% | track |
| Listened through to the teach-back | not measured | not valid | 11 | 40 | |
| Heard the core message (full call or RAPID SUMMARY) | not measured | not valid | 15 (11 full, 4 RAPID) | about 46 (40 full, about 6 RAPID) | goal 30% of contacts |
| Accurate teach-back | not measured | not valid | 2 of 11 | 4 of 40 in the export; 8 of 40 after listening | goal 6% of contacts (new scoring) |
| Agreed to act | not measured | not valid | 5 (show the next video) | 30 (show the next video), plus 6 unclear | goal 10% of contacts agree to send the photo (new question) |
| Technical breaks, of answered | not measured | not valid | at least 2 calls | 3% (4: 3 silence ends, 1 hold) | goal under 10% |
| Credits per answered call | 2.3 | | 2.0 | 2.4 | |

## Notes

- The listened-through counts come from the export's own field, so they run 1 below the summary-based counts in the round reports (25 and 45).
- The RAPID SUMMARY isn't captured by the listened-through field: teacher round 3 had 4 teachers who heard it only, and teacher round 4 had about 6. From round 5 a RAPID Summary post-call field records it.
- Parent round 3's export had no post-call fields; its stage counts in the report were read from call summaries (about ±2 each).
- Hang-ups in the first 10 s fell from 26% to 8% between parent rounds 1 and 2. The opening and the calling time changed together, so the drop can't be credited to either alone.
- Teacher rounds 3 and 4 used the same prompt, so their differences come from the calling time (5 PM vs 11 AM), the list (reused 100 vs new 200) and the call rate (8 vs 38 minutes), not the script. These can't be separated. Agreement rising from 5% to 15% is outside the noise for these sample sizes; the rise in core message heard (15% to about 23%) is borderline.
- Teacher round 4 ran with retries off by mistake: all 75 unanswered calls were marked Done, not Rescheduled.
- Teacher round 4 teach-back labels were checked by ear. All 4 "accurate" calls held up, and all 4 checked "wrong" calls (a04de66d, ffd34705, e9ed1be9, eae6cac6) were accurate. In ffd34705, speech recognition heard "chat" as "ChatGPT". Two "wrong" calls (db49f19e, 67977ec6) are still unchecked, so 8 is a floor: the count could reach 10, or 5% of contacts. Report both the export figure and the listened figure for round 4.
- From teacher-v2.3, two definitions change (see the [CHANGELOG](../CHANGELOG.md)). Accurate teach-back uses a meaning-based rubric, so round 5 is compared with round 4 rescored under it, not with the export figure. Agreed to act means agreeing to send the photo, not to show the video, so it isn't comparable with rounds 3 and 4.
- Teacher round 4 goals were answer rate 60%, ended within 10 s under 15%, core message 30% and accurate teach-back 6%. Round 4 met the answer-rate goal only. The agreement goal was set after round 4 and applies from round 5.
