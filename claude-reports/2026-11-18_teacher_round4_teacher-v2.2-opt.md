# Teacher round 4 campaign report (18 Nov 2026)

**Source:** `Teacher_Bot_18_Nov.csv` (kept in `raw-exports/`, not committed)
**Agent:** Teacher Hybrid Bot V2
**Prompt:** `teacher-v2.2-opt` (link to `prompts/teacher/teacher-v2.2-opt.md`), unchanged from round 3
**Contacts:** 200 (200 attempts), a new list with no overlap with rounds 2 and 3
**Timing:** 11:26 AM to 12:04 PM on 18 Nov, concurrency 6 (calls spread over 38 minutes), retries off (unanswered calls marked Done, not Rescheduled)
**Pre-launch checks:** agent and prompt version confirmed ☑ (after the round) · variables heard correctly on a test call ☐ · post-call fields present in a test export ☐ · internal test calls run ☐ (none recorded)

## Hypotheses going in

The prompt didn't change. The changes were operational: the calling time, a new list and a slower call rate.

| Change | Measure it should move | From (round 3) | Goal |
| --- | --- | --- | --- |
| Calling at 11 AM instead of 5 PM | Answer rate | 50% | 60% |
| Calling at 11 AM (fewer teachers driving or leaving school) | Core message heard | 15% | 30% |
| Calling at 11 AM | Ended within 10 s, of answered | 22% | under 15% |
| New list, cleaned to the guidelines (no reused, family or dead numbers) | Answer rate | 50% | 60% |
| None (same script) | Accurate teach-back | 2% | 6% |

## Results

| Measure | Last round (R3, 3 Nov) | This round (R4, 18 Nov) | Goal | Met? |
| --- | --- | --- | --- | --- |
| Answer rate (first attempt / with retries) | 50% / no retries | 62.5% (125 of 200) / no retries | 60% | ✅ |
| Ended within 10 s, of answered | 22% | 25% (31 of 125) | under 15% | ❌ |
| Ended at 11 to 20 s, of answered | 18% | 11% (14 of 125) | track | |
| Core message heard | 15% | about 23% (40 full call, about 6 RAPID SUMMARY) | 30% | ❌ |
| Accurate teach-back | 2% (2 of 11 reaching it) | 2% in the export (4 of 40); **3.5% after listening (7 of 40)** | 6% | ❌ |
| Agreed to act | 5% | 15% (30 of 200), plus 6 unclear | 12% | ✅ |
| Technical breaks | about 4 to 6% | about 2% (hold ended a call; one teach-back answer not captured) | under 10% | ✅ |
| Credits (per answered call / per core message) | 2.0 / about 6.6 | 2.4 / about 6.5 (301 in total) | | |

## Funnel

| Stage | Count | Lost here | Main reasons |
| --- | --- | --- | --- |
| Dialled | 200 | | |
| Answered | 125 | 75 | 47 no answer, 28 busy; no retries were scheduled |
| Past the opening | 87 | 38 | 30 hung up within 8 s, probably in class; 3 voicemail; 2 silent, with the greeting silence still taking about 30 s to end |
| Identity confirmed (past the identity and time check) | 62 | 25 | About 8 hung up at "क्या अभी बात हो सकती है?"; in class or can't talk (END by design); 1 wrong number; 1 thought there was a fee |
| Heard the core message | about 46 | about 16 | About 10 hung up in the Step 2 intro or at the started-yet question; maternity leave; teaches older classes; 1 hold ended the call |
| Reached the teach-back | 40 | about 6 | Heard the RAPID SUMMARY instead (by design; counted in the core message) |
| Agreed | 30 | 10 | 6 unclear ("I hope so", "I'll try"); 4 ended before the commitment |

## Hypotheses: confirmed or rejected?

| Change | Result | Verdict |
| --- | --- | --- |
| 11 AM raises the answer rate | 50% → 62.5% on a single attempt | Confirmed, but the list also changed, so the two can't be separated |
| 11 AM raises the core message | 15% → about 23% | Partly confirmed: up 8 points, short of 30% |
| 11 AM cuts hang-ups within 10 s | 22% → 25% | Rejected: teachers in class pick up and cut the call |
| Same script, no change in understanding expected | Export 2% → 2%; after listening 3.5% | As expected: understanding needs a script change |

## Findings

1. **11 AM gets more teachers to answer, but more cut the call immediately.** 30 hung up within 8 seconds, before anything was logged, which fits teachers who are in class. The time check cost about 8 more.
2. **Once a teacher reaches the explanation, the script holds.** 34 of 40 who reached the teach-back stayed to the close, and 30 agreed. 37 of 49 asked said their school had already started the videos, so for most the call is a reminder.
3. **The export's teach-back scoring is too strict.** Listening showed 3 of 6 checked "wrong" calls were accurate. One was marked wrong because speech recognition turned "chat" into "ChatGPT". All 3 checked "accurate" calls held up, and the 3 checked partials were fair.
4. **The photo is the step teachers most often leave out.** It's the most common missing item among the 26 partials, and it's the step Tap measures.
5. **The bot handled real situations well:** maternity leave, older classes, a teacher who refused, a fee question and a logistics issue. A request for a WhatsApp call wasn't covered by the prompt.

## Data and configuration issues

- **Retries off:** all 75 unanswered calls were marked `queue_status` Done. One teacher's "call me at 2 PM" request was picked up by Vocal Rescheduling (3dc23e2f).
- **`Unhandled Topics` empty on every row,** although the bot couldn't answer the WhatsApp call request (3a3bdef8). The field seems to match only the exact UNKNOWN wording.
- **`success_metric` False on every row.**
- **"Last Step Reached" appears twice** in the VocalLabs field list.
- **No hold branch in `teacher-v2.2-opt`:** a hold fell into the silence rule and ended the call (54f57a52).
- **Greeting silence takes about 30 s to end,** against about 12 to 15 s in the prompt, so the platform timeout is longer than the prompt assumes.
- **A capture problem in e2b993bd:** the teacher recalled everything, but a bot or network issue stopped it being recorded.
- **Still unchecked:** whether the bot said "free" in b188cf45 (a fee question, with background noise on the teacher's side).

## Decisions for the next round

1. **Turn on retries** for busy and no-answer, scheduled in a different slot (2 to 3 PM the same day). Check that the next export shows Rescheduled.
2. **Add a Retry Eligible post-call field** and use it as the rescheduling condition. Until then: Last Step Reached equals 1 or 2.
3. **One script change:** put the photo in the commitment question. "Monday को video दिखाकर, क्या आप class के काम की एक photo Tap Buddy chat पर भेज पाएँगे?"
4. **Add a hold branch** (wait up to about 30 s), as in parent-v2.8.
5. **Rewrite the Teach-back Result definition:** any wording counts; judge the meaning past speech-recognition errors; "wrong" only for an incorrect action; agreement or unrelated talk is no_answer.
6. **Widen `Unhandled Topics`** to any question the agent couldn't answer from the prompt's facts. Confirm what to tell teachers who ask for a WhatsApp call.
7. **Finish the listening list:** the 3 unchecked "wrong" calls, 77584d42, 3 photo partials, 7 early hang-ups and the hold call.

## Who did what

- **Me:** campaign goals, campaign setup in VocalLabs, listening to 12 calls (teach-back scoring, partials, possible bugs), decisions.
- **Intern:** cleaning the contact list (base) to the guidelines shared.
- **Claude:** funnel counts, listening list and draft report from the export (checked by me).
