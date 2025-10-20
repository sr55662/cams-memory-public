param(
  [Parameter(Mandatory)][string]$File,
  [string[]]$RequireKeys
)
$ErrorActionPreference = "Stop"
try {
  $json = Get-Content -Raw -LiteralPath $File | ConvertFrom-Json -ErrorAction Stop
} catch {
  Write-Error "Invalid JSON: $File"
  exit 2
}
if ($RequireKeys) {
  foreach ($k in $RequireKeys) {
    if (-not ($json.PSObject.Properties.Name -contains $k)) {
      Write-Error "Missing required key: $k"
      exit 3
    }
  }
}
Write-Host "OK: $File is well-formed JSON and required keys exist."