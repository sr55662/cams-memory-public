# CAMS Chat-Only Helpers (Quick Use)

## Append to lessons.jsonl (dedupe if jq is available)
```powershell
# jq available (preferred)
.\caps\tools\jsonl_append.ps1 -SourceJsonl ".\new_lessons.jsonl" -TargetJsonl ".\assistant-knowledge\lessons\global.jsonl" -Key ".title"

# fallback (no jq): safe append, dedupe later
.\caps\tools\jsonl_append.ps1 -SourceJsonl ".\new_lessons.jsonl" -TargetJsonl ".\assistant-knowledge\lessons\global.jsonl"
.\caps\tools\json_min_validate.ps1 -File ".\assistant-knowledge\projects\runs\run_XXXX\run.json" -RequireKeys run_id,topic,started_at
.\caps\tools\normalize_encoding.ps1 -Path . -LineEnding LF
git add .
git commit -m 'chore(cams): update lessons and run manifest'
git push