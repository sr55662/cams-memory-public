param(
  [Parameter(Mandatory=$true)][ValidateSet("publish","nextid")] [string]$Command,
  [string]$RunId,
  [string]$Topic,
  [string]$Objective,
  [string]$Assets,   # comma-separated filenames in outputs\<RunId>
  [string]$Notes,
  [string]$RepoDir = "$PSScriptRoot\..\cams-memory-public"
)
$ErrorActionPreference = "Stop"
$RepoDir = (Resolve-Path $RepoDir).Path
$pub = Join-Path $PSScriptRoot 'publish_cams_memory.ps1'
if (!(Test-Path $pub)) { throw "Missing publish_cams_memory.ps1 next to cams.ps1" }

function Get-NextRunId {
  $projIdx = Join-Path $RepoDir 'assistant-knowledge\indexes\projects.index.json'
  if (!(Test-Path $projIdx)) { return 'run_0001' }
  $json = Get-Content -Raw -LiteralPath $projIdx | ConvertFrom-Json
  $max = 0
  foreach ($it in $json.items) {
    if ($it.run_id -match '^run_(\d{4})$') {
      $n = [int]$Matches[1]
      if ($n -gt $max) { $max = $n }
    }
  }
  $next = '{0:d4}' -f ($max + 1)
  return "run_$next"
}

switch ($Command) {
  'nextid' {
    $id = Get-NextRunId
    Write-Output $id
    exit 0
  }
  'publish' {
    if (-not $RunId)   { throw "Missing -RunId" }
    if (-not $Topic)   { throw "Missing -Topic" }
    if (-not $Objective){ throw "Missing -Objective" }
    # Locate run source dir relative to memory repo sibling outputs
    $Root = Split-Path $RepoDir -Parent
    $RunSourceDir = Join-Path $Root ("outputs\{0}" -f $RunId)
    if (!(Test-Path $RunSourceDir)) { throw "Run source dir not found: $RunSourceDir" }

    $assetList = @()
    if ($Assets) {
      foreach ($a in $Assets.Split(',')) {
        $p = Join-Path $RunSourceDir ($a.Trim())
        if (!(Test-Path $p)) { throw "Asset not found: $p" }
        $assetList += $p
      }
    }

    & $pub `
      -RepoDir $RepoDir `
      -RunId $RunId `
      -RunSourceDir $RunSourceDir `
      -Owner 'shashank' `
      -Topic $Topic `
      -Objectives $Objective `
      -LessonNote $Notes
    exit $LASTEXITCODE
  }
}