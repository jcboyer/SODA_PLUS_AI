#Requires -Version 7.0

<#
.SYNOPSIS
 Uninstall SODA+ AI from Windows
.DESCRIPTION
    Removes all versions of SODA+ AI MSIX packages
.EXAMPLE
    .\Uninstall-SODA.ps1
#>

$ErrorActionPreference = "Stop"

Write-Host ""
Write-Host "═══════════════════════════════════════════════════════════" -ForegroundColor Cyan
Write-Host "  🗑️  SODA+ AI Uninstaller" -ForegroundColor Cyan
Write-Host "═══════════════════════════════════════════════════════════" -ForegroundColor Cyan
Write-Host ""

# Find all SODA+ AI packages
$packages = Get-AppxPackage | Where-Object { 
    $_.Name -like "*sodaplusai*" -or 
    $_.Name -like "*SODA*" -or
    $_.Publisher -like "*jerom*"
}

if (-not $packages) {
    Write-Host "✅ SODA+ AI is not installed" -ForegroundColor Green
    Write-Host ""
    exit 0
}

Write-Host "Found $($packages.Count) package(s):" -ForegroundColor Yellow
Write-Host ""

foreach ($pkg in $packages) {
  Write-Host "  📦 $($pkg.Name)" -ForegroundColor White
    Write-Host "     Version: $($pkg.Version)" -ForegroundColor Gray
    Write-Host "Location: $($pkg.InstallLocation)" -ForegroundColor Gray
    Write-Host ""
}

# Confirm uninstall
$response = Read-Host "Uninstall all packages? (y/n)"

if ($response -ne 'y') {
    Write-Host ""
    Write-Host "❌ Uninstall cancelled" -ForegroundColor Yellow
    Write-Host ""
    exit 0
}

Write-Host ""
Write-Host "Uninstalling..." -ForegroundColor Yellow
Write-Host ""

$uninstalledCount = 0
$failedCount = 0

foreach ($pkg in $packages) {
    try {
 Write-Host "  Removing: $($pkg.Name)..." -ForegroundColor White
        Remove-AppxPackage -Package $pkg.PackageFullName -ErrorAction Stop
        Write-Host "  ✅ Removed successfully" -ForegroundColor Green
        $uninstalledCount++
    }
 catch {
Write-Host "  ❌ Failed: $($_.Exception.Message)" -ForegroundColor Red
 $failedCount++
    }
    Write-Host ""
}

# Summary
Write-Host "═══════════════════════════════════════════════════════════" -ForegroundColor Cyan
Write-Host "  Uninstall Complete" -ForegroundColor Cyan
Write-Host "═══════════════════════════════════════════════════════════" -ForegroundColor Cyan
Write-Host ""
Write-Host "Uninstalled: $uninstalledCount" -ForegroundColor Green
if ($failedCount -gt 0) {
    Write-Host "Failed:      $failedCount" -ForegroundColor Red
}
Write-Host ""

if ($uninstalledCount -gt 0) {
    Write-Host "✅ SODA+ AI has been removed from your system" -ForegroundColor Green
    Write-Host ""
}

# Optional: Clean up leftover files
Write-Host "Clean up leftover data? (y/n): " -NoNewline -ForegroundColor Yellow
$cleanResponse = Read-Host

if ($cleanResponse -eq 'y') {
    Write-Host ""
    Write-Host "Cleaning up..." -ForegroundColor Yellow
    
    # Common leftover locations
    $cleanupPaths = @(
     "$env:LOCALAPPDATA\Packages\*sodaplusai*",
     "$env:LOCALAPPDATA\MermaidRenderer",
        "$env:APPDATA\SODA_PLUS_AI"
    )
    
    foreach ($path in $cleanupPaths) {
        $items = Get-Item $path -ErrorAction SilentlyContinue
        if ($items) {
      foreach ($item in $items) {
            try {
          Write-Host "  Removing: $($item.FullName)" -ForegroundColor Gray
                  Remove-Item $item.FullName -Recurse -Force -ErrorAction Stop
       Write-Host "  ✅ Cleaned" -ForegroundColor Green
     }
                catch {
     Write-Host "  ⚠️  Could not remove: $($_.Exception.Message)" -ForegroundColor Yellow
  }
    }
 }
    }
    
    Write-Host ""
    Write-Host "✅ Cleanup complete" -ForegroundColor Green
}

Write-Host ""
