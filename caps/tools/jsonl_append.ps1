param(
  [Parameter(Mandatory)][string]$SourceJsonl,     # new lines to append (json-per-line)
  [Parameter(Mandatory)][string]$TargetJsonl,     # destination jsonl file
  [string]$Key                                    # optional: unique key for dedupe (dot path)
)
$ErrorActionPreference = "Stop"
if (-not (Test-Path $TargetJsonl)) { New-Item -ItemType File -Force -Path $TargetJsonl | Out-Null }

# Try jq first for deterministic dedupe
$jqu = (Get-Command jq -ErrorAction SilentlyContinue)
if ($jqu) {
  # concat -> array -> unique by key (if provided) or whole objects -> back to jsonl
  $tmp = [System.IO.Path]::GetTempFileName()
  $tmp2 = [System.IO.Path]::GetTempFileName()
  Get-Content -Raw -LiteralPath $TargetJsonl | Out-File -Encoding utf8 $tmp
  Get-Content -Raw -LiteralPath $SourceJsonl  | Out-File -Encoding utf8 $tmp2
  if ($Key) {
    # -s reads both files as JSON streams; splitlines -> parse -> concat -> group by key -> unique -> write jsonl
    & $jqu.Path -sR "
      split(\"\n\") | map(select(length>0) | fromjson?) as \$t
      | input | split(\"\n\") | map(select(length>0) | fromjson?) as \$s
      | (\$t + \$s)
      | unique_by($Key)
      | .[]
    " $tmp $tmp2 | Out-File -Encoding utf8 $TargetJsonl
  } else {
    & $jqu.Path -sR "
      split(\"\n\") | map(select(length>0) | fromjson?) as \$t
      | input | split(\"\n\") | map(select(length>0) | fromjson?) as \$s
      | (\$t + \$s)
      | unique
      | .[]
    " $tmp $tmp2 | Out-File -Encoding utf8 $TargetJsonl
  }
  Remove-Item $tmp,$tmp2 -Force
  Write-Host "OK: jq dedupe complete -> $TargetJsonl"
  exit 0
}

# Pure PS fallback: append without full dedupe (best-effort)
Get-Content -LiteralPath $SourceJsonl | Add-Content -Encoding utf8 -LiteralPath $TargetJsonl
Write-Warning "jq not found: appended lines without deep dedupe. Run jq later for uniqueness."