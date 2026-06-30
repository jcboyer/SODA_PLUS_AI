# SODA+ AI - Release Notes (Version 1.2.0-beta)

---

## Version 1.2.0-beta - November 2025 ⭐ **CURRENT RELEASE**

### 🌟 **Major New Features**

#### **AI-Assisted Self-Learning Chart Error Correction** 🚀 **BREAKTHROUGH FEATURE!**

SODA+ AI now automatically detects and fixes Mermaid chart rendering errors using AI. When a chart fails to render, the system:

- ✅ **Analyzes the error** using Grok AI
- ✅ **Applies the fix automatically** - no user intervention required
- ✅ **Stores the fix pattern** for future use
- ✅ **Shares knowledge across all users** (anonymized)

**Result:** Charts get easier to generate over time, with most errors fixed instantly using learned patterns!

**Privacy:** Only anonymized syntax patterns are stored - never your database object names or sensitive data.

**How It Works:**
1. **First Error**: AI analyzes (~15 seconds) → Fixes → Stores pattern
2. **Same Error Again**: Applies known fix instantly (< 1 second)
3. **System Learns**: Pattern database grows with each unique error
4. **Community Benefit**: All users benefit from fixes discovered by any user

**Expected Growth:**
- Week 1: ~10 patterns stored
- Month 1: ~15-20 patterns covering 95% of common errors
- Month 6: ~25-30 patterns covering 99% of errors

---

### 📊 **Chart Generation Enhancements**

#### **Views Now Fully Supported for Charting** ⭐ **NEW!**

All three chart types now work with Views (previously Procedures/Functions only):

- **Quick Chart** - Instant dependency visualization for Views
- **AI-Enhanced Chart** - Optimized layouts for complex multi-table JOINs
- **Logic Flowchart** - Visualize CASE statements and conditional logic in Views

**Why Chart Views?**
- Visualize table relationships and JOIN patterns
- Understand complex view dependencies
- Impact analysis before schema changes
- Performance tuning by identifying missing indexes

---

### 🔧 **Technical Improvements**

#### **Database Integration**

- **New Table: `MermaidRenderingFixes`** - Stores learned fix patterns
- **Azure Functions Deployed**:
  - `GET /api/chart/get-fixes` - Retrieve active fix patterns
  - `POST /api/chart/store-fix` - Store new AI-discovered fixes
  - `POST /api/chart/report-fix-failure` - Track fix effectiveness

#### **Enhanced Error Detection**

- **SVG Content Validation** - Detects errors even when renderer returns success
- **Automatic Retry Logic** - Applies fixes and re-renders automatically
- **Detailed Error Logging** - Better debugging with comprehensive logs

---

### 🐛 **Bug Fixes**

- ✅ Fixed: Chart options greyed out for Views (now fully enabled)
- ✅ Fixed: SVG rendering errors not detected when exit code = 0
- ✅ Fixed: Special characters in Mermaid labels causing parse errors
- ✅ Fixed: Square brackets `[` `]` in node labels triggering syntax errors
- ✅ Fixed: JSON serialization issues in Azure Functions
- ✅ Fixed: Authorization level causing 401 errors (chart endpoints)

---

### 📚 **Documentation Updates**

- **User Guide Enhanced** - New section on Self-Learning Error Correction
- **Step 10 Updated** - Comprehensive charting documentation with Views support
- **Privacy Information** - Clear explanation of data anonymization
- **Troubleshooting Guide** - Common chart error solutions

---

## Version 1.0.0-beta - October 2025

### 🌟 **Initial Beta Release Features**

- Enhanced dependency analysis with drill-down
- Improved AI-powered code review
- Interactive dependency charting
- Cloud-based API key management

---

## Installation

### Requirements

- **Windows 10/11 (x64)** - 64-bit Windows required
- **No .NET Installation Required** - Self-contained deployment
- **WebView2 Runtime** - For Formatted View tab (auto-installed on Windows 11)
- **Internet Connection** - For AI features and Azure Functions

### Installation Steps

1. **Download** the latest release ZIP from GitHub
2. **Extract** to a folder (e.g., `C:\Program Files\SODA_PLUS_AI`)
3. **Run** `SODA_PLUS_MAIN.exe`
4. **Register/Login** with your email on first launch
5. **Select Environment** (SANDBOX/TEST/PROD)
6. **Add Server** and start analyzing!

---

## Upgrade Notes

### From 1.0.0-beta to 1.1.0-beta

**Database Changes:**
- New table: `MermaidRenderingFixes` (auto-created by Azure Functions)
- No migration required for existing users

**Azure Functions:**
- New endpoints deployed (chart fix functions)
- Existing endpoints unchanged

**Features:**
- Chart Views now fully enabled (no action needed)
- Self-learning system activates automatically
- Existing charts remain compatible

---

## Support

- **GitHub Repository**: https://github.com/jcboyer/SODA_PLUS_AI_ReleasedBeta
- **GitHub Issues**: Report bugs and request features
- **Documentation**: Comprehensive User Guide included

---

**Last Updated:** October 26, 2025  
**Current Version:** 1.2.0-beta  
**Status:** Beta Testing  

**Thank you for being part of the SODA+ AI beta program!** 🎉
