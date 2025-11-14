# CHANGELOG

All notable changes to SODA+ AI will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

---

## [Unreleased]

### To Be Added
- Token counting for accurate cost tracking
- Multi-session support for premium users
- Offline AI response caching
- Batch chart generation
- Custom fix pattern management

---

## [1.5.1] - 2025-11-13

### Added
- **Version-Neutral Public Documentation** - Public site now always points to latest release
  - Dynamic version badge using version.json from Azure Blob Storage
  - Version-neutral download links (Install-SODA_Latest.bat, SODA_PLUS_AI_Latest.msix)
  - Automatic version detection from blob storage metadata
- **YouTube Demo Integration** - Public README now includes demo video
  - 2-minute walkthrough video embedded
  - Visual introduction for new users
  - Direct link to YouTube demo (ecZOFDrbr9I)
- **Enhanced Documentation Structure** - Reorganized public documentation
  - Time estimates for each guide (5 min, 30 min, 2-3 hrs)
  - Clear navigation with guide comparison table
  - "Which Guide Should I Use?" decision helper
  - Documentation index (docs/README.md)
- **RELEASE_HISTORY.md** - Version tracking with download links
  - Chronological version history
  - Direct download links for each version (latest + archive)
  - Release notes links
  - Automatic cleanup (keeps last 5 versions)
- **Security & Privacy Section** - Public README transparency
  - Explicit privacy guarantees
  - Security disclosure process
  - No data collection without consent statement
- **Improved Screenshot Paths** - Fixed broken image links
  - Changed from `SODA_PLUS_MAIN/Resources/Screenshots/` to `docs/screenshots/`
  - All screenshots now display correctly on GitHub

### Changed
- **Public Site README** - Complete rewrite for better user experience
  - Shifted from technical/developer focus to user-focused content
  - Simplified installation instructions
  - Better feature categorization
  - Clearer call-to-action for downloads
- **Sync-PublicRepo.ps1** - Completed missing sections
  - Added [3/9] Copy User Guides section
  - Added [4/9] Copy Screenshots section
  - Added [5/9] Copy Developer Documentation section
  - Added [6/9] Copy CHANGELOG.md section
  - Added [7/9] Copy Release Notes section
  - Added [8/9] Update Public RELEASE_NOTES.md section
  - Fixed missing closing brace causing parser errors
  - All 9 phases now functional
- **Badge Strategy** - Dynamic vs. static badges
  - Version badge: Dynamic (pulls from version.json)
  - Download badge: Static but version-neutral
  - Platform badge: Static (Windows 10/11 x64)

### Fixed
- **Sync-PublicRepo.ps1 Parser Error** - Script now parses correctly
  - Added missing closing brace for final if (-not $DryRun) block
  - All sections properly closed
  - Script executes successfully end-to-end
- **Git Merge Conflicts** - Resolved public repo conflicts
  - LICENSE file conflict resolved (removed old LICENSE, kept LICENSE.md)
  - README.md merge conflict resolved (accepted incoming changes)
  - RELEASE_NOTES.md conflict resolved
  - Successfully pushed to GitHub (commit 17f95f5)
- **Public Repo Path Detection** - Script now finds correct public repo
  - Updated path from `C:\Git\SODA_PLUS_AI` to `G:\SODA_PLUS_AI_Public`
  - Automatic path validation in Sync-PublicRepo.ps1

### Security
- **Content Sanitization** - Sync-PublicRepo.ps1 security checks
  - Azure AccountKey redaction
  - API keys and Bearer tokens redaction
  - Database passwords and connection strings redaction
  - SAS tokens on blob storage URLs redaction
  - Azure Function keys redaction
  - Automatic sanitization of all copied documentation

### Technical
- **Documentation Deployment Workflow**
  - Single command: `.\Sync-PublicRepo.ps1 -Version "1.5.1" -PublicRepoPath "G:\SODA_PLUS_AI_Public"`
  - Automated git commit and push
  - Version-neutral content replacement
  - Badge URL updates
  - Screenshot path corrections
- **Version Management**
  - version.json format: `{"version":"1.5.1","releaseDate":"2025-01-31",...}`
  - Dynamic badge URL: `https://img.shields.io/badge/dynamic/json?url=...version.json`
  - Archive URLs for historical versions
- **Build Artifact Locations**
  - Latest MSIX: `https://sodaplusbeta.blob.core.windows.net/downloads/SODA_PLUS_AI_Latest.msix`
  - Latest Installer: `https://sodaplusbeta.blob.core.windows.net/downloads/Install-SODA_Latest.bat`
  - Archive: `https://sodaplusbeta.blob.core.windows.net/downloads/archive/SODA_PLUS_AI_1.5.1.msix`

---

## [1.5.0-beta] - 2025-11-01

### Added
- **Two-Stage Installer System** - Improved installation reliability
  - BAT wrapper downloads PowerShell installer script (Base64-encoded for portability)
  - PowerShell installer handles MSIX download and certificate installation
  - Eliminates browser caching issues with single-file downloads
  - Self-contained - no external dependencies required
- **Beta Tester Cleanup Tools** - Full-Clean.ps1 script for testing fresh installations
  - Automated uninstallation of SODA+ AI packages
  - Certificate removal (ThoughtsInMotion)
  - Optional cleanup of leftover data files
  - Updated paths to match new runtime locations (Temp folder structure)
- **Professional Download Page** - Enhanced user experience
  - Embedded logo (Base64-encoded)
  - Dynamic installer filename placeholders
  - Beta tester tools section with cleanup script download
  - Clear SmartScreen warning instructions
- **Deployment Automation** - Full-Built.ps1 orchestrates complete build-to-deploy workflow
  - Builds and publishes .NET projects
  - Creates signed MSIX package
  - Generates two-stage installer (BAT + PS1)
  - Uploads all artifacts to Azure Blob Storage
  - Generates and uploads download page
- **Documentation Sync System** - Automated public repo synchronization
  - Sync-PublicRepo.ps1 with version.json integration
  - Auto-loads download URLs from build artifacts
  - Security sanitization (redacts connection strings, API keys, SAS tokens)
  - Automated git commit and push workflow

### Fixed
- **Installer Encoding Issues** - Box characters (═) now display correctly
  - Removed `[Console]::OutputEncoding` from installer template (caused corruption)
  - PowerShell scripts saved WITH BOM, BAT files WITHOUT BOM
  - Azure upload uses correct content-type based on file extension
  - Switch statement for file-type detection (.ps1 vs .bat)
- **MermaidRenderer Path Issues** - Fixed MSIX virtualization problems
  - Changed from `%LOCALAPPDATA%\MermaidRenderer` to `%LOCALAPPDATA%\Temp\MermaidRenderer`
  - Uses `Path.GetTempPath()` to avoid MSIX/Citrix virtualization
  - Updated cleanup scripts to match new runtime locations
- **Diagnostic Log Paths** - Consistent with MermaidRenderer approach
  - Changed from `%LOCALAPPDATA%\SODA_PLUS` to `%LOCALAPPDATA%\Temp\SODA_PLUS`
  - Ensures logs are accessible in all environments
- **Missing PowerShell Installer Upload** - Full-Built.ps1 now uploads both BAT and PS1 files
  - Previously only uploaded BAT file
  - PS1 installer script now correctly uploaded to Azure
  - Download page references correct filenames

### Changed
- **Deployment Workflow** - Streamlined build and upload process
  - Single script execution deploys entire release
  - Auto-generates download page with actual artifact URLs
  - Version tracking via version.json build artifact
- **Installer Template** - Minimalist encoding approach
  - Relies on UTF-8 BOM for encoding (no explicit commands)
  - Cleaner code, more reliable behavior
  - Compatible with Azure blob storage text rendering
- **Upload Scripts** - Intelligent file-type detection
  - `.ps1` files: `text/plain; charset=utf-8` (preserves BOM and special characters)
  - `.bat` files: `application/octet-stream` (binary download)
  - Explicit failure on unsupported file types

### Security
- **Content Sanitization** - Automated redaction for public repo sync
  - Azure AccountKey redaction
  - API keys and Bearer tokens
  - Database passwords and connection strings
  - SAS tokens on blob storage URLs
  - Azure Function keys

### Technical
- **Build System Improvements**
  - Core_Build_Publish.ps1: Builds and publishes all .NET dependencies
  - Packages_Create_MSIX.ps1: Creates signed MSIX package
  - Generate-Two-Stage-Installer.ps1: Creates BAT wrapper with embedded PS1
  - Upload-Installer.ps1: Smart file-type detection for Azure uploads
  - Generate-DownloadPage.ps1: Template-based page generation with placeholders
- **Repository Migration** - Transitioned to SODA_PLUS_AI_PRE_PROD
  - Updated all deployment scripts for new structure
  - Maintained backward compatibility with existing workflows

---

## [1.1.0-beta] - 2025-10-26

### Added
- **AI-Assisted Self-Learning Chart Error Correction** - Revolutionary feature that automatically fixes chart rendering errors
  - Automatic error detection via SVG content validation
  - AI-powered fix generation using Grok
  - Pattern storage in `MermaidRenderingFixes` database table
  - Community knowledge sharing (anonymized patterns)
  - Instant fix application for known errors (< 1 second)
- **Views Support for Charting** - All three chart types now work with Views
  - Quick Chart for Views
  - AI-Enhanced Chart for Views
  - Logic Flowchart for Views
- **Azure Functions Chart Endpoints**:
  - `GET /api/chart/get-fixes` - Retrieve active fix patterns
  - `POST /api/chart/store-fix` - Store new fixes
  - `POST /api/chart/report-fix-failure` - Track fix effectiveness
- **Enhanced Error Detection** - SVG content validation catches errors missed by exit codes
- **Detailed Debug Logging** - Comprehensive logging for chart generation process

### Fixed
- Chart options greyed out for Views - now fully enabled
- SVG rendering errors not detected when exit code = 0
- Special characters in Mermaid labels causing parse errors
- Square brackets `[` `]` in node labels triggering syntax errors
- JSON serialization issues in Azure Functions (missing PropertyName attributes)
- Authorization level causing 401 errors on chart endpoints (changed to Anonymous)

### Changed
- User Guide updated with Self-Learning Error Correction section
- Step 10 (Dependency Charting) documentation enhanced
- Chart rendering workflow improved with automatic retry logic
- Error messages more descriptive with troubleshooting hints

### Security
- Anonymization of database object names in stored patterns
- Privacy-preserving pattern storage (no sensitive data)

---

## [1.0.0-beta] - 2025-10-20

### Added
- **Enhanced Dependency Analysis with Drill-Down**
  - Multi-level dependency tracking (up to 10 levels)
  - Right-click drill-down to new analyzer tabs
  - Color-coded visualizations by object type
  - Upstream/Downstream/Call Order sub-tabs
- **AI-Powered Code Review**
  - Multiple analysis types (Summary, Security, Performance, etc.)
  - Three-tab AI Review window (Sent Prompt, AI Response, Formatted View)
  - Custom prompts for follow-up questions
  - Session storage and export
- **Interactive Dependency Charting**
  - Quick Chart (instant, offline)
  - AI-Enhanced Chart (optimized layouts)
  - Logic Flowchart (control flow visualization)
  - Mermaid diagram generation with SVG export
- **Cloud-Based API Key Management**
  - User registration and login system
  - Encrypted session storage (Windows DPAPI)
  - API key pool management
  - Usage tracking and quota enforcement
- **Azure Functions Integration**
  - Authentication endpoints (register, login)
  - AI analysis proxy with usage tracking
  - Health monitoring
- **Enhanced Server Management**
  - Dual authentication (Windows/SQL Server)
  - Encrypted credential storage
  - Connection testing
  - Per-environment configuration
- **Object Search**
  - Real-time filtering
  - Schema-qualified search
  - Auto-expand matching items
- **Multi-Tab Analyzer Architecture**
  - Independent tab state
  - Maximum 10 tabs
  - Smart tab reuse

### Fixed
- Initial beta release - no previous bugs to fix

### Security
- Encrypted password storage (Windows DPAPI)
- Session token management with rotation
- API key encryption in Azure Key Vault
- Anonymous endpoints for public APIs

---

## Version Number Format

**Major.Minor.Patch-stage**

Examples:
- `1.0.0-beta` - First beta release
- `1.1.0-beta` - Second beta release with new features
- `1.5.0-beta` - Fifth beta release
- `1.5.1` - Bug fix and documentation update
- `1.2.0-rc` - Release candidate
- `2.0.0` - Major release (production)

---

## Change Categories

- **Added** - New features
- **Changed** - Changes in existing functionality
- **Deprecated** - Soon-to-be removed features
- **Removed** - Removed features
- **Fixed** - Bug fixes
- **Security** - Security improvements
- **Technical** - Build system, deployment, infrastructure changes

---

## Links

- [1.5.1] - https://github.com/jcboyer/SODA_PLUS_AI_PRE_PROD/compare/v1.5.0-beta...v1.5.1
- [1.5.0-beta] - https://github.com/jcboyer/SODA_PLUS_AI_PRE_PROD/releases/tag/v1.5.0-beta
- [1.1.0-beta] - https://github.com/jcboyer/SODA_PLUS_AI/releases/tag/v1.1.0-beta
- [1.0.0-beta] - https://github.com/jcboyer/SODA_PLUS_AI/releases/tag/v1.0.0-beta
- [Unreleased] - https://github.com/jcboyer/SODA_PLUS_AI_PRE_PROD/compare/v1.5.1...HEAD

---

**Maintained by:** Jerome Boyer  
**Last Updated:** 2025-11-13  
**Repository:** https://github.com/jcboyer/SODA_PLUS_AI_PRE_PROD
