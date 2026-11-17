# <Agent> round <n> campaign report (<date>)

Save as `claude-reports/YYYY-MM-DD_<agent>_round<n>_<prompt-version>.md`.

**Source:** `<VocalLabs export file name>` (kept in `raw-exports/`, not committed)
**Agent:** <VocalLabs agent name>
**Prompt:** `<agent>-v<x.y>` (link to `prompts/<agent>/<agent>-v<x.y>.md`)
**Contacts:** <n> (<attempts> attempts)
**Timing:** <window>, concurrency <n>, retries <rule>
**Pre-launch checks:** agent and prompt version confirmed ☐ · variables heard correctly on a test call ☐ · post-call fields present in a test export ☐ · internal test calls run (list) ☐

## Hypotheses going in

Copy from the prompt's change table. One line per change, each tied to one measure.

| Change | Measure it should move | From | Goal |
| --- | --- | --- | --- |
| | | | |

## Results

| Measure | Last round | This round | Goal | Met? |
| --- | --- | --- | --- | --- |
| Answer rate (first attempt / with retries) | | | | |
| Ended within 10 s, of answered | | | | |
| Ended at 11 to 20 s, of answered | | | | |
| Core message heard | | | | |
| Accurate teach-back | | | | |
| Agreed to act | | | | |
| Technical breaks | | | under 10% | |
| Credits (per answered call / per core message) | | | | |

## Funnel

| Stage | Count | Lost here | Main reasons |
| --- | --- | --- | --- |
| Dialled | | | |
| Answered | | | |
| Past the opening | | | |
| Identity confirmed | | | |
| Heard the core message | | | |
| Reached the teach-back | | | |
| Agreed | | | |

## Hypotheses: confirmed or rejected?

| Change | Result | Verdict |
| --- | --- | --- |
| | | |

## Findings

1.

## Data and configuration issues

-

## Decisions for the next round

1.

## Who did what

- **Me:** prompt changes, test design, analysis, decisions.
- **Intern:** campaign setup, export shared in the agreed format.
- **Claude:** funnel counts and draft report from the export (checked by me).
