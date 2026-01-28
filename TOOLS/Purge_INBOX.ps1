[CmdletBinding()]
param(
  [int]$OlderThanHours = 24,
  [int]$KeepNewest = 3,
  [switch]$DryRun
)

Set-StrictMode -Version Latest
$ErrorActionPreference='Stop'

function Fail([string]$m){ throw "FAIL-CLOSED: $m" }

$repoRoot = Split-Path -Parent $PSScriptRoot
$inbox = Join-Path $repoRoot 'INBOX'
if(!(Test-Path $inbox)){ Fail "Missing INBOX at $inbox" }

$cutoff = (Get-Date).ToUniversalTime().AddHours(-1 * [Math]::Abs($OlderThanHours))

# Folder naming uses UTC prefix; also respect filesystem LastWriteTimeUtc as fallback.
$items = Get-ChildItem -LiteralPath $inbox -Directory | Sort-Object Name -Descending

# Keep newest N no matter what
$protected = $items | Select-Object -First ([Math]::Max(0,$KeepNewest))
$rest = $items | Select-Object -Skip ([Math]::Max(0,$KeepNewest))

# Delete only those older than cutoff by LastWriteTimeUtc OR by name prefix (best-effort)
$toDelete = @()
foreach($d in $rest){
  $isOld = $false
  if($d.LastWriteTimeUtc -lt $cutoff){ $isOld = $true }

  # If folder name begins with yyyymmddTHHMMSSZ__, parse it
  if(-not $isOld -and $d.Name -match '^(\d{8}T\d{6}Z)__'){
    try {
      $ts = [DateTime]::ParseExact($Matches[1], 'yyyyMMddTHHmmssZ', [Globalization.CultureInfo]::InvariantCulture, [Globalization.DateTimeStyles]::AssumeUniversal)
      if($ts -lt $cutoff){ $isOld = $true }
    } catch { }
  }

  if($isOld){ $toDelete += $d }
}

if($DryRun){
  "DRYRUN: cutoff_utc=$($cutoff.ToString('yyyyMMddTHHmmssZ')) keepNewest=$KeepNewest olderThanHours=$OlderThanHours"
  "DRYRUN: would delete:"
  if($toDelete.Count -eq 0){ "  (none)" } else { $toDelete | ForEach-Object { "  $($_.FullName)" } }
  return
}

foreach($d in $toDelete){
  Remove-Item -LiteralPath $d.FullName -Recurse -Force
}

"PURGE: deleted=$($toDelete.Count) cutoff_utc=$($cutoff.ToString('yyyyMMddTHHmmssZ')) keepNewest=$KeepNewest"
