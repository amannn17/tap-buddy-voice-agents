# Round 2 campaign report: parent and teacher (1 to 2 Nov 2026)

**Source:** `Campaign_Wise_Report_-_Nov_01_-_Nov_02__2026.xlsx` (VocalLabs export)
**Agent:** Parent Bot v2 on both campaigns
**Prompt:** `parent-v2.4` (both campaigns; the teacher campaign should have used `teacher-v2.0`)

## Summary

- **Parents:** the bot worked end to end for the first time (school names spoken, steps in order, technical breaks about 5%). But 60% of answered calls were lost before the parent confirmed who they were, and none of the 24 who reached the teach-back gave a fully accurate answer.
- **Teachers:** the campaign ran the **parent** agent by mistake. Teachers were asked if they were the child's parent, so nothing was learned about `teacher-v2.0`. About 50 teachers heard a confusing call.

## Parent campaign (100 parents, 6:30 to 6:41 PM, one attempt each)

| Measure | Result | Pass mark |
| --- | --- | --- |
| Answer rate | 73 of 100 (73%) | none |
| Hung up within 10 s | 6 of 73 (8%) | under 15%: met |
| Technical breaks | about 4 of 73 (5%), provisional | under 10%: met |
| Confirmed they're the parent | 29 (29%) | |
| Heard the core message | 25 (25%) | |
| Reached the teach-back | 24 (24%) | |
| Accurate teach-back | 0 of 24 (6 partial, 7 wrong, 11 no answer) | baseline |
| Agreed to remind the child | 17 (17%) | baseline |
| Credits | 202 (about 2.8 per answered call) | |

**Where parents were lost**

| Stage | Lost |
| --- | --- |
| Greeting only (median 12 s) | 15 |
| Identity question (median 37 s) | 29 (24 hung up) |
| Awareness question | 4 |
| Skipped teach-back (bug) | 1 |
| Teach-back question | 5 |
| Reached the close | 19 |

**Findings**

- The identity question was the main loss. Summaries often said "no response recorded" after it, and one "yes" was transcribed as "S". The likely causes were the agent missing short "हाँ" replies, or the opening sounding like a sales call ("credit card hai").
- Teach-back: parents remembered the activity but rarely the video or the photo. Parents new to Tap Buddy did worst (6 of 11 wrong). A "yes" at the commitment didn't show understanding: all 7 with wrong teach-backs still said yes.
- Bugs: the agent hung up when a parent said "hold"; one call skipped the teach-back; one call read out `{{student_name}}`.
- Questions with no answer: what time the video comes, the child's registered name, what happens at school, English messages, getting the information on WhatsApp.

## Teacher campaign (100 teachers, 6:30 PM)

| What happened | Calls |
| --- | --- |
| Answered | 61 |
| Hung up at the greeting or no data | 11 |
| Voicemail | 2 |
| No answer to "are you the parent?" | 17 |
| Said not the parent; told "wrong number" or call ended | 10 |
| Said they were the teacher; promised a callback | 8 |
| Went through the whole parent script | 13 |

The 13 who went through the parent script had higher awareness (10 of 13) than real parents, which suggests teachers playing along. It may also mean some parent numbers are on the teacher list (confirmed later, in the 3 Nov round).

## Data and configuration issues

- Rows reconciled: 200 rows, 200 attempts, 200 unique contacts.
- `success_metric` was False on every row.
- `callback_required` was "yes" on most hang-ups, so it worked as "retry this number".
- Some `last_step_reached` values were wrong.
- The Intent Stats tab had leftover fields from another agent.
- No retries were made.

## Actions taken

- A listening list of 25 parent calls: `campaign-analytics/listening-lists/2026-11-02_parent_round2_listening_list_redacted.xlsx`
- An internal test log for the parent bot: `test-logs/parent_bot_test_log.xlsx`
- A round 2 learnings doc (private Claude Doc, not in this repo)
