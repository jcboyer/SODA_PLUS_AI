# Version Synchronization System

## Overview
The deployment system now automatically synchronizes versions between the project file (`SODA_PLUS_MAIN.csproj`) and the deployment scripts. You only need to manage the version in **one place**: the `.csproj` file.

## Version Properties in SODA_PLUS_MAIN.csproj

```xml
<!-- ===== VERSIONING CONFIGURATION ===== -->
<!-- Main version components (manual control) -->
<VersionPrefix>1.5.1</VersionPrefix>

<!-- Stable assembly version for runtime compatibility -->
<AssemblyVersion>1.0.0.0</AssemblyVersion>

<!-- File version uses VersionPrefix + auto-calculated suffix -->
<FileVersion>$(VersionPrefix).$([System.DateTime]::Now.ToString('yyMM')).$([System.DateTime]::Now.ToString('ddHH'))</FileVersion>

<!-- Marketing/display version -->
<InformationalVersion>1.5.1</InformationalVersion>
```

### What Each Property Does

1. **VersionPrefix** (`1.5.1`)
   - Base version number
   - Used for file version calculation
   - Format: `Major.Minor.Patch`

2. **AssemblyVersion** (`1.0.0.0`)
   - **Keep this stable** (1.0.0.0) for runtime compatibility
   - Changing this breaks compatibility with existing plugins

3. **FileVersion** (auto-calculated)
   - Calculated as: `VersionPrefix.YYMM.DDHH`
   - Example: `1.5.1.2511.1110` (built Nov 2025, 11am)
   - Used for file properties in Windows Explorer

4. **InformationalVersion** (`1.5.1` or `1.5.1-beta`)
   - **This is what deployment uses**
   - Marketing/display version shown to users
   - Can include suffixes like `-beta`, `-rc1`, etc.

## Workflow Options

### Option 1: Auto-Detect Version (Recommended)

**1. Update version in project file:**
```powershell
.\Update-Version.ps1 -Version "1.5.2"
```

**2. Deploy (version auto-detected):**
```powershell
$password = ConvertTo-SecureString "YourPassword" -AsPlainText -Force
.\Full-Built.ps1 -CertificatePassword $password
```

Output:
```
Version not specified - auto-detecting from SODA_PLUS_MAIN.csproj...
✓ Auto-detected version: 1.5.2
```

### Option 2: Manual Version Override

**Deploy with explicit version:**
```powershell
$password = ConvertTo-SecureString "YourPassword" -AsPlainText -Force
.\Full-Built.ps1 -Version "1.5.2" -CertificatePassword $password
```

> ⚠️ **Warning:** This doesn't update the `.csproj` file. Use Option 1 to keep everything in sync.

## Update-Version.ps1 Script

### Purpose
Updates both `VersionPrefix` and `InformationalVersion` in `SODA_PLUS_MAIN.csproj`.

### Usage

**Release version (no beta):**
```powershell
.\Update-Version.ps1 -Version "1.5.2"
```

**Beta version:**
```powershell
.\Update-Version.ps1 -Version "1.6.0" -IncludeBetaSuffix
```

### What It Updates

| Property | Before | After (Release) | After (Beta) |
|----------|--------|----------------|--------------|
| VersionPrefix | 1.5.1 | 1.5.2 | 1.6.0 |
| InformationalVersion | 1.5.1 | 1.5.2 | 1.6.0-beta |

## Full-Built.ps1 Enhancements

### Changes Made

1. **Version parameter is now optional**
   ```powershell
   [Parameter(Mandatory=$false)]
   [string]$Version
   ```

2. **Auto-detection logic added**
   - Reads `InformationalVersion` from `.csproj`
   - Falls back to `VersionPrefix` if needed
   - Shows clear message about detected version

3. **Updated help documentation**
   - Examples show both auto-detect and manual modes
   - Explains version synchronization

## Version Flow Diagram

```
┌─────────────────────────────────────────────┐
│ SODA_PLUS_MAIN.csproj                       │
│                                             │
│ <VersionPrefix>1.5.1</VersionPrefix>        │
│ <InformationalVersion>1.5.1</InformationalVersion>
└─────────────────────┬───────────────────────┘
                      │
                      │ Auto-detected by
                      ↓
┌─────────────────────────────────────────────┐
│ Full-Built.ps1                              │
│                                             │
│ Version: 1.5.1 (auto-detected)              │
└─────────────────────┬───────────────────────┘
                      │
                      │ Creates
                      ↓
┌─────────────────────────────────────────────┐
│ Deployment Artifacts                        │
│                                             │
│ • SODA_PLUS_AI_1.5.1.msix                   │
│ • Install-SODA_1.5.1.bat                    │
│ • SODA_Installer_1.5.1.ps1                  │
└─────────────────────────────────────────────┘
```

## Common Workflows

### Releasing a New Beta Version

```powershell
# 1. Update version
.\Update-Version.ps1 -Version "1.6.0" -IncludeBetaSuffix

# 2. Deploy
$password = ConvertTo-SecureString "YourPassword" -AsPlainText -Force
.\Full-Built.ps1 -CertificatePassword $password
```

**Result:**
- Project: `1.6.0-beta`
- MSIX: `SODA_PLUS_AI_1.6.0-beta.msix`
- Installers: `Install-SODA_1.6.0-beta.bat`, `SODA_Installer_1.6.0-beta.ps1`

### Releasing a Stable Version

```powershell
# 1. Update version (no beta)
.\Update-Version.ps1 -Version "1.5.2"

# 2. Deploy
$password = ConvertTo-SecureString "YourPassword" -AsPlainText -Force
.\Full-Built.ps1 -CertificatePassword $password
```

**Result:**
- Project: `1.5.2`
- MSIX: `SODA_PLUS_AI_1.5.2.msix`
- Installers: `Install-SODA_1.5.2.bat`, `SODA_Installer_1.5.2.ps1`

### Patch Release (Quick Fix)

```powershell
# 1. Update version
.\Update-Version.ps1 -Version "1.5.3"

# 2. Deploy
$password = ConvertTo-SecureString "YourPassword" -AsPlainText -Force
.\Full-Built.ps1 -CertificatePassword $password
```

## Best Practices

### ✅ DO:
- Use `Update-Version.ps1` to change versions
- Let `Full-Built.ps1` auto-detect the version
- Keep `InformationalVersion` in sync with `VersionPrefix`
- Use semantic versioning (Major.Minor.Patch)
- Add `-beta` suffix for pre-release versions

### ❌ DON'T:
- Manually edit `InformationalVersion` in `.csproj` (use the script)
- Change `AssemblyVersion` (keep it at 1.0.0.0)
- Use version suffixes other than `-beta` without testing
- Deploy with manual `-Version` parameter (breaks sync)

## Troubleshooting

### Version Mismatch Warning

**Problem:**
```
⚠️ Version mismatch detected!
  Project: 1.5.1
  Deployment: 1.5.2
```

**Solution:**
Run `Update-Version.ps1` to synchronize:
```powershell
.\Update-Version.ps1 -Version "1.5.2"
```

### Auto-Detection Failed

**Problem:**
```
❌ Could not detect version from project file
```

**Solutions:**
1. Check that `SODA_PLUS_MAIN.csproj` exists
2. Verify `InformationalVersion` or `VersionPrefix` is set
3. Use manual version as fallback:
   ```powershell
   .\Full-Built.ps1 -Version "1.5.1" -CertificatePassword $password
   ```

## Migration Notes

### Upgrading from Manual Versions

If you've been manually specifying versions in `Full-Built.ps1`:

**Old way:**
```powershell
.\Full-Built.ps1 -Version "1.5.0-beta" -CertificatePassword $password
```

**New way (recommended):**
```powershell
# First time: Update project file
.\Update-Version.ps1 -Version "1.5.0" -IncludeBetaSuffix

# Then: Auto-detect going forward
.\Full-Built.ps1 -CertificatePassword $password
```

## Files Modified

1. **SODA_PLUS_MAIN\SODA_PLUS_MAIN.csproj**
   - Updated `VersionPrefix`: 1.5.0 → 1.5.1
   - Updated `InformationalVersion`: 1.5.0-beta → 1.5.1

2. **Deploy\Scripts\Developer\Full-Built.ps1**
   - Made `-Version` parameter optional
   - Added auto-detection from `.csproj`
   - Updated help documentation

3. **Deploy\Scripts\Developer\Update-Version.ps1** ✨ NEW
   - Helper script to update versions
   - Keeps `VersionPrefix` and `InformationalVersion` in sync

## Quick Reference

| Task | Command |
|------|---------|
| Update version (release) | `.\Update-Version.ps1 -Version "1.5.2"` |
| Update version (beta) | `.\Update-Version.ps1 -Version "1.6.0" -IncludeBetaSuffix` |
| Deploy (auto-detect) | `.\Full-Built.ps1 -CertificatePassword $password` |
| Deploy (manual version) | `.\Full-Built.ps1 -Version "1.5.2" -CertificatePassword $password` |
| Check current version | Open `SODA_PLUS_MAIN\SODA_PLUS_MAIN.csproj` and look for `InformationalVersion` |

