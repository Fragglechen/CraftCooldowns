param()

$ErrorActionPreference = "Stop"

$root = Split-Path -Parent $PSScriptRoot
$releaseRoot = Join-Path $root "_release"
$releaseDir = Join-Path $releaseRoot "CraftCooldowns"
$zipPath = Join-Path $releaseRoot "CraftCooldowns-1.0.2.zip"

$tocPath = Join-Path $root "CraftCooldowns.toc"
if (-not (Test-Path $tocPath)) {
    throw "Missing CraftCooldowns.toc"
}

if (Test-Path $releaseDir) {
    Remove-Item -Recurse -Force $releaseDir
}

if (Test-Path $zipPath) {
    Remove-Item -Force $zipPath
}

New-Item -ItemType Directory -Force -Path $releaseDir | Out-Null

$includePaths = @(
    "CraftCooldowns.lua",
    "CraftCooldowns.toc",
    "LICENSE",
    "README.md",
    "CHANGELOG.md"
)

foreach ($relative in $includePaths) {
    $source = Join-Path $root $relative
    $target = Join-Path $releaseDir $relative

    if (-not (Test-Path $source)) {
        throw "Missing release path: $relative"
    }

    $targetParent = Split-Path -Parent $target
    if (-not (Test-Path $targetParent)) {
        New-Item -ItemType Directory -Force -Path $targetParent | Out-Null
    }

    Copy-Item -Force $source $target
}

Compress-Archive -Path $releaseDir -DestinationPath $zipPath -Force

Write-Host "Release prepared at: $releaseDir"
Write-Host "Zip created at: $zipPath"
