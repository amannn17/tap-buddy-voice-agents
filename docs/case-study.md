# Tap Buddy Voice Agents: Case Study

Last updated: 17 Nov 2026

## Headline

**Headline:** Designing for the first 20 seconds: voice AI for school parents in India

**Subtitle:** How I took Tap Buddy's outbound calling from a broken first pilot to a measured, versioned conversation system: 686 call attempts across five campaigns, five tracked prompt versions across two agents, and a funnel that shows exactly where each listener drops off.

| At a glance |  |
| --- | --- |
| Organisation | The Apprentice Project (TAP), Tap Buddy programme |
| My role | Led the voice agent initiative: conversation design, prompt engineering, test design, campaign analysis, vendor coordination |
| Timeline | 19 Oct to 18 Nov 2026 (three parent rounds and two valid teacher rounds so far; teacher round 4 on 18 Nov) |
| Agents | Parent awareness, teacher awareness |
| Stack | VocalLabs (voice platform), Claude (prompt drafting, analysis, reporting), Excel test logs, FigJam call-flow maps |
| Scale | 399 parents over three rounds and 200 teachers over two valid rounds (686 call attempts; a further 100 teacher calls on 1 to 2 Nov ran the parent agent by mistake and are excluded) |
| Language | Hindi in Devanagari with common English words; English fallback |


## The challenge

Tap Buddy reaches students through WhatsApp alone, and only about 20% of them send in their weekly work. The programme needed parents and teachers to understand it, and a phone call in Hindi reaches people that a WhatsApp message doesn't.

**Why voice AI.** Tap Buddy is a school-approved learning programme: each week a student gets a short video and activity on WhatsApp, then sends a photo of their work. Calling hundreds of families by hand wasn't feasible for a nonprofit team. An outbound Hindi voice agent could explain the routine in two minutes, check understanding, and log the result for every call.

**The design problem.** A voice call has no screen. The listener can't scroll back, skim, or see a button, and they decide whether to hang up in the first few seconds. Every design choice has to work by ear, in turns, for people who:

- often answer quietly, with "हाँ" or "जी", which speech recognition can miss;
- are wary of unknown numbers, OTP scams and sales calls;
- range from first-time smartphone users to English speakers;
- may hand the phone to a child or another adult mid-call.

**What round 1 showed (19 Oct, 201 calls).** The first pilot gave a clear list of failures, which became the brief for everything after it.

| Friction point | What happened | Type |
| --- | --- | --- |
| Malformed variable | The school name came through as `_name}}` and was empty on every row | Data |
| Dead air | The parent prompt paused after listing courses without asking anything | Conversation design |
| Broken flow | Step 1 skipped to Step 3 | Prompt logic |
| Wrong first impression | The opening led with "this call is recorded" | Conversation design |
| Wrong time | Both agents called at about noon on Monday 19 Oct, when teachers teach and many parents work; 11 of 16 failed teacher calls were hang-ups | Operations |
| Mispronounced names | Names stored in ALL CAPS were read out badly | Data |
| Nothing measured | `success_metric` was False on every row; 256 export rows against 201 calls placed | Analytics |

Only 14 of 68 connected parent calls (21%) and 9 of 61 connected teacher calls (15%) were clean. The goal for every round after this was the same: get more people to hear the core message, and prove whether they understood it.

## Process 1: prompt engineering with Claude

I treated the system prompt as the interface. Each version answered a specific failure in the last campaign's data, and no change was built until it had been discussed and agreed.

**How I worked with Claude.** Claude acted as a drafting and analysis partner, not an author of decisions. The loop for each round was:

1. Feed Claude the campaign export, call summaries and the live prompt.
2. Have it build the funnel and name where listeners were lost, with call IDs as evidence.
3. Agree the smallest set of changes that targets the biggest leak.
4. Draft the new version with a change table: what changed, why (with the round's number), and which measure should move.
5. Write internal test calls that exercise each change before any real parent hears it.

**Prompt architecture.** The parent prompt (`parent-v2.9`, about 28 KB including notes) is organised so the model can follow it reliably under pressure:

| Block | What it does | Why it's there |
| --- | --- | --- |
| VARIABLE CHECK | Never say an empty or placeholder variable; fall back to "आपके बच्चे" | Round 1 read out `_name}}`; round 2 read out `{{student_name}}` once |
| WHEN THE CALL MAY END | A closed list of the only reasons to hang up | Internal tests showed the bot hanging up on an OTP question and an English question |
| TURN-TAKING | Backchannels ("हाँ", "जी", "हम्म") don't interrupt; every turn ends on a question | Quiet parents were being missed or talked over |
| TURN BLOCKS | Named groups of lines said as one turn | Stops the bot pausing mid-explanation and losing the listener |
| HOLDS | "एक minute" means wait up to 30 s, not end | Round 2 bot hung up when a parent said "hold" |
| Silence rules per question | 3 s at the awareness question, 5 s elsewhere, 7 s at the teach-back | One silence rule for every question ended calls that should have moved on |
| FIXED LINES | CALLBACK, TEAM, UNKNOWN, RESUME defined once, with English versions | Consistent wording; a cap of three UNKNOWNs per call |
| Steps 1 to 5 | Opening, trust, routine, teach-back, commitment | The script itself |
| PARENT QUESTIONS, SITUATIONS, ALWAYS-ON RULES | Short facts and a priority order (opt-out, then safety, then identity) | Real questions from transcripts become FAQ lines |

**Key design decisions**

- **Purpose before disclosure.** The first sentence names the school and the programme; "automated call" comes in Step 2. Round 3 opened with "यह एक automated call है" and lost 38 of 122 real people at the opening.
- **A listening break about 15 s in.** One easy question where any answer is right ("has your child mentioned this?"), so the call feels like a conversation, not a recording.
- **Teach-back, not agreement.** Saying yes doesn't show understanding: in round 2, all 7 parents with wrong teach-backs still agreed to help. The first answer is scored, corrected once, and never re-tested.
- **Test the listener's own job.** Up to v2.8 parents were asked to repeat the child's three steps; 0 of 45 managed it in round 3. v2.9 asks "मंगलवार को video आने पर आप क्या करेंगे?", which is the parent's real role: give the phone and remind.
- **Words that build trust.** "कोई फ़ीस नहीं" instead of "free"; "activity" instead of "homework"; a fixed fraud line saying Tap never asks for money, OTP or bank details.
- **No promises at the close.** Thanks only. Every "the team will contact you" line is logged so someone can follow it up.
- **Devanagari for spoken lines.** Romanised Hindi doesn't save cost and is pronounced worse.

**Version history**

| Version | Date | Change | Driven by |
| --- | --- | --- | --- |
| parent-v2.9 | 12 Nov | School first in the opening; main block cut from about 45 s to 20 s; teach-back on the parent's action; new post-call fields | Round 3 funnel |
| parent-v2.8 | before 11 Nov | When the call may end, holds, backchannels, turn blocks, variable check, SHORT VERSION | Internal tests on v2.4 |
| teacher-v2.2-opt | before 3 Nov | "Tap team" identity, RAPID SUMMARY for busy teachers, no callback promises | Round 1 teacher hang-ups |
| parent-v2.4, teacher-v2.0 | 2 Nov | Fixed variables and step order, listening break, teach-back of at most three items | Round 1 audit |

## Process 2: data hygiene and variable injection

The agent says each listener's school and child name aloud, so a bad row in the upload list is a broken sentence in someone's ear. I made the contact list part of the design, with checks in the data and a safety net in the prompt.

**In the data**

- **Variable names in snake\_case, checked by ear.** Round 1's `_name}}` came from a malformed template variable. After the fix, `{{school_name}}` was spoken correctly on round 2 calls.
- **Names in Devanagari or title case.** ALL-CAPS names were mispronounced in round 1.
- **The right field in the right column.** Round 3 showed some `student_name` cells holding a parent's name. The pre-launch checklist now requires student names only and no empty rows.
- **Clean lists per audience.** At least 3 numbers on the teacher list belonged to students' families, and 28 teacher numbers never connected across two rounds. Both are flagged for removal or checking.
- **Reconcile before reading.** Round 1's export had 256 rows for 201 calls. From round 2, rows were reconciled to attempts and unique contacts (200 = 200 = 200) before any rate was calculated.
- **Mask before sharing.** Phone numbers are masked in every analysis file.

**In the prompt**

The VARIABLE CHECK block means a bad row degrades gracefully instead of breaking the call. If a variable is empty or looks like a placeholder (braces, underscores, or the words "student" and "name"), the agent never says it. It says "आपके बच्चे" or "बच्चे के school" instead and switches to a fallback identity question.

**Honest framing for your portfolio.** Don't claim injection became error-free. Round 2 still read out `{{student_name}}` once, and round 3 surfaced parent names in the student column. The stronger story is defence in depth: data checks catch most problems, and the prompt's fallback stops the rest from reaching the listener.

## Process 3: vendor ops and parameter tuning

The agents run on VocalLabs. Many failures that looked like prompt problems were platform settings, so I tuned the platform as deliberately as the script.

| Parameter | Before | After | Evidence |
| --- | --- | --- | --- |
| Parent calling window | Noon (round 1); 6:30 PM (round 2); 6:28 to 7:04 PM (round 3) | 7:00 to 8:30 PM | Round 3 first-attempt answer rate was 49.5% |
| Teacher calling window | Noon Monday, then 5:05 PM | From 11 AM | At 5:05 PM many teachers were driving or still in class |
| Concurrency | 10 parallel calls (teachers), not recorded (parents) | 3 | 100 teacher calls placed in 8 minutes all hit the same bad moment |
| Retries | None, then one retry 1 hour later | One retry the next evening (parents); two retries at least 3 h apart (teachers) | The 1-hour retry reached 25 more parents, but the gap was too short |
| No-response timeout | Off or longer than the prompt assumed | About 3 to 5 s, and it must hand the bot a turn | Silence stalled calls in tests; greeting silence took 30 to 32 s to end on teacher calls |
| Agent assignment | Teacher campaign ran the parent agent | Check agent and prompt version before launch | Round 2: about 50 teachers were asked if they were the child's parent |
| Post-call fields | Not used in the round 3 report; success\_metric False on every row of all five exports | Checked in the export before any analysis; new fields for v2.9 | The 11 Nov export does hold the fields, and they match the summary-based counts within 1 |

**Post-call field spec.** Logging is kept out of the spoken prompt. VocalLabs fills structured fields from each transcript, which I specified so they map to the funnel: `last_step_reached` (0 to 5), `teach_back_result` (accurate, wrong\_frame, wrong, no\_answer), `teach_back_photo`, `end_reason`, `team_followup_needed`, `prior_awareness`, `commitment_given`, `unhandled_topics`. `success_metric` is set to an accurate teach-back.

**Cost.** VocalLabs bills about 1 credit per 30 s, so call length drives cost and prompt length doesn't. That made trimming the main block from about 45 s to 20 s a cost decision as well as a UX one. Round 3 cost about 7 credits per parent who heard the core message.

**Vendor evaluation.** I wrote an evaluation checklist for Gnani.ai so the same prompt could be run side by side on a second platform. Requests to VocalLabs included `ended_by` and `seconds_to_end` in the export, automatic callback scheduling, and voicemail detection (one answering machine was missed in teacher round 3).


## Results and measurement

The agents went from broken to reliable: technical breaks fell to about 5% of answered parent calls in round 2, within the 10% pass mark. The core message still reached only 15% to 25% of contacts, and the funnel shows why.

The full parent round 3 funnel is in [`claude-reports/2026-11-11_parent_round3_parent-v2.8.md`](../claude-reports/2026-11-11_parent_round3_parent-v2.8.md). Stage counts there were read from call summaries, so each is about ±2.

The biggest losses come before the explanation starts: 76 parents never answered, and 38 hung up during the opening line. That's what parent-v2.9 targets.

| Measure | Parents R1 (19 Oct) | Parents R2 (2 Nov, v2.4) | Parents R3 (11 Nov, v2.8) | Teachers R1 (19 Oct) | Teachers R3 (3 Nov, v2.2-opt) |
| --- | --- | --- | --- | --- | --- |
| Contacts (attempts) | 99 (99) | 100 (100) | 200 (285) | 100 (102) | 100 (100) |
| Calling time | Noon | 6:30 PM | 6:28 PM, retry about 1 h later | Noon | 5:05 PM |
| Answer rate | 69% | 73% | 62% (49.5% first attempt) | 61% | 50% |
| Ended within 10 s, of answered | 26% | 8% | 10% | 20% | 22% |
| Ended at 11 to 20 s, of answered | 3% | 15% | 24% | 13% | 18% |
| Listened through to the teach-back | not measured | 24 | 44 | not measured | 11 |
| Accurate teach-back | not measured | 0 of 24 | 0 of 44 | not measured | 2 of 11 |
| Agreed to act | not measured | 17 | 28 | not measured | 5 |
| Credits per answered call | 3.0 | 2.8 | 2.7 | 2.3 | 2.0 |

All figures are recomputed from the five VocalLabs exports. Teacher round 2 (1 to 2 Nov) is left out because it ran the parent agent. Round numbers follow the [CHANGELOG](../CHANGELOG.md). The listened-through counts come from the export's own field, so they run 1 below the summary-based counts in the round reports (25 and 45). Teacher round 3 also had 4 teachers who heard the RAPID SUMMARY only, which that field doesn't capture.

**The clearest win so far:** among answered parent calls, hang-ups in the first 10 s fell from 26% in round 1 to 8% in round 2. Two things changed at once, the opening and the move from noon to evening, so the drop can't be credited to either alone.

**Measurement framework.** I defined the measures before reading results, and logged any change to a definition so rounds stay comparable. Pass marks for each pilot: technical breaks under 10%, hang-ups in the first 10 s under 15%, teach-back recorded on over 90% of calls that reach it, and post-call fields correct in 19 of 20 audited calls.

**What these results don't show yet.** None of this measures weekly submissions. The planned test is a randomised comparison of WhatsApp only against WhatsApp plus a call, needing about 1,100 contacts per arm to detect a rise from 20% to 25%. For a portfolio, present the work as a rigorous design and measurement process with early results, not as a proven lift.

## Retrospective and iterations

The biggest lesson: the core message wasn't failing in the middle of the call. Most listeners were lost in the first 20 seconds or never answered, so the next version targets the opening, the length of the explanation, and what the teach-back asks.

**What each round taught**

| Round | Lesson | What changed next |
| --- | --- | --- |
| 3, parents (11 Nov) | "Automated call" in the first sentence plus the identity question lost 56 of 122 real people (46%) | v2.9 names the school first |
| 3, parents | 17 of 62 left during a 45-second unbroken explanation | Main block cut to about 20 s |
| 3, parents | 0 of 45 could name the child's three steps; parents said "the child will know" | Teach-back now asks what the parent will do |
| 3, teachers (3 Nov) | RAPID SUMMARY worked for busy teachers; silence and "एक minute" ended calls | Hold branch and teach-back silence fix for teacher round 4 (18 Nov) |
| Internal tests (3 Nov) | A question the bot couldn't answer ended the call | A closed list of reasons the call may end |
| 2, parents (1 to 2 Nov) | The parent agent also ran on the teacher list by mistake | Version and agent checked before every launch |
| 1, both (19 Oct) | Broken variables, noon calls, nothing measured; 26% of answered parents hung up within 10 s | Variable check, evening calls, post-call fields; that figure fell to 8% in round 2 |

**How the v2.9 hypotheses will be checked.** Each change is tied to one measure, so round 4 can confirm or reject it:

- New opening → drop-off at 11 to 20 s should fall from 24%.
- Shorter main block → fewer than 17 of 62 lost between the awareness question and the teach-back.
- New teach-back → accurate answers above 0%. This is a new definition, so it isn't comparable with rounds 2 and 3.

**What I'd do differently**

- Agree the measurement plan and export fields before the first call, not after. Round 3's missing fields cost a round of precise data.
- Run the full internal test suite before every live round. Calls 8 to 14, including opt-out and safety, weren't run before round 3.
- Change one thing per round where possible. v2.9 changes three, which makes it harder to say which one worked.
- Plan the randomised comparison early. Only WhatsApp-only versus WhatsApp-plus-call, at about 1,100 per arm, can show an effect on weekly submissions.

**Still open:** who follows up the "team will contact you" promises; whether teacher round 4 at 11 AM on 18 Nov reaches more teachers; and whether any of this moves the 20% submission rate.
