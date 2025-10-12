# CAMS Protocol — Chat-Based Ensemble

## Lifecycle Keywords (you paste these in chat)
- **request begin** / **request end**: wrap your initial ask & constraints
- **response begin** / **response end**: wrap partner LLM replies (one or many)
- **next round**: ask for refined partner prompts + follow-ups
- **task end**: finalize; assistant emits memory publish command (no extra info needed)

## Orchestrator (ChatGPT) Responsibilities
1) Produce first-pass answer (narrative, scenarios/recs, indicators, scripts).
2) Draft partner prompts (Claude/Gemini/Grok) — link-agnostic, testable.
3) Merge partner replies (envelope for numeric ranges; preserve dissent).
4) Emit **publish_cams_memory** one-liner with baked context (no external files needed).
5) Follow lessons: here-strings @'/\'@ at col 1; single-quoted commits; determinism for meta-merge.

## Expected Partner Return Format
- 150–200 word narrative (new insights only).
- Structured block (JSON or bullets) with scenarios/recs.
- 5–12 indicators/validation checks (with thresholds/rationale).
- Brief disagreements/risks where smart peers might disagree.

## Memory Index URLs (assistant will read on session start)
- Lessons index:  https://raw.githubusercontent.com/sr55662/cams-memory-public/main/assistant-knowledge/indexes/lessons.index.json
- Env index:      https://raw.githubusercontent.com/sr55662/cams-memory-public/main/assistant-knowledge/indexes/env.index.json
- Projects index: https://raw.githubusercontent.com/sr55662/cams-memory-public/main/assistant-knowledge/indexes/projects.index.json