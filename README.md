# CAMS Public Memory (No Secrets)

Start each ChatGPT session by pasting TWO URLs:
1) lessons.index.json
2) env.index.json
(optional) projects.index.json

This repo contains public, non-sensitive memory and environment descriptors for CAMS runs.

## Smoke test

1. Start a **new chat** and paste:
   - Lessons / Env / Projects index URLs (raw.githubusercontent.com)
   - The permanent CAMS prompt from `caps/templates/permanent_self_prompt.md`
2. If fetch fails, the chat will print a **PowerShell fallback**. Copy-paste and run it once, then paste the three printed JSON blobs back into chat.
3. Provide:
4. Iterate with `response begin … response end`, use `next round` to refine, and `task end` to emit the publish one-liner.rnrn## Smoke test

1. Start a **new chat** and paste:
   - Lessons / Env / Projects index URLs (raw.githubusercontent.com)
   - The permanent CAMS prompt from `caps/templates/permanent_self_prompt.md`
2. If fetch fails, the chat will print a **PowerShell fallback**. Copy-paste and run it once, then paste the three printed JSON blobs back into chat.
3. Provide:
4. Iterate with `response begin … response end`, use `next round` to refine, and `task end` to emit the publish one-liner.