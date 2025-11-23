# Quick Start: Deploying SODA+ AI with Version Sync

## TL;DR - Deploy Now (Version 1.5.1)

The project is already configured for version **1.5.1**. Just deploy:

```powershell
cd "G:\SODA_PLUS_AI_PRE_PROD\SODA_PLUS_PACKAGE\Deploy\Scripts\Developer"

$password = ConvertTo-SecureString "YourPassword" -AsPlainText -Force
.\Full-Built.ps1 -CertificatePassword $password
```

**Expected Output:**
```
Version not specified - auto-detecting from SODA_PLUS_MAIN.csproj...
✓ Auto-detected version: 1.5.1

════════════════════════════════════════════════════════════
  🚀 SODA+ AI - Complete Deployment Pipeline
════════════════════════════════════════════════════════════

Version: 1.5.1
...

Deployed Files:
  📦 MSIX: SODA_PLUS_AI_1.5.1.msix
  🔧 Installer (BAT): Install-SODA_1.5.1.bat
  📜 Installer (PS1): SODA_Installer_1.5.1.ps1
  🌐 Download Page: download.html
  🔔 Version Manifest: version.json (auto-update)

Download URLs:
  https://sodaplusbeta.blob.core.windows.net/downloads/SODA_PLUS_AI_1.5.1.msix
  https://sodaplusbeta.blob.core.windows.net/downloads/Install-SODA_1.5.1.bat
  https://sodaplusbeta.blob.core.windows.net/downloads/SODA_Installer_1.5.1.ps1

Auto-Update:
  https://sodaplusbeta.blob.core.windows.net/downloads/version.json
  All users will be notified of this update on next launch
```

---

## What Changed?

### ✅ Version is now 1.5.1 (out of beta!)

**SODA_PLUS_MAIN.csproj:**
```xml
<VersionPrefix>1.5.1</VersionPrefix>
<InformationalVersion>1.5.1</InformationalVersion>
```

### ✅ Version auto-detection added

**Full-Built.ps1** now reads version from project file automatically!

### ✅ New helper script

**Update-Version.ps1** makes version changes easy:
```powershell
.\Update-Version.ps1 -Version "1.5.2"
```

---

## Next Release: How to Update Version

### For Next Beta (e.g., 1.6.0-beta):

```powershell
cd "G:\SODA_PLUS_AI_PRE_PROD\SODA_PLUS_PACKAGE\Deploy\Scripts\Developer"

# 1. Update version
.\Update-Version.ps1 -Version "1.6.0" -IncludeBetaSuffix

# 2. Deploy
$password = ConvertTo-SecureString "YourPassword" -AsPlainText -Force
.\Full-Built.ps1 -CertificatePassword $password
```

### For Next Stable Release (e.g., 1.5.2):

```powershell
cd "G:\SODA_PLUS_AI_PRE_PROD\SODA_PLUS_PACKAGE\Deploy\Scripts\Developer"

# 1. Update version
.\Update-Version.ps1 -Version "1.5.2"

# 2. Deploy
$password = ConvertTo-SecureString "YourPassword" -AsPlainText -Force
.\Full-Built.ps1 -CertificatePassword $password
```

---

## What Files Were Created/Modified?

### Modified:
1. ✅ **SODA_PLUS_MAIN.csproj** - Updated to v1.5.1 (no beta)
2. ✅ **Full-Built.ps1** - Added auto-detection

### New Files:
1. ✨ **Update-Version.ps1** - Helper to update version
2. ✨ **Upload-InstallerPS1.ps1** - Uploads PS1 installer (from previous fix)
3. ✨ **VERSION_SYNC_GUIDE.md** - Detailed documentation
4. ✨ **VERSION_SYNC_SUMMARY.md** - Summary of changes
5. ✨ **QUICK_START_VERSION_SYNC.md** - This file

---

## Current Version Status

| Component | Version | Location |
|-----------|---------|----------|
| Project | **1.5.1** | `SODA_PLUS_MAIN\SODA_PLUS_MAIN.csproj` |
| VersionPrefix | **1.5.1** | Same file |
| InformationalVersion | **1.5.1** | Same file (no `-beta`) |
| Assembly | 1.0.0.0 | Same file (stable, don't change) |

---

## Verification

After deployment, verify on Azure:
- https://sodaplusbeta.blob.core.windows.net/downloads/SODA_PLUS_AI_1.5.1.msix
- https://sodaplusbeta.blob.core.windows.net/downloads/Install-SODA_1.5.1.bat
- https://sodaplusbeta.blob.core.windows.net/downloads/SODA_Installer_1.5.1.ps1
- https://sodaplusbeta.blob.core.windows.net/downloads/download.html

---

## Troubleshooting

### "Version not specified" error?
Make sure you're in the right directory:
```powershell
cd "G:\SODA_PLUS_AI_PRE_PROD\SODA_PLUS_PACKAGE\Deploy\Scripts\Developer"
```

### Want to use a different version?
Either:
1. Update project file first: `.\Update-Version.ps1 -Version "X.Y.Z"`
2. Or override: `.\Full-Built.ps1 -Version "X.Y.Z" -CertificatePassword $password`

### Need more help?
See **VERSION_SYNC_GUIDE.md** for complete documentation.

---

## Summary of Improvements

✅ **Single source of truth** - Version in one place  
✅ **Auto-detection** - No manual version parameter needed  
✅ **Helper script** - Easy version updates  
✅ **PS1 upload fixed** - All three files uploaded  
✅ **Better docs** - Clear guides and examples  

**You're ready to deploy!** 🚀
