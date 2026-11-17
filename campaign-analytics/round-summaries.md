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

| Measure | R1 (19 Oct) | R2 (1 to 2 Nov) | R3 (3 Nov) | R4 (18 Nov, planned) |
| --- | --- | --- | --- | --- |
| Prompt | earlier version | parent-v2.4 (wrong agent) | teacher-v2.2-opt | teacher-v2.2-opt plus fixes |
| Contacts (attempts) | 100 (102) | 100 (100) | 100 (100) | 200 |
| Calling time | Noon, Monday | 6:30 PM | 5:05 PM | From 11 AM |
| Answer rate | 61% | not valid | 50% | goal 65% |
| Ended within 10 s, of answered | 20% | not valid | 22% | goal under 15% |
| Ended at 11 to 20 s, of answered | 13% | not valid | 18% | |
| Listened through to the teach-back | not measured | not valid | 11 | |
| Accurate teach-back | not measured | not valid | 2 of 11 | goal 6% |
| Agreed to act | not measured | not valid | 5 | goal 12% |
| Credits per answered call | 2.3 | | 2.0 | |

## Notes

- The listened-through counts come from the export's own field, so they run 1 below the summary-based counts in the round reports (25 and 45).
- Teacher round 3 also had 4 teachers who heard the RAPID SUMMARY only, which that field doesn't capture.
- Parent round 3's export had no post-call fields; its stage counts in the report were read from call summaries (about ±2 each).
- Hang-ups in the first 10 s fell from 26% to 8% between parent rounds 1 and 2. The opening and the calling time changed together, so the drop can't be credited to either alone.
