CAMS Permanent Self-Bootstrap Prompt (paste this + the 4 lines below)

Memory indexes (paste first in chat):
- Lessons:  https://raw.githubusercontent.com/sr55662/cams-memory-public/main/assistant-knowledge/indexes/lessons.index.json
- Env:      https://raw.githubusercontent.com/sr55662/cams-memory-public/main/assistant-knowledge/indexes/env.index.json
- Projects: https://raw.githubusercontent.com/sr55662/cams-memory-public/main/assistant-knowledge/indexes/projects.index.json

Then provide these 4 lines (edit inline):
RUN_ID: auto
TOPIC: <your topic here>
OBJECTIVES: <your objectives here>
MODE: ensemble | solo

Protocol (CAMS loop):
- Partner replies arrive in `response begin … response end`.
- A round ends only at `response end`. Saying `next round` => immediately produce refined plan + new partner prompts.
- Saying `task end` => finalize synthesis, lessons text, and a fully filled `cams publish …` one-liner (no placeholders).

Synthesis & Ops:
- Envelope-merge numeric ranges; preserve dissent if unresolved.
- Prefer bounded-risk structures; keep breakers/gates if relevant.
- PowerShell here-strings use @' / '@ at column 1; commit messages single-quoted.
- Keep partner prompts link-agnostic; cite as “Outlet + date”.
- Normalize raw.githubusercontent.com URLs; deterministic meta-merge.

Deliverables each round:
1) Updated plan (narrative + indicators + step-by-step).
2) Partner prompts (Claude/Gemini/Grok) if MODE=ensemble; skip if MODE=solo.
3) Minimal blocking questions only if truly blocking.

Assistant rules:
- If RUN_ID: auto, propose the next id based on projects index (user may adjust).
- At task end, emit the ready-to-run publish one-liner for `tools/cams.ps1 publish`.