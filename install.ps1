# Installs the `spifetch` command on Windows for the current user (no admin needed).
#   irm https://raw.githubusercontent.com/snova5/spifetch/main/install.ps1 | iex
$ErrorActionPreference = "Stop"

$Url  = "https://raw.githubusercontent.com/snova5/spifetch/main/spifetch"
$Home_ = Join-Path $env:LOCALAPPDATA "spifetch"
$Bin  = Join-Path $Home_ "bin"
New-Item -ItemType Directory -Force -Path $Bin | Out-Null

# 1. find a real Python 3 (the Microsoft Store "python" stub doesn't count)
$Py = $null
foreach ($cand in @("py -3", "python", "python3")) {
    $exe, $arg = $cand.Split(" ", 2)
    if (Get-Command $exe -ErrorAction SilentlyContinue) {
        try {
            $v = if ($arg) { & $exe $arg -c "import sys;print(sys.version_info[0])" 2>$null } else { & $exe -c "import sys;print(sys.version_info[0])" 2>$null }
            if ($v -eq "3") { $Py = $cand; break }
        } catch {}
    }
}
if (-not $Py) {
    Write-Host "spifetch needs Python 3. Install it with:  winget install Python.Python.3.13" -ForegroundColor Yellow
    return
}

# 2. get the script (from this folder if run from a clone, otherwise download it)
$Local = if ($PSScriptRoot) { Join-Path $PSScriptRoot "spifetch" } else { "" }
$Target = Join-Path $Home_ "spifetch.py"
if ($Local -and (Test-Path $Local)) { Copy-Item $Local $Target -Force }
else { Invoke-WebRequest -UseBasicParsing $Url -OutFile $Target }

# 3. a small launcher so you can just type `spifetch`
"@echo off`r`n$Py `"$Target`" %*`r`n" | Set-Content -Encoding ASCII (Join-Path $Bin "spifetch.cmd")

# 4. add the launcher folder to the user PATH (once)
$UserPath = [Environment]::GetEnvironmentVariable("Path", "User")
if (($UserPath -split ";") -notcontains $Bin) {
    [Environment]::SetEnvironmentVariable("Path", ($UserPath.TrimEnd(";") + ";" + $Bin).TrimStart(";"), "User")
}
$env:Path = "$env:Path;$Bin"

if (-not (Get-Command fastfetch -ErrorAction SilentlyContinue)) {
    Write-Host "Tip: for distro logos also run:  winget install fastfetch" -ForegroundColor DarkGray
}
Write-Host "Installed! Run: spifetch   (open a new terminal if it's not found)" -ForegroundColor Cyan
