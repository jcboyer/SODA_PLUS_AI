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


## [1.6.0] - 2025-12-31

### Added
- **SQL Formatting Preferences System** - Cloud-based SQL code formatting with 20 customizable options
  - Dialog with live preview using AvalonEdit syntax highlighting
  - Two tabs: "My Preferences" (all users) and "Organization Template" (admins only)
  - 20 formatting options: keyword casing, indentation size (0-10), new line placements, alignment
  - Hierarchical configuration: Hard-coded defaults → Organization template → User override
  - Real-time preview updates as settings change
  - Cloud storage via Azure Functions + Database
  - Session-based authentication for all operations
- **Grok AI SQL Formatting [BETA]** - AI-powered SQL formatting with comment preservation
  - New "🤖 Format - AI" button in Dependency Analyzer toolbar
  - Uses Grok AI (xAI) to format SQL while preserving internal comments
  - ScriptDom strips comments during parsing - AI preserves them
  - Adaptive timeout based on SQL complexity (30-120 seconds)
  - Parameter preservation rules prevent `@Parameter` renaming
  - Progress bar with percentage display during formatting
  - User preferences integration (keyword casing, indentation, etc.)
  - **Timeout Protection** - Prevents infinite loops on syntax errors
    - 30-second base timeout with adaptive scaling
    - Complexity factors: +2s per 10 parameters, +1s per 100 lines, +1s per 20 comments
    - Capped at 120 seconds (2 minutes) maximum
    - Re-entry protection prevents duplicate format operations
  - **Large SQL Warnings** - User-friendly messages for complex code
    - SQL > 100KB shows warning before formatting
    - "Format may take up to 30 seconds or fail..." (Clean mode)
    - "AI formatting may take up to 2 minutes..." (AI mode)
    - Graceful timeout with 2-second message display
- **Local File-First Formatter Options (40-100x Faster)** - Performance optimization
  - Reads from `%APPDATA%\SODA_PLUS_AI\SqlFormatterOptions.json` first (< 5ms)
  - Falls back to Azure if local file missing (50-200ms)
  - Automatic file save when preferences updated
  - Shared location accessible to both WPF app and SSMS extension
  - Static fast loader method: `SqlFormattingPreferencesDialog.LoadFormatterOptionsAsync()`
- **SSMS Header Filtering** - Clean formatted SQL without metadata duplication
  - Strips SSMS auto-generated headers (`/****** Object: ... ******/`)
  - Removes `USE [DatabaseName]` statements
  - Removes `SET ANSI_NULLS` and `SET QUOTED_IDENTIFIER`
  - Removes `GO` batch separators
  - Preserves user-written comments before `CREATE/ALTER`
  - ScriptDom regenerates these statements if needed
- **Azure Functions Configuration API** - RESTful endpoints for configuration management
  - `GET /api/configuration/{userId}/{templateName}` - Load merged preferences (user override + org template + defaults)
  - `PUT /api/configuration/override` - Save user-specific preferences
  - `PUT /api/configuration/template` - Save organization-wide templates (admin only)
  - `DELETE /api/configuration/override/{userId}/{templateName}` - Reset user to org template/defaults
  - Session token validation on all endpoints (X-Session-Token, X-User-Id headers)
  - Authorization checks: user isolation, admin role validation
  - Automatic merge logic: user override > org template > defaults
- **Database Schema for Configuration Storage**
  - `UserConfigurationOverrides` table - Stores user-specific formatting preferences
    - Columns: OverrideId (PK), UserId, TemplateName, OverrideData (JSON), LastUpdated
    - Index on (UserId, TemplateName) for fast lookups
  - `ConfigurationTemplates` table - Stores organization-wide templates
    - Columns: TemplateId (PK), OrganizationId, TemplateName, TemplateData (JSON), IsDefault, CreatedAt
    - Index on (OrganizationId, TemplateName)
- **ConfigurationSyncService** - Client-side service for configuration management
  - `SetSessionToken()` - Configure authentication headers
  - `GetConfigurationAsync()` - Load user preferences with session validation
  - `SaveUserOverrideAsync()` - Save personal preferences with session headers
  - `SaveOrganizationTemplateAsync()` - Save org template (admin validation)
  - Integrated with MainShell DI container
- **Format Button Integration** - 💎 Format buttons now use user preferences
  - Two format buttons: "💎 Format - Clean" (ScriptDom) and "🤖 Format - AI" (Grok)
  - Callback pattern to load preferences without circular dependencies
  - `SetFormatterOptionsLoader()` method in DependencyAnalyzerControl
  - Automatic preference loading in MainShell.TabManagement.cs
  - Status messages: "(using your preferences)" vs "(using defaults)"
  - Works in both tab analyzers and full-window analyzers
- **Microsoft ScriptDom Integration** - Production-ready SQL formatting engine
  - Replaced mock formatter with real Microsoft.SqlServer.TransactSql.ScriptDom
  - Supports SQL Server 2008, 2012, 2014, 2016, 2017, 2019, 2022
  - Auto-detects SQL Server version from connection string
  - Handles complex SQL: CTEs, window functions, subqueries, triggers, etc.
  - ⚠️ Limitation: Strips internal comments (comments inside procedure body)
  - Header comments (before CREATE/ALTER) are preserved and re-attached
- **SessionValidationService Integration** - Enhanced security for configuration endpoints
  - `ValidateSessionAsync()` helper in ConfigurationFunctions
  - Session token extraction from HTTP headers
  - Database validation with expiry checks (24-hour default)
  - Authorization checks: userId matching, admin role verification

### Changed
- **Format Button Behavior** - Now loads and applies user preferences instead of hardcoded defaults
  - DependencyAnalyzerControl constructor accepts callback for preference loading
  - MainShell provides callback that queries ConfigurationSyncService
  - Graceful fallback to defaults if preferences unavailable or loading fails
  - Re-entry protection prevents infinite loops when formatting fails
  - Timeout protection with graceful cancellation (30-120 seconds adaptive)
- **Tools Menu** - Added "SQL Formatting Preferences" menu item
  - Location: Tools → SQL Formatting Preferences
  - Keyboard shortcut: Ctrl+Shift+F (configurable)
  - Opens SqlFormattingPreferencesDialog with current user settings
- **User Documentation** - Comprehensive SQL Formatting Preferences documentation
  - User Guide: Added Step 6a with 200+ lines of detailed documentation
  - User Guide: Added Format - AI button section with adaptive timeout, parameter preservation, comment handling
  - Concise Guide: Added to common tasks and tips section, brief Format - AI mode mention
  - Reference Guide: Added to alphabetical index, keyboard shortcuts, Q&A, toolbar button reference
  - Reference Guide: Added 3 new Q&A entries about Format - Clean vs Format - AI
  - All guides updated to version dates: December 31, 2025

### Fixed
- **Configuration Loading** - Fixed JSON parsing in SqlFormattingPreferencesDialog
  - Root cause: `config.RootElement.GetProperty("configuration")` threw KeyNotFoundException
  - Solution: Use `config.RootElement` directly (Azure already returns just configuration)
  - Impact: Dialog now loads saved preferences correctly
- **Session Token Headers** - Added authentication headers to all GET requests
  - X-Session-Token: Session token from user login
  - X-User-Id: User GUID for validation
  - Prevents 401 Unauthorized errors from Azure Functions
- **Authorization Enforcement** - Prevents users from modifying other users' settings
  - Validates userId from header matches authenticated userId
  - Returns 403 Forbidden if mismatch detected
  - Admin role check for organization template modifications
- **Session Validation** - All configuration endpoints validate session tokens before processing
  - Checks session exists in database
  - Validates session not expired (LastActivity < 24 hours)
  - Verifies userId matches session owner
- **Infinite Loop Prevention (Format Clean)** - ScriptDom timeout and re-entry protection
  - **Root Cause**: ScriptDom's internal parsing loops never gave up on syntax errors
  - **Solution 1**: Wrap `FormatSql()` in `Task.WhenAny()` with 30-second timeout
  - **Solution 2**: Add `_isFormattingInProgress` flag to prevent duplicate calls
  - **Solution 3**: Remove automatic fallback from Format AI to Format Clean
  - **Impact**: Format Clean now times out gracefully after 30 seconds, shows error message for 2 seconds, then unlocks UI
  - **Files Modified**: `DependencyAnalyzerControl.xaml.cs` - Added timeout logic, re-entry guard, and status messages
- **SSMS Header Duplication** - Format Clean no longer duplicates auto-generated statements
  - **Root Cause**: `ExtractHeaderComments()` collected `USE`, `SET ANSI_NULLS`, `SET QUOTED_IDENTIFIER`, and `GO` as "headers"
  - **Solution**: Skip SSMS-specific statements during header extraction - ScriptDom regenerates them
  - **Impact**: Formatted SQL is clean and ready to execute without duplicate metadata
  - **Files Modified**: `SODA_PLUS_COMMON\SqlFormatter.cs` - Updated `ExtractHeaderComments()` method

### Security
- **Session-Based Authentication** - All configuration API calls require valid session token
  - Session tokens issued on login (UserLoginDialog)
  - Tokens validated on every API request
  - Prevents unauthorized configuration access
- **User Isolation** - Users can only access and modify their own preferences
  - UserId validation prevents impersonation attacks
  - Configuration data scoped per user in database
  - API returns only user's own data
- **Admin Authorization** - Organization template modifications require IsOrganizationAdmin role
  - Role checked in Azure Functions before allowing template save
  - Non-admin users cannot modify organization templates
  - Audit trail via LastUpdated timestamps
- **Encrypted Storage** - Sensitive data encrypted at rest
  - Session tokens encrypted in database
  - Windows DPAPI for local credential encryption
  - Azure SQL Database encryption enabled
- **Attack Prevention** - Multiple layers of security validation
  - ❌ BLOCKED: Unauthorized access (no session token → 401 Unauthorized)
  - ❌ BLOCKED: Impersonation (userId mismatch → 403 Forbidden)
  - ❌ BLOCKED: Expired sessions (session timeout → 401 Unauthorized)
  - ❌ BLOCKED: Non-admin template modification (role check → 403 Forbidden)

### Technical
- **Callback Pattern** - Avoids circular dependencies between projects
  - SODA_PLUS_DEPENDENCIES cannot reference SODA_PLUS_MAIN
  - DependencyAnalyzerControl accepts `Func<Task<SqlFormatterOptions?>>` callback
  - MainShell provides implementation that accesses ConfigurationSyncService
  - Clean architecture: dependencies flow in one direction
- **Hierarchical Configuration** - 3-tier merge system for preferences
  1. Hard-coded defaults (built-in fallback)
  2. Organization template (admin sets, applies to all)
  3. User override (personal preference, highest priority)
  - Merge logic in Azure Functions ConfigurationFunctions.cs
  - GetConfigurationAsync() returns merged result
- **Adaptive Timeout Algorithm** - Dynamic timeout calculation for Grok AI
  ```csharp
  int baseTimeout = 30; // Base timeout in seconds
  int adaptiveTimeout = baseTimeout 
      + (parameterCount / 10 * 2)      // +2s per 10 parameters
      + (lineCount / 100)               // +1s per 100 lines
      + (commentCount / 20);            // +1s per 20 comments
  adaptiveTimeout = Math.Min(adaptiveTimeout, 120); // Cap at 2 minutes
  ```
  - **Example**: 50 parameters, 500 lines, 100 comments → 30 + 10 + 5 + 5 = **50 seconds**
  - **Example**: 200 parameters, 2000 lines, 500 comments → 30 + 40 + 20 + 25 = **115 seconds**
  - **Example**: Extreme case → Capped at **120 seconds** (2 minutes)
- **Grok AI Parameter Preservation** - Explicit prompt rules
  ```markdown
  5. Preserve ALL parameter names (@Parameter, @Variable, etc.) EXACTLY as written
  6. Do not modify, rename, or suggest changes to any parameter names
  7. Preserve parameter declarations and their data types exactly
  ```
  - Added to `GrokSqlFormatter.cs` BuildFormattingPrompt() method
  - HttpClient timeout increased from 30s to 60s for parameter-heavy SQL
- **Re-Entry Protection Architecture** - Prevents duplicate format operations
  ```csharp
  private bool _isFormattingInProgress = false;
  
  private async void FormatClean_Click(...)
  {
      if (_isFormattingInProgress) return; // Ignore duplicate calls
      _isFormattingInProgress = true;
      try { /* format */ }
      finally { _isFormattingInProgress = false; }
  }
  ```
  - Applied to both `FormatClean_Click()` and `FormatAI_Click()`
  - Debug logging shows re-entry attempts for troubleshooting
- **Azure Functions Deployment** - Configuration API deployed separately from main app
  - Deployment script: `SODA_PLUS_AZURE_FUNCTIONS\deploy-function-app.ps1`
  - Restart required after deployment: `az functionapp restart`
  - Configuration endpoints: /api/configuration/*
- **Database Migration** - Schema deployed with initial migration scripts
  - Script: `01_Create_ConfigurationTables.sql`
  - Tables: UserConfigurationOverrides, ConfigurationTemplates
  - Indexes for performance
  - Foreign key constraints for data integrity
- **Service Layer Architecture** - ConfigurationSyncService added to DI container
  - Registered in App.xaml.cs ConfigureServices()
  - Singleton lifetime (shared across app)
  - Injected into MainShell constructor
  - Used by analyzer controls via callback pattern

### Performance
- **Local File-First Loading** - 40-100x faster than Azure API calls
  - **Local file read**: < 5ms (typical: 2-3ms)
  - **Azure API call**: 50-200ms (typical: 100ms)
  - **Speed improvement**: 20-100x faster after first save
  - **File location**: `C:\Users\{username}\AppData\Roaming\SODA_PLUS_AI\SqlFormatterOptions.json`
- **Dialog Load Time** - < 1 second for default settings
  - Live preview renders in < 100ms per change
  - AvalonEdit syntax highlighting optimized
- **Save Preferences** - < 500ms to Azure Functions + Database
  - Async operations don't block UI
  - Optimistic UI updates (assumes success)
  - Local file write: < 10ms (instant feedback)
- **Load Preferences** - < 300ms from Azure Functions (fallback)
  - Local file read: < 5ms (primary)
  - Only hits Azure if local file missing
- **Format Operation** - 100-500ms depending on SQL complexity (Clean mode)
  - Microsoft ScriptDom parser optimized
  - Handles 1000+ line procedures
  - 30-second timeout for extreme cases
- **Grok AI Format Operation** - 5-120 seconds depending on SQL size
  - Small SQL (< 100KB): 5-15 seconds
  - Medium SQL (100-300KB): 15-45 seconds
  - Large SQL (> 300KB): 45-120 seconds (adaptive timeout)
  - Progress bar shows percentage complete
- **Session Validation** - < 50ms database query
  - Indexed on UserId for fast lookups
  - Cached validation results (1-minute TTL)

### User Experience
- **SQL Formatting Preferences Workflow**:
  1. Tools menu → SQL Formatting Preferences
  2. Dialog opens with current settings (loaded from cloud)
  3. Adjust 20 formatting options with live preview
  4. Click "Save My Preferences" (or "Save as Organization Template" for admins)
  5. Settings saved to Azure (UserConfigurationOverrides table)
  6. Local file created at `%APPDATA%\SODA_PLUS_AI\SqlFormatterOptions.json`
  7. Open Dependency Analyzer for any stored procedure
  8. Click 💎 Format - Clean or 🤖 Format - AI
  9. SQL formatted using YOUR saved preferences
  10. Status: "✅ SQL formatted using SQL Server 2022 (using your preferences)"
- **Format - AI Workflow** (Grok AI):
  1. Click "🤖 Format - AI" button
  2. Large SQL warning appears (if > 100KB): "⚠️ Large SQL detected (493,294 chars) - AI formatting may take up to 2 minutes..."
  3. Progress bar shows: "🤖 Formatting with Grok AI... 45%"
  4. Adaptive timeout (30-120s) based on SQL complexity
  5. SQL formatted with comments preserved
  6. Success message: "✅ SQL formatted with Grok AI (using your preferences: Uppercase, 4 spaces)"
- **Format - Clean Workflow** (ScriptDom):
  1. Click "💎 Format - Clean" button
  2. Large SQL warning appears (if > 100KB): "⚠️ Large SQL detected (493,294 chars) - Format may take up to 30 seconds or fail..."
  3. Formatting starts (< 1 second for typical SQL)
  4. If timeout: "⚠️ SQL formatting timed out after 30 seconds - SQL may be too complex or have syntax errors"
  5. Message displays for 2 seconds, then UI unlocks
  6. Success message: "✅ SQL formatted using SQL Server 2022 (using your preferences)"
- **Organization Template Workflow** (Admins):
  1. Login as admin (IsOrganizationAdmin = true)
  2. Tools → SQL Formatting Preferences
  3. Switch to "⭐ Organization Template" tab
  4. Set desired team-wide defaults
  5. Click "Save as Organization Template"
  6. Confirmation dialog (Yes/No)
  7. All users without personal overrides now use these settings
- **User Override Workflow**:
  1. Org template set by admin (e.g., IndentationSize = 4)
  2. User opens SQL Formatting Preferences
  3. "My Preferences" tab shows 4 (inherited from org)
  4. Change to 8 (personal preference)
  5. Click "Save My Preferences"
  6. Format button now uses 8 (user override wins)
  7. Other users still use 4 (org template)
  8. Can reset to org template anytime
- **Error Handling**:
  - Missing session: Dialog shows defaults, save disabled
  - Network error: Friendly error message with retry option
  - Azure Functions down: Fallback to hardcoded defaults
  - Invalid JSON: Settings reset to defaults with warning
  - Format timeout: Clear message shown for 2 seconds, UI unlocks
  - Infinite loop prevented: Re-entry protection, automatic cleanup

### Documentation
- **New Documentation Files Created**:
  - `FORMAT_BUTTON_USES_PREFERENCES.md` - Implementation summary
  - `FIX_SETTINGS_NOT_LOADING.md` - Troubleshooting guide
  - `SECURITY_ISSUE_ANONYMOUS_AUTH.md` - Security analysis
  - `RELEASE_NOTES_v1.6.0.md` - Comprehensive release notes
  - `FORMATTER_OPTIONS_PERFORMANCE_FIX.md` - Local file caching (40-100x improvement)
  - `ADAPTIVE_TIMEOUT_FIX.md` - Timeout calculations & parameter preservation
  - `INFINITE_LOOP_FIX.md` - Re-entry protection & timeout handling
  - `SSMS_CONFIG_STORAGE_FIX.md` - SSMS header filtering documentation
  - `GROK_AI_FORMATTING_COMPLETE.md` - Grok AI integration guide
  - `SQL_FORMATTING_FLOW_EXPLAINED.md` - End-to-end formatting architecture
- **User Guide Updates**:
  - Step 6a: SQL Formatting Preferences (200+ lines)
  - Step 8b: Format Button Integration (updated)
  - Typical workflow section (added SQL formatting)
- **Reference Guide Updates**:
  - Alphabetical index: Added SQL Formatting Preferences entry
  - Keyboard shortcuts: Added Ctrl+Shift+F
  - Q&A section: Added 6 SQL formatting questions
  - Tools menu reference: Added SQL Formatting Preferences
  - Added 3 new Q&A entries about Format - Clean vs Format - AI
- **Concise Guide Updates**:
  - Common tasks: Added "Configure SQL Formatting"
  - Top tips: Added Tip #6 about customization

---

## [1.5.7] - 2025-12-01
---

### Added
- **Database Object Size Analysis** - Right-click context menu for analyzing object complexity
  - New window displaying top 20 largest database objects by line count
  - Context menu item "📊 Analyze Object Sizes..." in Database Explorer
  - Non-modal window allows continued work while viewing results
  - Enhanced tooltip with feature description and benefits
  - Wait cursor feedback during data loading for large databases
  - Copy/Export functionality (clipboard, CSV export)
  - Professional DataGrid with sortable columns and alternating row colors
- **Advanced Line Counting Algorithm** - Accurate SQL code measurement
  - Handles CRLF and LF line endings correctly
  - Edge case handling for NULL and empty definitions
  - Excludes encrypted objects automatically
  - Returns `BIGINT` (Int64) results with safe conversion to Int32
  - Counts physical lines in stored procedures, functions, and views
- **SharedAIService Consolidation** - Eliminated AI logic redundancy across projects
  - Created `SharedAIService.cs` in `SODA_PLUS_DEPENDENCIES\Services` consolidating AI functionality from `ChartWindow.AIService.cs` and `AISessionService.cs`
  - Includes prompt building, API calls, response parsing, logging, and Mermaid processing
  - Centralized AI service for `ChartWindow`, `AISessionService`, and future consumers
- **WebView2 Formatted Display for ChartWindow** - Professional HTML rendering of AI dependency analysis
  - Added WebView2 tab "✨ Formatted View" to `ChartWindow.xaml` for displaying "Analysis Only (AI)" results
  - Enhanced HTML formatting with markdown-like parsing (headers, lists, bold text, code blocks)
  - Professional styling with responsive layout, color-coded sections, and typography
  - Asynchronous initialization with timeout handling and pending content queuing
- **Advanced HTML Formatting Engine** - Rich text rendering for dependency analysis
  - `FormatAnalysisAsHtml()` method with intelligent content parsing
  - Markdown-style header detection (`##`, `###`, `####`)
  - List parsing (bulleted and numbered)
  - Inline formatting (bold `**text**`, italic `_text_`, code `` `code` ``)
  - Special styling for "Pain Points" (warning blocks) and "Recommendations" (success blocks)
  - HTML encoding for security (prevents XSS)
- **Machine-Specific UI State Storage** - Window positions persist per machine for Citrix compatibility
  - Added `MachineName` column to `UserUIState` table (composite unique key with `UserId`)
  - Updated Azure Functions endpoints: `GET /api/uistate/{userId}/{machineName}`, `POST /api/uistate` with `MachineName` in payload
  - Client uses `Environment.MachineName` for automatic machine detection
  - URL encoding/decoding for machine names with special characters
  - Each machine (laptop, desktop, Citrix) maintains independent window state

### Changed
- **ChartWindow Architecture Refactoring** - Clean separation of AI and basic charting
  - Removed AI-specific regions from `ChartWindow.AIService.cs` (prompts, API calls, logging)
  - Kept only basic Mermaid processing for chart generation
  - Updated `ChartWindow.ChartGeneration.cs` to use `SharedAIService` for all AI operations
  - Added `SharedAIService` field and initialization in `ChartWindow.xaml.cs`
- **Service Consolidation** - Moved shared services to common project
  - Relocated `ApiService.cs` from `SODA_PLUS_CHARTING\Services` to `SODA_PLUS_DEPENDENCIES\Services`
  - Relocated `GrokKeyProvider.cs` from `SODA_PLUS_CHARTING\Services` to `SODA_PLUS_DEPENDENCIES\Services`
  - Updated all consuming code (`AISessionService.cs`, `SharedAIService.cs`) to reference new locations
- **Dependency Analysis Display** - Enhanced user experience for AI results
  - "Analysis Only (AI)" now displays in both plain text (Analysis tab) and formatted HTML (Formatted View tab)
  - Automatic tab switching to Analysis tab after generation
  - Formatted view shows structured dependency reports with visual hierarchy

### Fixed
- **InvalidCastException in Object Size Analysis** - Fixed type mismatch in line count query
  - Root cause: SQL Server `LEN()` returns `BIGINT` (Int64), code expected `INT` (Int32)
  - Solution: Changed from `reader.GetInt32(2)` to `Convert.ToInt32(reader.GetInt64(2))`
  - Impact: Window now loads successfully without casting errors
- **Tooltip Display Issues** - Context menu tooltips now appear correctly
  - Added `ToolTipService.ShowDuration="30000"` for 30-second display
  - Added `ToolTipService.InitialShowDelay="500"` for 0.5-second hover delay
  - Added `HasDropShadow="True"` for better tooltip visibility
  - WPF MenuItem tooltips now work reliably in ContextMenus
- **Build Compilation Errors** - Resolved all issues from WebView2 and service refactoring
  - Added missing `using System.Text;` for `StringBuilder`
  - Fixed HTML encoding order in `FormatInlineMarkdown()` (encode first, then format)
  - Added `using System.Diagnostics;` for `Debug` logging
  - Verified all namespace references and assembly dependencies
- **WebView2 Integration Issues** - Proper initialization and error handling
  - Asynchronous WebView2 setup with `EnsureCoreWebView2Async()`
  - Timeout handling (5-second limit) with graceful fallback
  - Pending content queuing for delayed initialization
  - Error logging without crashing the application

### Technical
- **Database Object Size Query** - SQL optimization and accuracy
  - Query returns top 20 objects by line count (DESC order)
  - Object types: Stored Procedures (P, PC, RF, X), Views (V), Functions (FN, IF, TF)
  - Line count calculation: `LEN(definition) - LEN(REPLACE(REPLACE(definition, CRLF, ''), LF, '')) + 1`
  - Excludes encrypted objects: `WHERE m.definition IS NOT NULL`
  - Result type: `BIGINT` (Int64) from SQL, converted to `Int32` in C#
- **Window Architecture** - Non-modal design for productivity
  - `DatabaseObjectSizeWindow.xaml` - WPF window with DataGrid
  - `DatabaseObjectSizeWindow.xaml.cs` - Async data loading with error handling
  - Blue header (DarkBlue) matching Database Explorer theme
  - Status bar with object count and close button
  - Connection string from `BuildConnectionStringForDatabase()` method
- **User Experience Enhancements**
  - Wait cursor (`Cursors.Wait`) during database query execution
  - Status messages: "Loading object data..." → "Loaded N objects"
  - Error handling with friendly MessageBox dialogs
  - Context menu in results grid: Copy Selected, Copy All, Export to CSV
  - CSV export with timestamp: `{DatabaseName}_ObjectSizes_{yyyyMMdd_HHmmss}.csv`
- **SharedAIService Architecture** - Centralized AI operations
  - Instance methods for prompt building (`BuildAIDependencyPrompt`, `BuildAILogicFlowchartPrompt`)
  - API interaction methods (`CallAIServiceAsync`, `GetApiKeyAsync`)
  - Response processing (`ExtractMermaidGraph`, `ExtractAnalysisSection`, etc.)
  - Logging integration (`LogUsageToDatabase`)
  - Static methods for utility functions (Mermaid processing, analysis)
- **WebView2 Implementation Details** - Professional HTML rendering
  - XAML namespace: `xmlns:wv2="clr-namespace:Microsoft.Web.WebView2.Wpf;assembly=Microsoft.Web.WebView2.Wpf"`
  - Control placement in "✨ Formatted View" tab with placeholder text
  - CSS styling with modern design (Segoe UI font, responsive layout, color schemes)
  - JavaScript-free implementation (pure HTML/CSS for security)
- **Project Dependencies** - Updated references for shared services
  - `SODA_PLUS_CHARTING.csproj` now references `SODA_PLUS_DEPENDENCIES` for `SharedAIService`
  - `SODA_PLUS_AI_REVIEW.csproj` updated to reference services from `SODA_PLUS_DEPENDENCIES`
  - NuGet package `Microsoft.Web.WebView2` added to `SODA_PLUS_CHARTING` project
- **Machine-Specific UI State Architecture** - Database schema and API changes
  - Database: Added `MachineName NVARCHAR(255) NOT NULL` column with composite unique key `(UserId, MachineName)`
  - Azure Functions: Updated `ICloudStorageService` and `CloudStorageService` with `machineName` parameter
  - Azure Endpoints: Modified routes and DTOs (`SaveUIStateRequest` now includes `MachineName`)
  - Client: `CloudSettingsService` uses `Environment.MachineName` with URL encoding
  - Files modified: `ICloudStorageService.cs`, `CloudStorageService.cs`, `UserUIStateFunctions.cs`, `CloudSettingsService.cs` (client)

### User Experience
- **Database Object Size Analysis Workflow**:
  1. Navigate to Database Explorer
  2. Select a database from the list
  3. Right-click on the database name
  4. Select "📊 Analyze Object Sizes..."
  5. Window opens showing top 20 largest objects
  6. Results displayed with object type, name, and line count
  7. Sort by clicking column headers
  8. Copy selected rows or export to CSV
  9. Window stays open (non-modal) - continue working
- **Productivity Benefits**:
  - Identify complex objects that may need refactoring
  - Quick assessment of database code complexity
  - Export results for documentation or analysis
  - 10x faster than manual SSMS queries (< 5 seconds vs 30-45 seconds)
- **Enhanced Dependency Analysis Viewing** - Multiple display options
  - Plain text view (existing Analysis tab) for raw AI responses
  - Formatted HTML view (new Formatted View tab) for professional presentation
  - Automatic switching to Analysis tab after generation
  - Formatted view loads asynchronously with progress indication
- **Improved Readability** - Structured presentation of complex analysis
  - Hierarchical headers for different analysis sections
  - Color-coded blocks for pain points (red warnings) and recommendations (green success)
  - Proper list formatting for multiple items
  - Code syntax highlighting for SQL snippets
  - Responsive design that works in different window sizes
- **Machine-Specific Window State** - Seamless multi-device experience
  - Each machine (laptop, desktop, Citrix) remembers its own window position/size
  - No conflicts when logging in from different machines
  - Window state restored automatically per machine on next login

### Performance
- **Efficient Query Execution** - Fast results even for large databases
  - SQL query limited to top 20 objects (minimal data transfer)
  - Async execution with `Task.Run()` (non-blocking UI)
  - Connection timeout: 30 seconds (configurable)
  - Wait cursor provides visual feedback
  - DataGrid virtualization for smooth scrolling
- **Efficient HTML Generation** - Fast rendering of analysis results
  - Line-by-line parsing of AI responses (handles large outputs)
  - Minimal DOM manipulation (single `NavigateToString` call)
  - Asynchronous WebView2 initialization (non-blocking UI)
  - Memory-efficient string processing with `StringBuilder`

### Documentation
- **New Documentation Files Created**:
  - `SODA_PLUS_MAIN/FEATURE_DATABASE_OBJECT_SIZE_ANALYSIS.md` - Complete feature documentation
    - Implementation summary with all requirements met
    - Step-by-step usage workflow
    - Technical details (SQL query, architecture)
    - User experience comparison (before/after)
    - Testing checklist
    - Example output and screenshots
  - `IMPLEMENTATION_SUMMARY_MachineName_UserUIState.md` - Machine-specific UI state implementation guide
    - Database migration scripts
    - API endpoint changes
    - Client integration details
    - Testing scenarios for multi-machine environments
  - Feature fully documented with examples and troubleshooting

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
- **Database Object Size Analysis Workflow**:
  1. Navigate to Database Explorer
  2. Select a database from the list
  3. Right-click on the database name
  4. Select "📊 Analyze Object Sizes..."
  5. Window opens showing top 20 largest objects
  6. Results displayed with object type, name, and line count
  7. Sort by clicking column headers
  8. Copy selected rows or export to CSV
  9. Window stays open (non-modal) - continue working
- **Productivity Benefits**:
  - Identify complex objects that may need refactoring
  - Quick assessment of database code complexity
  - Export results for documentation or analysis
  - 10x faster than manual SSMS queries (< 5 seconds vs 30-45 seconds)
- **Enhanced Dependency Analysis Viewing** - Multiple display options
  - Plain text view (existing Analysis tab) for raw AI responses
  - Formatted HTML view (new Formatted View tab) for professional presentation
  - Automatic switching to Analysis tab after generation
  - Formatted view loads asynchronously with progress indication
- **Improved Readability** - Structured presentation of complex analysis
  - Hierarchical headers for different analysis sections
  - Color-coded blocks for pain points (red warnings) and recommendations (green success)
  - Proper list formatting for multiple items
  - Code syntax highlighting for SQL snippets
  - Responsive design that works in different window sizes
- **Machine-Specific Window State** - Seamless multi-device experience
  - Each machine (laptop, desktop, Citrix) remembers its own window position/size
  - No conflicts when logging in from different machines
  - Window state restored automatically per machine on next login

### Performance
- **Efficient Query Execution** - Fast results even for large databases
  - SQL query limited to top 20 objects (minimal data transfer)
  - Async execution with `Task.Run()` (non-blocking UI)
  - Connection timeout: 30 seconds (configurable)
  - Wait cursor provides visual feedback
  - DataGrid virtualization for smooth scrolling
- **Efficient HTML Generation** - Fast rendering of analysis results
  - Line-by-line parsing of AI responses (handles large outputs)
  - Minimal DOM manipulation (single `NavigateToString` call)
  - Asynchronous WebView2 initialization (non-blocking UI)
  - Memory-efficient string processing with `StringBuilder`

### Security
- **Connection String Security** - Reuses existing infrastructure
  - Uses `BuildConnectionStringForDatabase()` from MainShell
  - Inherits authentication from ServerConfig (Windows or SQL Auth)
  - Encrypted password support via Windows DPAPI
  - TrustServerCertificate settings respected
  - No credential exposure in window or exports
- **HTML Sanitization** - Safe rendering of AI-generated content
  - `System.Net.WebUtility.HtmlEncode()` prevents XSS attacks
  - No JavaScript execution in WebView2 (security boundary)
  - Safe handling of special characters in dependency names and SQL code

### Documentation
- **New Documentation Files Created**:
  - `SODA_PLUS_MAIN/FEATURE_DATABASE_OBJECT_SIZE_ANALYSIS.md` - Complete feature documentation
    - Implementation summary with all requirements met
    - Step-by-step usage workflow
    - Technical details (SQL query, architecture)
    - User experience comparison (before/after)
    - Testing checklist
    - Example output and screenshots
  - `IMPLEMENTATION_SUMMARY_MachineName_UserUIState.md` - Machine-specific UI state implementation guide
    - Database migration scripts
    - API endpoint changes
    - Client integration details
    - Testing scenarios for multi-machine environments
  - Feature fully documented with examples and troubleshooting

---

## Links

- [1.6.0] - https://github.com/jcboyer/SODA_PLUS_AI_PRE_PROD/compare/v1.5.7...v1.6.0
- [1.5.7] - https://github.com/jcboyer/SODA_PLUS_AI_PRE_PROD/compare/v1.5.6...v1.5.7
- [1.5.6] - https://github.com/jcboyer/SODA_PLUS_AI_PRE_PROD/compare/v1.5.5...v1.5.6
- [1.5.5] - https://github.com/jcboyer/SODA_PLUS_AI_PRE_PROD/compare/v1.5.2...v1.5.5
- [1.5.2] - https://github.com/jcboyer/SODA_PLUS_AI_PRE_PROD/compare/v1.5.1...v1.5.2
- [1.5.1] - https://github.com/jcboyer/SODA_PLUS_AI_PRE_PROD/compare/v1.5.0-beta...v1.5.1
- [1.5.0-beta] - https://github.com/jcboyer/SODA_PLUS_AI_PRE_PROD/releases/tag/v1.5.0-beta
- [1.1.0-beta] - https://github.com/jcboyer/SODA_PLUS_AI_PRE_PROD/releases/tag/v1.1.0-beta
- [1.0.0-beta] - https://github.com/jcboyer/SODA_PLUS_AI_PRE_PROD/releases/tag/v1.0.0-beta
- [Unreleased] - https://github.com/jcboyer/SODA_PLUS_AI_PRE_PROD/compare/v1.6.0...HEAD

---

**Maintained by:** Jerome Boyer  
**Last Updated:** 2025-12-23
**Repository:** https://github.com/jcboyer/SODA_PLUS_AI_PRE_PROD
