<# Installer de 1 comando do agent-config central.
Uso: ..\agent-config\scripts\install-agent.ps1 -Source ..\agent-config -Target . -Ide all [-Force]
Ide: opencode | vscode | all. -Force sobrescreve arquivos existentes. #>
param(
  [string]$Source = "..\agent-config",
  [string]$Target = ".",
  [ValidateSet("opencode", "vscode", "all")][string]$Ide = "all",
  [switch]$Force
)

$ErrorActionPreference = "Stop"
function Hash($p) { (Get-FileHash -Path $p -Algorithm SHA256).Hash.ToLower() }
function Check($manifest) {
  $m = Get-Content (Join-Path $Source $manifest) -Raw | ConvertFrom-Json
  foreach ($name in $m.assets.PSObject.Properties.Name) {
    $a = $m.assets.$name
    $actual = Hash (Join-Path $Source $a.path)
    if ($actual -ne $a.computedHash.ToLower()) { throw ("hash divergente em " + $a.path) }
  }
}
function CopyAsset($from, $to) {
  if ((Test-Path $to) -and (-not $Force)) { Write-Output ("skip (existe): " + $to); return }
  New-Item -ItemType Directory -Force -Path (Split-Path $to) | Out-Null
  Copy-Item $from $to -Force
  Write-Output ("ok: " + $to)
}

$Source = (Resolve-Path $Source).Path
$Target = (Resolve-Path $Target).Path

Check "manifests/commands.json"
Check "manifests/prompts.json"
Check "manifests/agents.json"
Check "manifests/mcp.json"
Write-Output "manifests: hashes OK"

if ($Ide -in @("opencode", "all")) {
  foreach ($f in Get-ChildItem (Join-Path $Source "commands") -Filter *.md) {
    CopyAsset $f.FullName (Join-Path $Target (".opencode/commands/" + $f.Name))
  }
}
if ($Ide -in @("vscode", "all")) {
  foreach ($f in Get-ChildItem (Join-Path $Source "prompts") -Filter *.prompt.md) {
    CopyAsset $f.FullName (Join-Path $Target (".github/prompts/" + $f.Name))
  }
  CopyAsset (Join-Path $Source "mcp/base.vscode.json") (Join-Path $Target ".vscode/mcp.json")
}

if ($Ide -in @("opencode", "all")) {
  $oj = Join-Path $Target "opencode.json"
  $base = Get-Content (Join-Path $Source "mcp/base.opencode.json") -Raw | ConvertFrom-Json
  $agents = Get-Content (Join-Path $Source "manifests/agents.json") -Raw | ConvertFrom-Json
  if (Test-Path $oj) { $cfg = Get-Content $oj -Raw | ConvertFrom-Json }
  else { $cfg = [pscustomobject]@{ '$schema' = "https://opencode.ai/config.json" } }
  if (-not $cfg.mcp) { $cfg | Add-Member -NotePropertyName "mcp" -NotePropertyValue ([pscustomobject]@{}) }
  if (-not $cfg.permission) { $cfg | Add-Member -NotePropertyName "permission" -NotePropertyValue ([pscustomobject]@{}) }
  if (-not $cfg.agent) { $cfg | Add-Member -NotePropertyName "agent" -NotePropertyValue ([pscustomobject]@{}) }
  foreach ($p in $base.mcp.PSObject.Properties) {
    if ((-not ($cfg.mcp.PSObject.Properties.Name -contains $p.Name)) -or $Force) {
      $cfg.mcp | Add-Member -NotePropertyName $p.Name -NotePropertyValue $p.Value -Force
    }
  }
  foreach ($p in $base.permission.PSObject.Properties) {
    if ((-not ($cfg.permission.PSObject.Properties.Name -contains $p.Name)) -or $Force) {
      $cfg.permission | Add-Member -NotePropertyName $p.Name -NotePropertyValue $p.Value -Force
    }
  }
  foreach ($name in $agents.assets.PSObject.Properties.Name) {
    $agentName = $name -replace "\.md$",""
    if ((-not ($cfg.agent.PSObject.Properties.Name -contains $agentName)) -or $Force) {
      $def = Get-Content (Join-Path $Source $agents.assets.$name.path) -Raw
      $desc = ""
      if ($def -match "description:\s*(.+)") { $desc = $Matches[1].Trim() }
      $entry = [pscustomobject]@{ description = $desc; mode = "subagent"; note = ("ver agents/" + $name + " no central") }
      $cfg.agent | Add-Member -NotePropertyName $agentName -NotePropertyValue $entry -Force
    }
  }
  $cfg | ConvertTo-Json -Depth 10 | Set-Content $oj -Encoding UTF8
  Write-Output ("ok: " + $oj + " (mesclado; instructions do projeto preservadas)")
}

foreach ($v in @("CONTEXT7_API_KEY", "RESEND_API_KEY", "CLOUDFLARE_API_TOKEN", "BREVO_MCP_TOKEN")) {
  $val = [Environment]::GetEnvironmentVariable($v, "User")
  if ([string]::IsNullOrEmpty($val)) { Write-Output ("env ausente (ok se MCP segue disabled): " + $v) }
  else { Write-Output ("env ok: " + $v) }
}
Write-Output ("concluido em " + $Target)
