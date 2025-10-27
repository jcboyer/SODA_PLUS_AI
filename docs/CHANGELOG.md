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

## [1.1.0-beta] - 2025-01-26

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

## [1.0.0-beta] - 2024-10-20

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
- `1.1.1-beta` - Bug fix release
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

---

## Links

- [1.1.0-beta] - https://github.com/jcboyer/SODA_PLUS_AI_ReleasedBeta/releases/tag/v1.1.0-beta
- [1.0.0-beta] - https://github.com/jcboyer/SODA_PLUS_AI_ReleasedBeta/releases/tag/v1.0.0-beta
- [Unreleased] - https://github.com/jcboyer/SODA_PLUS_AI_ReleasedBeta/compare/v1.1.0-beta...HEAD

---

**Maintained by:** Jerome Boyer  
**Last Updated:** 2025-01-26
