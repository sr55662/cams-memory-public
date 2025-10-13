# CAMS CAPS Bundle

This folder contains everything needed to run CAMS chat-based ensemble sessions across new chats:

- Protocol (CAMS loop): `response begin … response end`, `next round`, `task end`
- Self Bootstrap Prompt (for ChatGPT Orchestrator)
- Partner Prompt Template (for Claude/Gemini/Grok)
- Next-Round Prompt
- Publish One-Liner Template

## Start a new CAMS run (every time)

1) Paste these three index URLs at the top of the chat so the model preloads memory:
   - Lessons:  https://raw.githubusercontent.com/sr55662/cams-memory-public/main/assistant-knowledge/indexes/lessons.index.json
   - Env:      https://raw.githubusercontent.com/sr55662/cams-memory-public/main/assistant-knowledge/indexes/env.index.json
   - Projects: https://raw.githubusercontent.com/sr55662/cams-memory-public/main/assistant-knowledge/indexes/projects.index.json

2) Paste the Self Bootstrap Prompt (or link): https://raw.githubusercontent.com/sr55662/cams-memory-public/main/caps/templates/self_bootstrap_prompt.md

3) Paste the Partner Prompt to each collaborator: https://raw.githubusercontent.com/sr55662/cams-memory-public/main/caps/templates/partner_prompt_template.md

4) Paste partner replies verbatim between:
   response begin
   ... partner text ...
   response end
   ChatGPT will synthesize after each `response end`.

5) Say `next round` to iterate; ChatGPT may emit improved partner prompts automatically.

6) Say `task end` when satisfied. ChatGPT will:
   - Post a final report in chat
   - Emit a ready-to-run publish one-liner to update public memory with total context