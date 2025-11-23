# CHANGELOG

All notable changes to SODA+ AI will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

---

## [Unreleased]

### To Be Added
- Token counting for accurate cost tracking
- Batch chart generation
- Custom fix pattern management

---

## [1.5.6] - 2025-11-22

### Fixed
- **Auto-Update Checker**: Fixed version parsing error when Git commit hash is included in version string
  - Error: `System.FormatException: The input string '4+9398aa92a1f010aac7bd0a99b70ed5852dd505af' was not in a correct format`
  - Now properly handles formats like `1.5.5+9398aa92a1f010aac7bd0a99b70ed5852dd505af`
  - Added `CleanVersionString()` helper to remove build metadata (after `+`) and pre-release suffixes (after `-`)
  - Changed from `Version.Parse()` to `Version.TryParse()` for graceful error handling
  - Improved logging to show raw and cleaned version strings for debugging

### Improved
- **Version Comparison**: Enhanced version comparison logic to handle semantic versioning with build metadata
  - Strips Git commit hashes before parsing (e.g., `1.5.5+abc123` → `1.5.5`)
  - Strips pre-release tags before parsing (e.g., `1.5.5-beta` → `1.5.5`)
  - Handles combined formats (e.g., `1.5.5-beta+abc123` → `1.5.5`)
- **Error Handling**: Update checker now fails gracefully instead of crashing on parse errors
  - Returns early if version parsing fails
  - Logs helpful error messages for troubleshooting
- **Logging**: Added detailed debug output for version checking process
  - Shows raw version string from assembly
  - Shows cleaned version string after sanitization
  - Shows comparison results

### Technical
- **CleanVersionString() Method**: New helper for semantic version sanitization
  - Removes everything after `+` (build metadata)
  - Removes everything after `-` (pre-release suffix)
  - Returns clean numeric version for `Version.Parse()`
- **TryParse Pattern**: Safer version parsing throughout
  - No exceptions thrown on invalid versions
  - Early return with log message on failure
  - User workflow never interrupted

---

## [1.5.5] - 2025-11-23

### Added
- **Conversational AI Mode [BETA]** - Interactive chat-style AI analysis with follow-up questions
  - New prompt type: "💬 Can This Code Be Split?" 
  - Chat-based UI with progressive analysis steps
  - Follow-up question support for iterative refinement
  - SQL code extraction with syntax highlighting
  - SSMS integration for generated code snippets
  - Conversation history with user/assistant message tracking
  - Progress indicators during multi-step analysis
- **"💬 Can This Code Be Split? [BETA]" Menu Item** - New entry in AI Analysis dropdown
  - Location: Dependency Analyzer → 🤖 AI Analysis menu
  - Position: After separator following "🔧 Refactoring"
  - Tooltip: "Conversational AI analysis to explore splitting complex code into smaller procedures (BETA feature)"
  - Works with: Stored Procedures, Functions (objects with analyzable code)
- **Azure Conversation Storage** - Persistent conversation tracking in cloud database
  - Table: `AIConversations` - Stores conversation metadata
  - Table: `AIConversationMessages` - Stores individual messages
  - Fields tracked: Server, Database, Environment, Object Name, Prompt Type
  - SQL code extraction and storage for deployment tracking
  - Conversation ID in generated SQL script headers
- **ConversationView Control** - New WPF control for chat-style interactions
  - Progressive message display (user questions → AI status → AI responses)
  - Collapsible SQL code blocks with copy and SSMS integration
  - Follow-up question textbox with send button
  - Stop analysis button for cancellation
  - Export conversation button (future feature)
  - Auto-scroll to latest message
- **SQL Query Refactoring** - Improved maintainability and performance
  - **Embedded SQL Resources** - Queries loaded from `.sql` files instead of inline C# strings
    - New files: `FetchDependencies_References.sql` (downstream dependencies)
    - New files: `FetchDependencies_ReferencedBy.sql` (upstream dependencies)
    - Location: `SODA_PLUS_DEPENDENCIES/Sql/` folder
    - Build Action: Embedded Resource (loaded once per app lifetime, cached)
  - **Query Split** - Monolithic query (~700 lines) split into two direction-specific files
    - `FetchDependencies_References.sql` - Downstream (what THIS object uses)
    - `FetchDependencies_ReferencedBy.sql` - Upstream (what uses THIS object)
    - Each file ~350 lines with comprehensive inline documentation
  - **Version Tracking** - SQL files include version headers
    - Version: 2.2 (as of 2025-11-15)
    - Last Modified date tracked in file header
    - Change log in `SODA_PLUS_DEPENDENCIES/Sql/README.md`
  - **Performance Optimization** - 50% smaller queries uploaded to SQL Server
    - Faster query parsing
    - Better SQL Server plan cache efficiency
    - Lazy loading with `Lazy<string>` caching
- **Comment Filtering Enhancements** - Eliminates false positive dependencies
  - **Intelligent SQL Comment Detection** - Removes objects only referenced in comments
    - Supports both `--` single-line and `/* */` block comments
    - Parallel processing (10 objects concurrently) for speed
    - Graceful degradation if filtering fails (fail-safe design)
  - **Self-Referencing Trigger Filter** - Eliminates duplicate noise
    - Detects triggers attached TO the analyzed table
    - Excludes them from upstream (ReferencedBy) direction
    - Keeps them in downstream (References) direction
    - Example: `trg_Family_UPDATE` on `product.Family` no longer shows as upstream dependency
  - **MARS Support** - Multiple Active Result Sets enabled for nested queries
    - Added `MultipleActiveResultSets=True` to connection strings
    - Allows comment filtering to fetch object definitions while main reader is open
    - Fixed "The connection does not support MultipleActiveResultSets" errors

### Fixed
- **Critical: Metadata Dictionary Empty Bug** - Server and Database were "Unknown" in conversational mode
  - **Root Cause**: Two code paths for launching AI Review had inconsistent metadata population
    - Path 1: Main window right-click → `MainShell.AIIntegration.cs` → Metadata WAS populated ✅
    - Path 2: Dependency Analyzer toolbar → `MainShell.TabManagement.cs` → Metadata was NOT populated ❌
  - **Solution**: Added metadata dictionary to `OnAIReviewRequested()` in `MainShell.TabManagement.cs`
  - **Impact**: Generated SQL scripts now show correct server/database in headers
  - **Debug Output Added**: Logs metadata count and values for verification
  - **Files Modified**: `SODA_PLUS_MAIN/Views/MainShell.TabManagement.cs` (line ~325)
- **AIRequest Metadata Population** - Consistent initialization across all code paths
  - Both paths now create metadata with `["Server"]` and `["Database"]` keys
  - Environment variable correctly passed from `_currentEnvironment`
  - Connection string preserved from ObjectInfo
- **Prompt Type Enum Parsing** - Correct handling of "CanThisCodeBeSplit" string
  - Event handler uses exact enum name for reliable parsing
  - Fallback to Summary if parsing fails (defensive coding)
- **Trigger Type Detection Bug** - Triggers showing as "TABLE" in upstream dependencies
  - **Root Cause**: `sys.triggers.type_desc` was returning incorrect values
  - **Solution**: Hardcoded `'TRIGGER'` in SQL query instead of relying on `type_desc`
  - **Impact**: Triggers now correctly display as "TRIGGER" instead of "TABLE"
  - **Files Modified**: `FetchDependencies_ReferencedBy.sql` (Version 2.1)
- **Duplicate Trigger Noise** - Triggers appearing in BOTH upstream and downstream
  - **Root Cause 1**: Trigger-specific query wasn't filtering triggers ON the analyzed table
    - Fixed by adding `WHERE t.parent_id <> object_id(@RootFullName)` filter
  - **Root Cause 2**: DMV query (`sys.dm_sql_referencing_entities`) also returning self-referencing triggers
    - Fixed by adding LEFT JOIN to `sys.triggers` and excluding matches
  - **Impact**: Analyzing `product.Family` now shows triggers ONLY in downstream (not upstream)
  - **Example**: `trg_Family_UPDATE` appears once (in References) instead of twice
  - **Files Modified**: `FetchDependencies_ReferencedBy.sql` (Version 2.2)
- **MultipleActiveResultSets Error** - "The connection does not support MultipleActiveResultSets"
  - **Root Cause**: Connection created in MAIN project didn't have MARS enabled
  - **Solution**: Added `MultipleActiveResultSets=True` to `ObjectInfo.GetConnectionString()` in MAIN project
  - **Impact**: Comment filtering now works without nested reader errors
  - **Files Modified**: `SODA_PLUS_MAIN/Models/ObjectInfo.cs`

### Changed
- **AI Analysis Dropdown Menu** - Reorganized menu structure
  - Added separator after "📚 Best Practices" and "🔧 Refactoring"
  - Conversational AI entries visually separated from traditional analysis types
  - Menu order now: Code Review → Quick Wins → [separator] → Security/Performance/Best Practices/Refactoring → [separator] → Conversational AI
- **AIReviewControl Architecture** - Mode-based UI switching
  - Traditional mode: Shows tabs (Prompt, Response, Formatted View, Refactor)
  - Conversational mode: Shows ConversationView control exclusively
  - Custom prompt disabled in conversational mode (chat takes over)
  - Execute button triggers different workflows based on mode
- **Event Handler Naming** - Clear distinction between analysis types
  - Traditional: `AIReview_Summary_Click`, `AIReview_Security_Click`, etc.
  - Conversational: `AIReview_CanCodeBeSplit_Click`
  - Consistent pattern across all menu items
- **Debug Logging Enhanced** - Comprehensive metadata tracking
  - `[LaunchAIReview]` logs in MainShell.AIIntegration.cs
  - `[OnAIReviewRequested]` logs in MainShell.TabManagement.cs
  - `[PromptTypeComboBox_SelectionChanged]` logs in AIReviewControl.EventHandlers.cs
  - Metadata count and key/value pairs logged for troubleshooting
- **SQL Query Architecture** - Transition from inline strings to embedded resources
  - **Before**: Single 700-line C# string with `if @Direction = 'References'` branching
  - **After**: Two separate SQL files with clear separation of concerns
  - **Benefits**:
    - Easier to read and maintain (SQL syntax highlighting in IDE)
    - Version control friendly (cleaner diffs)
    - No escaping issues (no C# string literals)
    - Professional organization (dedicated Sql folder)
- **Dependency Filtering Logic** - Three-stage filtering process
  - **Stage 1**: Self-referencing trigger filter (removes 3 triggers in typical case)
  - **Stage 2**: Comment filtering (removes ~40% false positives in production databases)
  - **Stage 3**: Conditional reference validation (detects dynamic SQL patterns)
  - **Example Results** (analyzing `product.Family`):
    - SQL returns: 107 objects
    - After trigger filter: 104 objects (-3 self-referencing triggers)
    - After comment filter: 62 objects (-42 commented-only references)
    - Final count: 62 real upstream dependencies

### Technical
- **Conversational Flow Architecture**
  - `AIReviewControl.Core.cs`: Mode detection via `IsConversationalPrompt()`
  - `AIReviewControl.Core.cs`: UI mode switching via `SetConversationalMode()`
  - `AIReviewControl.Analysis.cs`: Separate execution path `PerformConversationalAnalysis()`
  - `AIReviewControl.EventHandlers.cs`: Dropdown handler creates ObjectInfo with metadata
  - `ConversationView.xaml.cs`: Message display, follow-up handling, SSMS integration
- **Metadata Dictionary Structure**
  ```csharp
  Metadata = new Dictionary<string, object>
  {
      ["Server"] = depObjectInfo.Server,      // e.g., "JB-MAIN-NEW\PCM"
      ["Database"] = depObjectInfo.Database   // e.g., "PCM"
  }
  ```
- **ObjectInfo Reconstruction** - Metadata → ObjectInfo conversion
  - Extract Server/Database from metadata dictionary
  - Add LineCount from code length
  - Pass to ConversationView.Initialize()
  - Used for SQL script generation and SSMS integration
- **SQL Script Headers** - Generated code includes tracking metadata
  ```sql
  -- Object: dbo.Product_COST_UPDATE_Results
  -- Server: JB-MAIN-NEW\PCM
  -- Database: PCM
  -- AI-Generated: 2025-11-15 13:55:39
  -- AI Conversation ID: a9680486-0b0a-413a-9651-a98fad21cb68
  
  USE [PCM]
  GO
  ```
- **Two Code Paths Unified** - Consistent AIRequest creation
  - Path 1: `MainShell.AIIntegration.cs` → Right-click from Object Explorer
  - Path 2: `MainShell.TabManagement.cs` → Toolbar button from Dependency Analyzer
  - Both now populate metadata dictionary identically
  - Both pass through `CreateAIReviewWindow()` → `InitializeWithSessionAsync()`
- **Embedded Resource Loading** - SQL query caching system
  - **LoadEmbeddedSql()** method with comprehensive error handling
  - **Resource Name Format**: `SODA_PLUS_DEPENDENCIES.Sql.{filename}.sql`
  - **Lazy Loading**: `Lazy<string>` ensures queries loaded once per app lifetime
  - **Validation**: Checks for null streams and empty content
  - **Error Messages**: User-friendly troubleshooting steps if resource missing
- **Connection String Management** - MARS support across projects
  - **MAIN Project**: `SODA_PLUS_MAIN/Models/ObjectInfo.cs`
  - **DEPENDENCIES Project**: `SODA_PLUS_DEPENDENCIES/Models/ObjectInfo.cs`
  - Both now include `MultipleActiveResultSets=True` in connection strings
  - Prevents nested reader errors during comment filtering
- **Comment Filtering Architecture** - Parallel processing with semaphore
  - **Concurrency Limit**: 10 objects processed simultaneously
  - **SQL Parsing**: `RemoveCommentsFromSql()` strips `--` and `/* */` comments
  - **Validation**: Text search on cleaned SQL to detect active references
  - **Fail-Safe**: If filtering fails, keeps all dependencies (no data loss)
  - **Performance**: Processes 104 objects in ~1300ms (13ms per object)
- **SQL Query Version History**
  - **Version 1.0**: Original monolithic query with inline branching
  - **Version 2.0**: Split into two embedded SQL files
  - **Version 2.1**: Fixed trigger type detection, added self-reference filter in trigger query
  - **Version 2.2**: Added self-reference filter in DMV query (complete fix)

### User Experience
- **Conversational AI Workflow**:
  1. Open Dependency Analyzer for any stored procedure
  2. Click 🤖 AI Analysis → 💬 Can This Code Be Split? [BETA]
  3. Chat-style window opens with initial analysis request
  4. AI responds with progressive status updates:
     - Step 1/3: Preparing analysis...
     - Step 1/3: Generating summary... (if needed)
     - Step 2/3: Analyzing code structure...
     - Step 3/3: Results
  5. AI response shows recommendations
  6. SQL code blocks extracted and displayed with syntax highlighting
  7. User can:
     - Copy SQL code to clipboard
     - Open in SSMS (automated workflow)
     - Ask follow-up questions
     - Export conversation (future feature)

- **Error Handling**:
  - Missing code: Warning dialog with explanation
  - Missing metadata: "Unknown" fallback (now fixed!)
  - API errors: User-friendly error messages in chat
  - Summary generation failures: Continues with default summary

- **Dependency Analysis Improvements**:
  - **Before Comment Filtering**: 107 upstream dependencies (42% noise)
  - **After Comment Filtering**: 62 upstream dependencies (real references only)
  - **Before Trigger Fix**: Triggers shown in BOTH directions (duplicate noise)
  - **After Trigger Fix**: Triggers shown ONLY in downstream (correct direction)
  - **Visual Feedback**: Debug log shows filtering progress and results

### Dialog Messages
- **Conversational Mode Activated**:
  ```
  💬 Conversational mode - Click 'Execute Analysis' to begin conversation
  ```

- **No Code Available Warning**:
  ```
  Cannot launch AI Conversational Analysis - no code is available.
  
  Please ensure the object has viewable code loaded in the analyzer.
  ```

- **Analysis Progress Messages** (displayed in chat):
  ```
  🤖 Preparing analysis...
  📝 Generating summary to understand your code...
  🔍 Analyzing your code structure...
  ✅ Analysis complete!
  📝 I've generated SQL code for the proposed split:
  ```

### Security
- **Conversation Privacy** - Azure storage with user authentication
  - Conversations linked to user ID (session token required)
  - Server/Database stored for deployment tracking
  - No sensitive data in conversation metadata
  - SQL code sanitized before storage
- **SSMS Integration** - Secure code transfer
  - Uses existing SSMS authentication
  - No credentials in temp files
  - Clipboard cleared after use

### Documentation
- **User Guides Updated** (pending):
  - Quick Start Guide - Add conversational AI section
  - Concise Guide - Add "Can This Code Be Split?" example
  - Reference Guide - Add ConversationView control documentation
- **Developer Documentation** (pending):
  - Conversational AI architecture diagram
  - Two code paths diagram (right-click vs toolbar)
  - Metadata flow documentation
  - Azure conversation storage schema
- **SQL Query Documentation** - New README.md in Sql folder
  - File: `SODA_PLUS_DEPENDENCIES/Sql/README.md`
  - Version history for both SQL files
  - Architecture decisions and rationale
  - Query splitting methodology
  - Comment filtering algorithm documentation
  - Trigger filtering logic explanation

### Performance
- **Progressive Analysis** - Keeps user informed during long operations
  - Summary generation: 5-10 seconds
  - Main analysis: 10-30 seconds
  - Follow-up questions: 5-15 seconds
- **UI Responsiveness** - Async/await prevents freezing
  - All AI calls non-blocking
  - Progress indicators during waits
  - Cancellation support (Stop Analysis button)
- **SQL Query Performance** - 50% reduction in query size
  - **Before**: Single 700-line query uploaded to SQL Server
  - **After**: Direction-specific 350-line queries
  - **Benefit**: Faster parsing, better plan cache utilization
- **Comment Filtering Performance** - Parallel processing
  - **Speed**: 10 objects processed concurrently (semaphore limit)
  - **Throughput**: ~13ms per object (104 objects in 1300ms)
  - **Memory**: Minimal overhead (small SQL definitions cached temporarily)

### Known Issues
- **Token Counting** - Not yet implemented for conversational mode
  - Usage tracked at conversation level (not per message)
  - Token count shown as 0 in Azure logs
  - Future: Track tokens per message for accurate cost tracking
- **Embedded Resource Refresh** - Changes to SQL files require rebuild
  - Hot reload does NOT work for embedded resources
  - Must stop debugging, rebuild, and restart to test SQL changes
  - Workaround: Use external SQL files during development, embed for release

---

## [1.5.2] - 2025-11-13

### Added
- **SSMS Integration with Full Automation** - Revolutionary one-click workflow for opening SQL code in SSMS
  - **Automated Keyboard Input** - Uses Windows API (`keybd_event`) to send Ctrl+N and Ctrl+V automatically
  - **Smart Detection** - Detects if SSMS is already running (avoids launching duplicate instances)
  - **Code Preparation** - Auto-adds `USE [Database]` statement with GO separator
  - **Zero Manual Steps** - Click button → Code opens in SSMS query window automatically
  - **Preserves Connections** - Uses existing SSMS connection (no certificate errors)
  - **Temp File Management** - Creates timestamped .sql files in `%TEMP%\SODA_PLUS_SSMS\`
  - **Graceful Fallback** - Shows manual instructions if automation fails
  - **Multi-Version Support** - Detects SSMS 18, 19, 20, 21+ (prefers newest)
- **"📤 Open in SSMS" Button** - New toolbar button in Dependency Analyzer
  - Location: Right side of toolbar (after Export button)
  - Tooltip: "Open this object in SQL Server Management Studio (SSMS 18-21)"
  - Works with: Stored Procedures, Functions, Views, Tables
- **SSMS Version Detection** - Automatic discovery of installed SSMS versions
  - Checks filesystem first (fastest): Versions 21 → 20 → 19 → 18
  - Falls back to registry if needed
  - Shows detected version in status bar
  - Offers download link if SSMS not found

### Changed
- **Partial Class Refactoring** - Reorganized `DependencyAnalyzerControl` for better maintainability
  - **Main file reduced**: 865 lines → 200 lines (76% reduction!)
  - **New files created**:
    - `DependencyAnalyzerControl.AIReview.cs` (240 lines) - All AI review menu handlers
    - `DependencyAnalyzerControl.SSMS.cs` (400 lines) - SSMS integration and automation
  - **Existing partials maintained**:
    - `DependencyAnalyzerControl.Navigation.cs` - Context menus, navigation
    - `DependencyAnalyzerControl.SyntaxHighlighting.cs` - SQL syntax highlighting
    - `DependencyAnalyzerControl.DataOperations.cs` - Data loading, export
    - `DependencyAnalyzerControl.Search.cs` - Code search
  - **Benefits**: Clearer code organization, easier collaboration, reduced merge conflicts

### Fixed
- **Certificate Chain Errors** - Resolved "The certificate chain was issued by an authority that is not trusted"
  - Root cause: Launching new SSMS process tried to re-authenticate
  - Solution: Uses existing SSMS instance with keyboard automation (no new connection)
  - Impact: Works in environments with self-signed certificates or strict TrustServerCertificate settings
- **Connection Preservation** - Fixed losing existing SSMS connections
  - Old behavior: Detected SSMS running but launched new process anyway
  - New behavior: Activates existing window and uses keyboard automation
  - Result: User's active SSMS session remains intact

### Technical
- **Windows API Integration** - Direct keyboard event simulation
  - `keybd_event` P/Invoke for Ctrl+N and Ctrl+V
  - Virtual key codes: VK_CONTROL (0x11), VK_N (0x4E), VK_V (0x56)
  - Timing delays: 500ms for window activation, 300ms for query window open
  - Key up/down events properly sequenced
- **Process Management** - Smart SSMS instance handling
  - `Process.GetProcessesByName("Ssms")` detection
  - `MainWindowHandle` for window activation
  - `SetForegroundWindow` and `ShowWindow` API calls
  - Window restoration if minimized (SW_RESTORE constant)
- **File Operations** - Temp file creation and management
  - Location: `%TEMP%\SODA_PLUS_SSMS\{ObjectName}_{Timestamp}.sql`
  - Filename sanitization: Invalid chars replaced with underscores
  - Length limit: 50 characters (prevents Windows MAX_PATH issues)
  - Unique timestamps prevent collisions
- **Code Structure** - Professional partial class organization
  - Clear separation of concerns (AI vs SSMS vs Navigation)
  - Regional organization within partials (#region SSMS Integration)
  - Shared fields accessible across all partials
  - Zero runtime impact (compiler combines into single class)

### User Experience
- **Before (Manual Workflow)**:
  1. Copy object name to clipboard
  2. Activate SSMS window
  3. Press Ctrl+F in Object Explorer
  4. Paste object name (Ctrl+V)
  5. Navigate to object
  6. Right-click → Script As → CREATE
  7. Copy SQL code
  8. Press Ctrl+N for new query
  9. Paste code (Ctrl+V)
  10. Manually type `USE [Database]` statement
  - **Total**: 10 manual steps, 30-45 seconds

- **After (Automated Workflow)**:
  1. Click "📤 Open in SSMS" button
  - **Total**: 1 click, 3-5 seconds ⚡

- **Time Saved**: 10x faster (45s → 5s)

### Dialog Messages
- **SSMS Running + Code Available**:
  ```
  SSMS is already running (PID: 12345).
  
  Object: dbo.GetCustomer
  Server: YourServer
  Database: YourDatabase
  
  Would you like to automatically open this code in SSMS?
  
  Automated steps:
  • Activate SSMS window
  • Send Ctrl+N (new query window)
  • Send Ctrl+V (paste code with USE statement)
  
  Your existing connection will be preserved!
  ```

- **Automation Complete**:
  ```
  ✅ SQL code automatically opened in SSMS!
  
  Object: dbo.GetCustomer
  Server: YourServer
  Database: YourDatabase
  
  Actions performed automatically:
  • SSMS window activated
  • New query window opened (Ctrl+N)
  • Code pasted (Ctrl+V)
  
  The query window contains:
  • USE [YourDatabase] statement
  • Complete object definition
  
  Next step: Execute the USE statement (F5) if needed
  ```

- **Fallback (If Automation Fails)**:
  ```
  Automation failed, but code is in clipboard!
  
  Manual steps:
  1. Press Ctrl+N in SSMS (new query)
  2. Press Ctrl+V (paste code)
  
  Error: [error details]
  ```

### Security
- **No Credential Exposure** - SSMS automation doesn't handle credentials
  - Uses existing SSMS authentication (Windows or SQL)
  - No passwords in command line or temp files
  - Clipboard cleared after use
- **Temp File Security** - Files created in user's TEMP folder
  - Readable only by current Windows user
  - No sensitive data beyond SQL code
  - Files remain for user convenience (can save/reopen)

### Documentation
- **New Documentation Files Created**:
  - `SODA_PLUS_DEPENDENCIES/Controls/SSMS_V3_IMPLEMENTATION_GUIDE.md` - Technical implementation details
  - `SODA_PLUS_DEPENDENCIES/Controls/SSMS_CERTIFICATE_FIX.md` - Certificate error troubleshooting
  - `SODA_PLUS_DEPENDENCIES/Controls/SSMS_V3_COMPLETE.md` - Feature summary and testing checklist
  - `SODA_PLUS_DEPENDENCIES/Controls/PARTIAL_CLASS_REFACTORING.md` - Code organization documentation
- **Updated User Guides**: Quick Start, Concise Guide, Reference Guide (see below)

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
- `1.5.2` - SSMS integration and code refactoring
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
- **User Experience** - UX improvements and workflow enhancements
- **Documentation** - Guide updates and new documentation files

---

## Links

- [1.5.2] - https://github.com/jcboyer/SODA_PLUS_AI_PRE_PROD/compare/v1.5.1...v1.5.2
- [1.5.1] - https://github.com/jcboyer/SODA_PLUS_AI_PRE_PROD/compare/v1.5.0-beta...v1.5.1
- [1.5.0-beta] - https://github.com/jcboyer/SODA_PLUS_AI_PRE_PROD/releases/tag/v1.5.0-beta
- [1.1.0-beta] - https://github.com/jcboyer/SODA_PLUS_AI/releases/tag/v1.1.0-beta
- [1.0.0-beta] - https://github.com/jcboyer/SODA_PLUS_AI/releases/tag/v1.0.0-beta
- [Unreleased] - https://github.com/jcboyer/SODA_PLUS_AI_PRE_PROD/compare/v1.5.2...HEAD

---

**Maintained by:** Jerome Boyer  
**Last Updated:** 2025-11-22
**Repository:** https://github.com/jcboyer/SODA_PLUS_AI_PRE_PROD
