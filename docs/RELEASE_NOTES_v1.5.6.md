# SODA+ AI - Release Notes v1.5.6

**Release Date:** November 22, 2025  
**Type:** Bug Fix Release  
**Download:** [https://sodaplusbeta.blob.core.windows.net/downloads/download.html](https://sodaplusbeta.blob.core.windows.net/downloads/download.html)

---

## 🐛 Critical Fix: Auto-Update Version Parsing

This release fixes a critical bug in the auto-update checker that prevented users from receiving update notifications.

### What Was Broken?

When the application's version string included a Git commit hash (e.g., `1.5.5+9398aa92a1f010aac7bd0a99b70ed5852dd505af`), the auto-update checker would crash with this error:

```
System.FormatException: The input string '4+9398aa92a1f010aac7bd0a99b70ed5852dd505af' was not in a correct format.
```

**Impact:** Users on versions with Git commit hashes never saw update notifications.

### What's Fixed?

✅ **Smart Version Cleaning**: The update checker now strips Git commit hashes and pre-release tags before comparing versions

✅ **Graceful Error Handling**: Uses `TryParse()` instead of `Parse()` to avoid crashes

✅ **Better Logging**: Shows exactly what version strings are being compared

### Supported Version Formats

The auto-update checker now correctly handles all these formats:

| Format | Example | Cleaned Version |
|--------|---------|----------------|
| **Simple** | `1.5.5` | `1.5.5` |
| **Pre-release** | `1.5.5-beta` | `1.5.5` |
| **Build metadata** | `1.5.5+9398aa92` | `1.5.5` |
| **Combined** | `1.5.5-beta+9398aa92` | `1.5.5` |

---

## 🔧 Technical Details

### New Helper Method: `CleanVersionString()`

```csharp
private static string CleanVersionString(string version)
{
    if (string.IsNullOrWhiteSpace(version))
        return "1.0.0";
    
    // Remove build metadata (everything after '+')
    var withoutBuildMetadata = version.Split('+')[0];
    
    // Remove pre-release suffix (everything after '-')
    var withoutPreRelease = withoutBuildMetadata.Split('-')[0];
    
    return withoutPreRelease;
}
```

### Version Comparison Flow

**Before (Broken):**
```
Version string: 1.5.5+9398aa92...
↓
Version.Parse("1.5.5+9398aa92...")
↓
💥 CRASH! Format exception
```

**After (Fixed):**
```
Version string: 1.5.5+9398aa92...
↓
CleanVersionString() → "1.5.5"
↓
Version.TryParse("1.5.5") → ✅ Success
↓
Compare versions → Show notification if newer
```

---

## 📊 Debug Logging Example

When you launch the app, you'll now see detailed version information in the debug output:

```
🔄 Checking for updates from: https://sodaplusbeta.blob.core.windows.net/downloads/version.json
📦 Latest version available: 1.5.6
📌 Raw current version string: 1.5.5+9398aa92a1f010aac7bd0a99b70ed5852dd505af
📌 Cleaned current version: 1.5.5
🆕 Cleaned latest version: 1.5.6
📌 Current version: 1.5.5+9398aa92... (comparing: 1.5.5)
🆕 Latest version: 1.5.6 (comparing: 1.5.6)
✅ New version available: 1.5.6
```

---

## 🎯 Who Should Update?

**Everyone!** Especially if:
- ✅ You've never seen an update notification
- ✅ Your app version includes a long alphanumeric string (Git hash)
- ✅ You want to ensure you get future update alerts

---

## 📥 Installation

### Option 1: Quick Install (Recommended)
1. **[📦 Download Latest Installer](https://sodaplusbeta.blob.core.windows.net/downloads/Install-SODA_Latest.bat)**
2. **Double-click** the downloaded `.bat` file
3. **Click "Install"** when prompted

### Option 2: MSIX Package (Advanced)
1. **[📦 Download MSIX Package](https://sodaplusbeta.blob.core.windows.net/downloads/SODA_PLUS_AI_Latest.msix)**
2. **Double-click** the `.msix` file
3. **Click "Install"** when Windows prompts

---

## 🔒 System Requirements

- **Operating System**: Windows 10 (version 1809+) or Windows 11
- **Architecture**: 64-bit (x64)
- **.NET**: .NET 10 Runtime (included in installer)
- **SQL Server**: SQL Server 2016+ or Azure SQL Database

---

## 🆕 What's Next?

After installing version 1.5.6, the auto-update checker will work correctly and notify you when version 1.5.7 (or higher) is available.

---

## 📝 Changelog Summary

### Fixed
- **Auto-Update Checker**: Version parsing now handles Git commit hashes
- **Error Handling**: Graceful failure instead of crashes
- **Logging**: Detailed debug output for version comparisons

### Improved
- **Version Comparison**: Semantic versioning support with build metadata
- **Code Quality**: Added helper methods for version sanitization

---

## 🐞 Known Issues

None at this time.

---

## 📞 Support

- **GitHub Issues**: [Report a Bug](https://github.com/jcboyer/SODA_PLUS_AI/issues)
- **GitHub Discussions**: [Ask Questions](https://github.com/jcboyer/SODA_PLUS_AI/discussions)
- **Documentation**: [User Guides](https://github.com/jcboyer/SODA_PLUS_AI/tree/main/docs)

---

## 📚 Related Documentation

- [CHANGELOG.md](https://github.com/jcboyer/SODA_PLUS_AI/blob/main/docs/CHANGELOG.md) - Complete version history
- [Quick Start Guide](https://github.com/jcboyer/SODA_PLUS_AI/blob/main/docs/SqlLens_Quick_Start_Guide.md) - Get started in 5 minutes
- [Full User Guide](https://github.com/jcboyer/SODA_PLUS_AI/blob/main/docs/SqlLens_User_Guide_Full.md) - Complete reference

---

**Version:** 1.5.6  
**Release Date:** November 22, 2025  
**Build:** Stable  
**Download:** [https://sodaplusbeta.blob.core.windows.net/downloads/download.html](https://sodaplusbeta.blob.core.windows.net/downloads/download.html)

---

**Thank you for using SODA+ AI!** 🎉

