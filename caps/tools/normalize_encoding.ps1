param([Parameter(Mandatory)][string]$Path, [ValidateSet("LF","CRLF")][string]$LineEnding="LF")
$ErrorActionPreference = "Stop"
$files = Get-ChildItem -Path $Path -Recurse -File
$nl = if ($LineEnding -eq "LF") { "`n" } else { "`r`n" }
foreach ($f in $files) {
  $raw = Get-Content -Raw -LiteralPath $f.FullName
  $norm = $raw -replace "`r`n|`r|`n", $nl
  [IO.File]::WriteAllText($f.FullName, $norm, (New-Object System.Text.UTF8Encoding($false)))
}
Write-Host "OK: Normalized $($files.Count) files under $Path to UTF-8(noBOM)/$LineEnding"