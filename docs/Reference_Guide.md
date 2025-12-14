# 🔍 SODA PLUS - Reference Guide
## Quick Lookup for Features, Commands & Shortcuts

---

**Version:** 1.5.2 | **Last Updated:** November 13, 2025  
**Target Audience:** All Users | **Use Case:** Quick Feature Lookup

---

## 📑 **Table of Contents**

1. [About This Guide](#about-this-guide)
2. [Alphabetical Feature Index](#alphabetical-feature-index)
3. [Keyboard Shortcuts](#keyboard-shortcuts)
4. [Right-Click Context Menus](#right-click-context-menus)
5. [Toolbar Button Reference](#toolbar-button-reference)
6. [Analysis Type Quick Reference](#analysis-type-quick-reference)
7. [Export Format Reference](#export-format-reference)
8. [Chart Type Comparison](#chart-type-comparison)
9. [Common Error Messages](#common-error-messages)
10. [Configuration File Reference](#configuration-file-reference)

---

## About This Guide

This is your **quick lookup reference** for SODA PLUS features. Use it to:
- ✅ Find features alphabetically
- ✅ Look up keyboard shortcuts
- ✅ Check context menu options
- ✅ Compare analysis types
- ✅ Troubleshoot errors

**For detailed instructions**, see the [Full User Guide](SODA_PLUS_User_Guide.md).

---

## Alphabetical Feature Index

### A

**Add Server**
- **Location:** Right-click Server Explorer → Add Server...
- **Shortcut:** Double-click "+ Add Server..." node
- **See:** [Step 3: Connect to Servers](SODA_PLUS_User_Guide.md#step-3-connect-to-servers-enhanced)

**AI Analysis**
- **Location:** Right-click Procedure/Function → AI Analysis
- **Types:** Summary, Improvements, Security, Performance, Best Practices
- **See:** [Step 9: AI Code Analysis](SODA_PLUS_User_Guide.md#step-9-ai-code-analysis---new-enhanced-workflow-)

**AI Review Button** (Toolbar)
- **Location:** Dependency Analyzer toolbar (left side)
- **Action:** Opens AI Review window with SQL code pre-loaded
- **Icon:** 🤖
- **See:** [Step 8b: Toolbar Actions](SODA_PLUS_User_Guide.md#step-8b-dependency-analyzer-toolbar-actions-new)

**Analyze Dependencies**
- **Location:** Right-click any object → Analyze Dependencies
- **Shortcut:** Single-click object, then Analyze menu
- **See:** [Step 7: Analyze Database Objects](SODA_PLUS_User_Guide.md#step-7-analyze-database-objects-enhanced)

**Auto-Login**
- **Feature:** Automatic login from saved session
- **File:** `%APPDATA%\SODA_PLUS\user_session.dat`
- **See:** [Step 0: Initial Login](SODA_PLUS_User_Guide.md#step-0-initial-login--registration-new)

### B

**Best Practices Analysis**
- **Type:** AI Analysis option
- **Focus:** Code quality, standards, documentation
- **See:** [Step 11: AI Analysis Types](SODA_PLUS_User_Guide.md#step-11-working-with-ai-analysis-types)

**Breadcrumb** (Code Viewer)
- **Location:** Above code editor in right panel
- **Shows:** Server.Database.Schema.Object path
- **See:** [Step 8: RIGHT PANEL](SODA_PLUS_User_Guide.md#right-panel-sql-code-viewer)

### C

**Call Order Tab**
- **Location:** Left panel sub-tab in analyzer
- **Action:** Shows execution order of dependencies
- **Button:** "Generate Call Order"
- **See:** [Step 8: Call Order Sub-Tab](SODA_PLUS_User_Guide.md#3--call-order-sub-tab)

**Chart Analysis**
- **Location:** Right-click Procedure/Function/View → Chart Analysis
- **Types:** Quick Chart, AI-Enhanced Chart, Logic Flowchart
- **See:** [Step 10: Dependency Charting](SODA_PLUS_User_Guide.md#step-10-dependency-charting-new-)

**Chart Button** (Toolbar)
- **Location:** Dependency Analyzer toolbar
- **Action:** Opens chart window with current analyzer data
- **Icon:** 📊
- **See:** [Step 8b: Chart Button](SODA_PLUS_User_Guide.md#-chart-button)

**Chart Direction** ⭐ NEW!
- **Location:** Chart Window toolbar
- **Options:** Downstream (default), Upstream
- **Action:** Controls which dependencies are shown in chart
- **See:** [Chart Window: Direction Options](#c)

**Clear Chart** ⭐ NEW!
- **Location:** Chart Window → File menu → Clear Chart
- **Action:** Clears current chart with confirmation
- **See:** [Chart Window Toolbar](#chart-window-toolbar)

**Close Application Button**
- **Location:** Environment Status Bar (top-right)
- **Action:** Closes entire application and all windows
- **Color:** Red button
- **See:** [Main Interface: Environment Status Bar](SODA_PLUS_User_Guide.md#environment-status-bar-new)

**Copy Name**
- **Location:** Right-click any object → Copy Name
- **Action:** Copies fully-qualified object name to clipboard
- **Format:** `[Schema].[ObjectName]`

**Cross-Database Search** ⭐ NEW!
- **Location:** Search menu → Search Current Server / Search All Servers
- **Shortcut:** Ctrl+F
- **Action:** Search across multiple databases and servers simultaneously
- **Features:** 
  - Search by object name or code content
  - 20x faster (parallel processing)
  - AI-powered relevance filtering
  - Multi-server support
- **See:** [Cross-Database Search Guide](SODA_PLUS_Search_Guide.md)

**Custom Prompts**
- **Location:** Bottom of AI Review window
- **Action:** Send custom questions to AI
- **Button:** "🚀 Send Custom"
- **See:** [Step 12: Custom Prompts](SODA_PLUS_User_Guide.md#custom-prompts)

### D

**Database Explorer**
- **Location:** Middle-left panel
- **Shows:** Databases on selected server
- **Action:** Click database to load objects
- **See:** [Step 5: Select a Database](SODA_PLUS_User_Guide.md#step-5-select-a-database)

**Dependency Analyzer**
- **Component:** Main analysis control with tabs
- **Panels:** Left (sub-tabs), Right (code viewer)
- **See:** [Step 8: Review Analysis Results](SODA_PLUS_User_Guide.md#step-8-review-analysis-results)

**Dependency Direction** ⭐ NEW!
- **Location:** Chart Window toolbar (ComboBox)
- **Default:** Downstream (what object depends on)
- **Options:** Downstream, Upstream
- **Use:** Control which dependencies appear in chart
- **See:** [Chart Window: Direction Options](#c)

**Depth Setting**
- **Location:** Analyzer toolbar (numeric spinner)
- **Default:** 3 levels
- **Range:** 1-10
- **Per-tab:** Each analyzer tab has independent depth

**Downstream Dependencies**
- **Tab:** Sub-tab in left panel
- **Shows:** Objects that depend ON selected object
- **Use:** Impact analysis before changes
- **See:** [Step 8: Downstream Sub-Tab](SODA_PLUS_User_Guide.md#1--downstream-dependencies-sub-tab)

**Drill-Down Analysis**
- **Action:** Right-click dependency → Analyze Dependencies
- **Result:** Opens new tab for that object
- **See:** [Step 8a: Drill-Down](SODA_PLUS_User_Guide.md#step-8a-drill-down-dependency-analysis-new)

### E

**Environment Selection**
- **Options:** SANDBOX (green), TEST (orange), PROD (red)
- **When:** On application startup
- **Locked:** Per session (restart to change)
- **See:** [Step 2: Environment Selection](SODA_PLUS_User_Guide.md#step-2-environment-selection)

**Export Button** (Toolbar)
- **Location:** Dependency Analyzer toolbar
- **Formats:** CSV, JSON, Markdown, Text
- **Icon:** 💾
- **See:** [Step 8b: Export Button](SODA_PLUS_User_Guide.md#-export-button-new)

**Export Definition**
- **Location:** Right-click any object → Export Definition
- **Format:** SQL DDL script
- **Use:** Backup or documentation

### F

**File Menu** ⭐ NEW!
- **Location:** Chart Window toolbar
- **Action:** Dropdown menu for file operations
- **Options:** Save Mermaid, Load Mermaid, Copy to Clipboard, Clear Chart
- **See:** [Chart Window Toolbar](#chart-window-toolbar)

**Formatted View Tab**
- **Location:** AI Review window (3rd tab)
- **Features:** HTML rendering, syntax highlighting, collapsible sections
- **See:** [Step 9: Formatted View](SODA_PLUS_User_Guide.md#-formatted-view-tab---new-)

**Full Window Button** (Toolbar)
- **Location:** Dependency Analyzer toolbar (far right)
- **Action:** Opens standalone analyzer window
- **Icon:** 📺
- **See:** [Step 8b: Full Window Button](SODA_PLUS_User_Guide.md#-full-window-button-new)

**Functions** (Object Type)
- **Location:** Object Explorer → Functions
- **Analysis:** Dependencies, AI, Charting available
- **Color:** Red in dependency trees

### L

**Load Mermaid** ⭐ NEW!
- **Location:** Chart Window → File menu → Load Mermaid (.mmd)
- **Action:** Loads Mermaid chart from .mmd file
- **Validation:** Checks for valid Mermaid syntax
- **See:** [Chart Window Toolbar](#chart-window-toolbar)

**Login**
- **When:** First launch or after logout
- **Required:** Email address
- **See:** [Step 0: Login Process](SODA_PLUS_User_Guide.md#login-process)

**Logic Flowchart**
- **Type:** Chart option for control flow visualization
- **Available For:** Procedures, Functions, Views
- **See:** [Step 10: Logic Flowchart](SODA_PLUS_User_Guide.md#-logic-flowchart---control-flow-visualization)

### M

**Messages Panel**
- **Location:** Bottom of main window
- **Shows:** Real-time feedback, errors, operations
- **Toggle:** View → Toggle Messages
- **See:** [Advanced Features: Message Panel](SODA_PLUS_User_Guide.md#message-panel)

**Multi-Tab Architecture**
- **Feature:** Multiple analyzer tabs (max 10)
- **Switch:** Click tab header or Ctrl+Tab
- **See:** [Step 8: Multi-Tab Architecture](SODA_PLUS_User_Guide.md#dependency-analysis---multi-tab-architecture)

### O

**Object Explorer**
- **Location:** Bottom-left panel
- **Shows:** Tables, Views, Procedures, Functions
- **Search:** 🔍 Search box above tree
- **See:** [Step 6: Search for Objects](SODA_PLUS_User_Guide.md#step-6-search-for-objects-new-)

**Object Search**
- **Location:** Above Object Explorer tree
- **Features:** Real-time filtering, auto-expand, smart matching
- **Clear:** Click ✖ or press Escape
- **See:** [Step 6: Object Search](SODA_PLUS_User_Guide.md#step-6-search-for-objects-new-)

**Open in SSMS** ⭐ NEW!
- **Location:** Dependency Analyzer toolbar (after Export button)
- **Icon:** 📤
- **Action:** Automatically opens SQL code in SSMS query window
- **Features:**
  - One-click automation (Ctrl+N, Ctrl+V sent automatically)
  - Preserves existing SSMS connection (no certificate errors)
  - Auto-adds USE statement with database context
  - Detects SSMS 18, 19, 20, 21+ (prefers newest)
  - Creates temp .sql file with timestamp
  - Graceful fallback if automation fails
- **Requirements:** SSMS must be installed
- **Time Saved:** 10x faster than manual workflow (45s → 5s)
- **See:** [SSMS Integration](#a)

**Open SVG**
- **Location:** Chart Window toolbar → Output menu
- **Icon:** 📂
- **Action:** Opens rendered SVG file in default viewer
- **See:** [Chart Window Toolbar](#chart-window-toolbar)

### P

**Performance Analysis**
- **Type:** AI Analysis option
- **Focus:** Bottlenecks, indexes, query optimization
- **See:** [Step 11: Performance Analysis](SODA_PLUS_User_Guide.md#performance-analysis)

**Procedures** (Object Type)
- **Location:** Object Explorer → Stored Procedures
- **Analysis:** Dependencies, AI, Charting available
- **Color:** Purple in dependency trees

### Q

**Quick Chart**
- **Type:** Fast dependency visualization (< 1 sec)
- **No AI:** Uses database metadata only
- **Available For:** Procedures, Functions, Views
- **See:** [Step 10: Quick Chart](SODA_PLUS_User_Guide.md#-quick-chart-self-contained---recommended-for-most-scenarios)

### R

**Reference Guide**
- **Document:** This guide!
- **Use:** Quick feature lookup
- **Format:** Alphabetical index

**Refactoring Suggestions**
- **Type:** AI Analysis option
- **Focus:** Code restructuring, complexity reduction
- **See:** [Step 11: Refactoring](SODA_PLUS_User_Guide.md#refactoring-suggestions)

**Registration**
- **When:** First-time users
- **Required:** Email, Display Name
- **See:** [Step 0: Registration Process](SODA_PLUS_User_Guide.md#registration-process)

**Remove Server**
- **Location:** Right-click server → Remove Server
- **Scope:** Per-environment only
- **Warning:** Cannot undo

### S

**Save SVG As...** ⭐ NEW!
- **Location:** Chart Window → Output menu → Save SVG As...
- **Action:** Saves rendered SVG to custom location
- **Requires:** SVG must be rendered first
- **See:** [Chart Window Toolbar](#chart-window-toolbar)

**Security Analysis**
- **Type:** AI Analysis option
- **Focus:** SQL injection, permissions, vulnerabilities
- **See:** [Step 11: Security Analysis](SODA_PLUS_User_Guide.md#security-analysis)

**Server Explorer**
- **Location:** Top-left panel
- **Shows:** SQL Servers in current environment
- **Add:** Right-click → Add Server...
- **See:** [Step 3: Connect to Servers](SODA_PLUS_User_Guide.md#step-3-connect-to-servers-enhanced)

**Session Management**
- **Auto-Login:** From saved session file
- **File:** `%APPDATA%\SODA_PLUS\user_session.dat`
- **Encryption:** Windows DPAPI
- **See:** [Step 0: Session Features](SODA_PLUS_User_Guide.md#session-features)

**SQL Code Viewer**
- **Location:** Right panel in analyzer
- **Features:** Syntax highlighting, search, breadcrumb
- **Updates:** Dynamically when selecting dependencies
- **See:** [Step 8: RIGHT PANEL](SODA_PLUS_User_Guide.md#right-panel-sql-code-viewer)

**Summary Analysis**
- **Type:** AI Analysis option
- **Focus:** Quick overview, key observations
- **See:** [Step 11: Summary Analysis](SODA_PLUS_User_Guide.md#summary-analysis)

### T

**Tables** (Object Type)
- **Location:** Object Explorer → Tables
- **Analysis:** Dependencies, Charting (no AI)
- **Color:** Blue in dependency trees

**Tabs** (Analyzer)
- **Max:** 10 tabs simultaneously
- **Switch:** Ctrl+Tab or click tab header
- **Close:** Click ✖ on tab
- **See:** [Step 8: Managing Tabs](SODA_PLUS_User_Guide.md#managing-multiple-analyzer-tabs)

**Test Connection**
- **Location:** Add Server dialog
- **Button:** 🔌 Test Connection
- **Shows:** Server version, edition on success

### U

**Upstream Dependencies**
- **Tab:** Sub-tab in left panel
- **Shows:** Objects that selected object depends ON
- **Use:** Understanding requirements
- **See:** [Step 8: Upstream Sub-Tab](SODA_PLUS_User_Guide.md#2--upstream-dependencies-sub-tab)

### V

**Views** (Object Type)
- **Location:** Object Explorer → Views
- **Analysis:** Dependencies, Charting (no AI)
- **Color:** Orange in dependency trees
- **Charting:** All 3 chart types now supported

### W

**Windows Authentication**
- **Type:** SQL Server connection option (default)
- **Recommended:** Yes, most secure
- **Storage:** No password needed
- **See:** [Step 3: Authentication](SODA_PLUS_User_Guide.md#option-1-windows-authentication-default)

---

## Keyboard Shortcuts

### **Global (Main Window)**

| Shortcut | Action | Context |
|----------|--------|---------|
| **F1** | Toggle Server Explorer | Any |
| **F2** | Toggle Database Explorer | Any |
| **F3** | Toggle Object Explorer | Any |
| **Ctrl+F** | Open Cross-Database Search | Any ⭐ NEW! |
| **Ctrl+Tab** | Cycle through analyzer tabs | Analyzer tabs open |
| **Alt+F4** | Close application | Any |

### **Analyzer Window**

| Shortcut | Action | Context |
|----------|--------|---------|
| **Ctrl+Tab** | Cycle through main tabs | Multiple tabs open |
| **Ctrl+F** | Search in code | Code viewer focused |
| **Escape** | Clear search | Object search focused |

### **AI Review Window**

| Shortcut | Action | Tab |
|----------|--------|-----|
| **Ctrl+C** | Copy selected text | AI Response |
| **Ctrl+S** | Save session | Any |
| **Alt+F4** | Close window | Any |
| **Ctrl+Tab** | Cycle through tabs | Any |
| **Ctrl+F** | Browser search | Formatted View |
| **Enter** | Custom search | Formatted View |

### **Chart Window**

| Shortcut | Action | Context |
|----------|--------|---------|
| **Ctrl+S** | Save .mmd file | File menu active |
| **Ctrl+L** | Load .mmd file | File menu active ⭐ NEW! |
| **Ctrl+C** | Copy Mermaid code | Mermaid Code tab |
| **Alt+F4** | Close window | Any |
| **Alt+F** | Open File menu | Any ⭐ NEW! |
| **Alt+O** | Open Output menu | Any ⭐ NEW! |

---

## Right-Click Context Menus

### **Server Explorer (Servers)**

**Right-click server:**
- Add Server...
- Remove Server
- ─────────
- Test Connection

### **Object Explorer (Objects)**

**Right-click Procedure/Function:**
- 🔍 Analyze Dependencies
- 🤖 AI Analysis
  - Summary
  - Low Hanging Improvements
  - Deeper Improvements (1-4)
  - Security Analysis
  - Performance Analysis
  - Best Practices
  - Refactoring
- 📊 Chart Analysis
  - Quick Chart
  - AI-Enhanced Chart
  - Logic Flowchart
- 📤 Export Definition
- 📋 Copy Name

**Right-click Table:**
- 🔍 Analyze Dependencies
- 📊 Chart Analysis (Quick Chart only)
- 📤 Export Definition
- 📋 Copy Name

**Right-click View:**
- 🔍 Analyze Dependencies
- 📊 Chart Analysis
  - Quick Chart
  - AI-Enhanced Chart
  - Logic Flowchart
- 📤 Export Definition
- 📋 Copy Name

### **Dependency Trees (Analyzer)**

**Right-click dependency node:**
- Analyze Dependencies
- AI Review (Procedures/Functions only)
- Generate Chart
- Copy Name

### **Messages Panel**

**Right-click messages:**
- Copy All Messages
- Clear Messages

---

## Toolbar Button Reference

### **Dependency Analyzer Toolbar**

| Button | Icon | Action | When Visible |
|--------|------|--------|--------------|
| **AI Review** | 🤖 | Opens AI Review window with SQL code | Procedures/Functions only |
| **Chart** | 📊 | Opens chart window with current data | Always |
| **Export** | 💾 | Exports dependencies in 4 formats | Always |
| **Open in SSMS** | 📤 | Auto-opens code in SSMS query window | Always ⭐ NEW! |
| **Full Window** | 📺 | Opens standalone analyzer window | Always |
| **Depth** | 1-10 | Sets dependency depth | Always |

### **Chart Window Toolbar**

| Button/Menu | Icon | Action | When Enabled |
|-------------|------|--------|--------------|
| **Chart Type** | ▼ | Select chart generation mode | Always |
| **Direction** | ⬇️⬆️ | Select dependency direction (Downstream/Upstream) | Always ⭐ NEW! |
| **Depth** | 1-10 | Shows dependency depth from Analyzer | Always (read-only) |
| **Generate Chart** | 📊 | Creates chart based on selected type | Always |
| **File Menu** | 📁 ▼ | File operations dropdown | Always ⭐ NEW! |
| - Save Mermaid (.mmd) | 💾 | Saves Mermaid source code | After generation |
| - Load Mermaid (.mmd) | 📂 | Loads Mermaid from file | Always ⭐ NEW! |
| - Copy to Clipboard | 📋 | Copies Mermaid code | After generation |
| - Clear Chart | 🗑️ | Clears current chart | After generation ⭐ NEW! |
| **Output Menu** | 🖼️ ▼ | Output operations dropdown | Always ⭐ NEW! |
| - Render to SVG | 🎨 | Creates SVG graphic | After generation |
| - Open SVG | 📂 | Views SVG in browser | After render |
| - Save SVG As... | 💾 | Saves SVG to custom location | After render ⭐ NEW! |
| **Close** | ✖ | Closes chart window | Always |

### **Chart Type Options**

| Type | Speed | AI Required | Best For |
|------|-------|-------------|----------|
| **Dependency (Quick)** | < 1 sec | ❌ No | Quick dependency checks |
| **Dependency (AI)** | 5-30 sec | ✅ Yes | Complex dependencies, presentations |
| **Flow Chart (AI)** | 10-45 sec | ✅ Yes | Understanding procedure/function logic |

### **Direction Options** ⭐ NEW!

| Direction | Shows | Use Case |
|-----------|-------|----------|
| **⬇️ Downstream** | What this object depends on (references) | Understanding requirements |
| **⬆️ Upstream** | What depends on this object (referenced by) | Impact analysis before changes |

---

## Analysis Type Quick Reference

### **AI Analysis Types**

| Type | Focus | Output | Auto-Refactor Tab |
|------|-------|--------|-------------------|
| **Summary** | Quick overview | Observations, structure | ❌ No |
| **Low Hanging** | Easy wins | Quick improvements | ✅ Yes |
| **Deeper 1-4** | Progressive depth | Foundational to expert | ✅ Yes |
| **Security** | Vulnerabilities | SQL injection, permissions | ✅ Yes |
| **Performance** | Optimization | Bottlenecks, indexes | ✅ Yes |
| **Best Practices** | Code quality | Standards, maintainability | ✅ Yes |
| **Refactoring** | Restructuring | Complexity reduction | ✅ Yes |

### **Chart Types**

| Type | Speed | Cost | Offline | Best For |
|------|-------|------|---------|----------|
| **Quick Chart** | < 1 sec | Free | ✅ Yes | Quick checks, simple objects |
| **AI-Enhanced** | 5-30 sec | API credits | ❌ No | Complex dependencies, documentation |
| **Logic Flowchart** | 5-30 sec | API credits | ❌ No | Control flow, decision logic |

---

## Export Format Reference

### **Export Formats (From Analyzer)**

| Format | Extension | Best For | Preserves |
|--------|-----------|----------|-----------|
| **CSV** | .csv | Excel analysis | Hierarchy (flattened) |
| **JSON** | .json | API integration | Full hierarchy |
| **Markdown** | .md | GitHub/Confluence | Readable hierarchy |
| **Text** | .txt | Email/reports | Simple list |

### **Export Fields**

All exports include:
- Object Name
- Object Type
- Schema
- Dependency Level
- Dependency Type (Upstream/Downstream)
- Parent Object (for hierarchy)

---

## Chart Type Comparison

| Feature | Quick Chart | AI-Enhanced | Logic Flowchart |
|---------|-------------|-------------|-----------------|
| **Speed** | < 1 second | 5-30 seconds | 5-30 seconds |
| **Cost** | Free | Uses API credits | Uses API credits |
| **Offline** | ✅ Yes | ❌ No | ❌ No |
| **Dependencies** | ✅ Direct only | ✅ Multi-level | Partial |
| **SQL Analysis** | ❌ No | ✅ Yes | ✅ Yes |
| **Control Flow** | ❌ No | Partial | ✅ Yes |
| **Layout** | Basic | AI-optimized | AI-optimized |
| **Direction Control** | ✅ Yes ⭐ NEW! | ✅ Yes ⭐ NEW! | N/A |
| **Procedures** | ✅ Yes | ✅ Yes | ✅ Yes |
| **Functions** | ✅ Yes | ✅ Yes | ✅ Yes |
| **Views** | ✅ Yes | ✅ Yes | ✅ Yes |
| **Tables** | ❌ No charts for tables | ❌ No | ❌ No |
| **File Operations** | ✅ Save, Load ⭐ NEW! | ✅ Save, Load ⭐ NEW! | ✅ Save, Load ⭐ NEW! |

---

## Common Error Messages

### **Connection Errors**

**Error:** "Cannot connect to server"
- **Cause:** Server name incorrect or server offline
- **Solution:** Verify server name, check SQL Server is running
- **See:** [Step 3: Adding Server](SODA_PLUS_User_Guide.md#step-3-connect-to-servers-enhanced)

**Error:** "Login failed for user"
- **Cause:** Authentication credentials incorrect
- **Solution:** Try Windows Authentication, verify SQL login
- **See:** [Step 3: Authentication](SODA_PLUS_User_Guide.md#authentication-section)

**Error:** "Trust server certificate required"
- **Cause:** Self-signed certificate not trusted
- **Solution:** Enable "Trust server certificate" in connection options
- **See:** [Step 3: Connection Options](SODA_PLUS_User_Guide.md#connection-options)

### **Analysis Errors**

**Error:** "No SQL code available for AI analysis"
- **Cause:** Object definition cannot be retrieved
- **Solution:** Verify permissions, check object exists
- **See:** [Step 10: Troubleshooting Charts](SODA_PLUS_User_Guide.md#troubleshooting-charts)

**Error:** "Maximum 10 tabs reached"
- **Cause:** Too many analyzer tabs open
- **Solution:** Close unused tabs with ✖ button
- **See:** [Step 8: Managing Tabs](SODA_PLUS_User_Guide.md#managing-multiple-analyzer-tabs)

**Error:** "API key unavailable"
- **Cause:** AI features require API key configuration
- **Solution:** Contact administrator or register for API key
- **See:** [Step 0: Troubleshooting Login](SODA_PLUS_User_Guide.md#troubleshooting-login)

### **Chart Errors**

**Error:** "Render failed - SVG file not created"
- **Cause:** MermaidRenderer.exe not found or Mermaid code invalid
- **Solution:** Check installation, verify Mermaid syntax
- **See:** [Step 10: Troubleshooting Charts](SODA_PLUS_User_Guide.md#troubleshooting-charts)

**Error:** "WebView2 initialization failed"
- **Cause:** WebView2 Runtime not installed
- **Solution:** Install [Microsoft Edge WebView2 Runtime](https://go.microsoft.com/fwlink/p/?LinkId=2124703)
- **See:** [Step 9: Troubleshooting Formatted View](SODA_PLUS_User_Guide.md#troubleshooting-formatted-view)

### **Session Errors**

**Error:** "User not found"
- **Cause:** Email not registered
- **Solution:** Register first using Register tab
- **See:** [Step 0: Registration](SODA_PLUS_User_Guide.md#registration-process)

**Error:** "No API keys available"
- **Cause:** All API keys assigned
- **Solution:** Contact administrator to add more keys
- **See:** [Step 0: Troubleshooting Login](SODA_PLUS_User_Guide.md#troubleshooting-login)

**Error:** "Session file corrupted"
- **Cause:** Session file damaged
- **Solution:** Delete `%APPDATA%\SODA_PLUS\user_session.dat`, re-login
- **See:** [Step 0: Troubleshooting Login](SODA_PLUS_User_Guide.md#troubleshooting-login)

### **Search Errors** ⭐ NEW!

**Error:** "Cross-database search returned no results"
- **Cause:** No objects match search criteria or no databases selected
- **Solution:** 
  - Check at least one database is selected
  - Verify object types are checked (Tables/Views/Procedures/Functions)
  - Try broader search term
  - Enable "Search inside code" for comprehensive search
- **See:** [Cross-Database Search Guide](SODA_PLUS_Search_Guide.md)

**Error:** "Multi-server search failed on some servers"
- **Cause:** Connection or permission issues on specific servers
- **Solution:**
  - Check error message in results window
  - Verify connection to failed servers
  - Test authentication settings
  - Partial results from successful servers still available
- **See:** [Cross-Database Search Guide](SODA_PLUS_Search_Guide.md)

**Error:** "AI filtering unavailable"
- **Cause:** No valid user session or Grok API key not assigned
- **Solution:**
  - Check you're logged in with valid session
  - Verify "Search inside code" is enabled (required for AI filtering)
  - Contact administrator to verify API key assignment
- **See:** [Cross-Database Search Guide](SODA_PLUS_Search_Guide.md)

**Error:** "Permission denied accessing database"
- **Cause:** User lacks VIEW DEFINITION permission on database
- **Solution:**
  - Contact database administrator
  - Request VIEW DEFINITION permission
  - Or exclude that database from search
- **See:** [Cross-Database Search Guide](SODA_PLUS_Search_Guide.md)

---

## Configuration File Reference

### **User Configuration File**

**Location:** `%APPDATA%\SODA_PLUS\appsettings.user.json`

**Structure:**
```json
{
  "Environments": {
    "SANDBOX": {
      "DisplayName": "Sandbox Environment",
      "Servers": [
        {
          "DataSource": "localhost\\SQLEXPRESS",
          "DisplayName": "Local Dev Server",
          "AuthenticationType": "Windows",
          "TrustServerCertificate": true,
          "ConnectTimeout": 30,
          "IsActive": true
        }
      ]
    },
    "TEST": { ... },
    "PROD": { ... }
  }
}
```

**Fields:**
- `DataSource`: SQL Server instance name
- `DisplayName`: Friendly server name
- `AuthenticationType`: "Windows" or "SqlServer"
- `Username`: SQL login (if SqlServer auth)
- `EncryptedPassword`: DPAPI-encrypted password
- `TrustServerCertificate`: Allow self-signed certificates
- `ConnectTimeout`: Connection timeout in seconds
- `IsActive`: Server enabled/disabled

**Security:**
- Passwords encrypted with Windows DPAPI (CurrentUser scope)
- Cannot decrypt from another Windows account
- Safe to backup (passwords remain encrypted)

### **Session File**

**Location:** `%APPDATA%\SODA_PLUS\user_session.dat`

**Contents:**
- User email
- Session token
- API key assignment
- Last login timestamp
- Auto-login flag

**Security:**
- Encrypted with Windows DPAPI
- Per-user access only
- Expires after 1 year (configurable)

### **Application Configuration**

**Location:** `appsettings.json` (in installation directory)

**Key Settings:**
```json
{
  "Grok": {
    "Model": "grok-2-1212",
    "ApiKey": "your-key-here",
    "Temperature": 0.7,
    "MaxTokens": 4000
  },
  "Mermaid": {
    "MaxSqlChars": 25000,
    "RenderTimeout": 30000
  },
  "Prompts": {
    "Summary": "...",
    "MermaidFlowchart": "...",
    "Refactoring": "..."
  }
}
```

**Do NOT modify unless:**
- Instructed by administrator
- Customizing AI prompts
- Changing AI model settings

---

## Quick Answers to "How Do I...?"

**How do I add a SQL Server?**
→ Right-click Server Explorer → Add Server...

**How do I search for an object?**
→ Use search box above Object Explorer tree

**How do I search across all databases?** ⭐ NEW!
→ Search menu → Search Current Server → Enter term → Search

**How do I search across all servers?** ⭐ NEW!
→ Search menu → Search All Servers → Select databases → Search

**How do I search inside code?** ⭐ NEW!
→ Search dialog → Check "Search inside code definitions" → Search

**How do I analyze dependencies?**
→ Right-click object → Analyze Dependencies

**How do I generate a chart?**
→ Right-click object → Chart Analysis → Quick Chart

**How do I control chart direction?** ⭐ NEW!
→ Chart Window → Direction dropdown → Select Downstream or Upstream

**How do I save a chart?** ⭐ NEW!
→ Chart Window → File menu → Save Mermaid (.mmd)

**How do I load a saved chart?** ⭐ NEW!
→ Chart Window → File menu → Load Mermaid (.mmd)

**How do I render a chart to SVG?** ⭐ NEW!
→ Chart Window → Output menu → Render to SVG

**How do I save rendered SVG?** ⭐ NEW!
→ Chart Window → Output menu → Save SVG As...

**How do I get AI suggestions?**
→ Right-click procedure/function → AI Analysis → Pick type

**How do I export dependencies?**
→ Click Export button (💾) in analyzer toolbar → Pick format

**How do I open full window?**
→ Click Full Window button (📺) in analyzer toolbar

**How do I switch environments?**
→ Restart application, select different environment

**How do I close all tabs?**
→ Close tabs individually with ✖ or restart application

**How do I open code in SSMS automatically?** ⭐ NEW!
→ Dependency Analyzer → Click 📤 Open in SSMS button

**How do I avoid certificate errors in SSMS?** ⭐ NEW!
→ Use "Open in SSMS" button (preserves existing connection)

**How do I logout?**
→ Delete `%APPDATA%\SODA_PLUS\user_session.dat`, restart

---

## Document Navigation

**You are here:** 🔍 Reference Guide

**Other Guides:**
- 🚀 **[Quick Start Guide](SODA_PLUS_QuickStart.md)** - 5-minute setup
- 📘 **[Concise Guide](SODA_PLUS_Guide_Concise.md)** - 30-minute essentials
- 📖 **[Full User Guide](SODA_PLUS_User_Guide.md)** - Complete reference

---

**End of Reference Guide** | **Version:** 1.5.2 | **Last Updated:** January 2025  
**For detailed instructions:** [Full User Guide](SODA_PLUS_User_Guide.md)

---

## SSMS Integration ⭐ NEW!

### Overview

**Open in SSMS** button provides **fully automated** workflow for opening SQL code in SQL Server Management Studio.

**Key Benefits:**
- ✅ **One-click automation** - No manual steps required
- ✅ **10x faster** - 45 seconds → 5 seconds
- ✅ **Preserves connections** - Uses existing SSMS session
- ✅ **No certificate errors** - Avoids re-authentication
- ✅ **Auto-formatting** - Adds USE statement automatically

### How It Works

```
1. Click 📤 "Open in SSMS" button
   ↓
2. System detects if SSMS is running
   ↓
3. Prepares code with USE [Database] statement
   ↓
4. Copies code to clipboard
   ↓
5. Activates SSMS window
   ↓
6. Sends Ctrl+N (new query window)
   ↓
7. Sends Ctrl+V (paste code)
   ↓
8. Done! Code ready to execute
```

**Total time:** 3-5 seconds  
**Manual steps:** Zero

### Features

| Feature | Description |
|---------|-------------|
| **Smart Detection** | Detects running SSMS (avoids duplicate instances) |
| **Multi-Version** | Supports SSMS 18, 19, 20, 21+ (prefers newest) |
| **Keyboard Automation** | Uses Windows API (`keybd_event`) for Ctrl+N, Ctrl+V |
| **Connection Preservation** | Uses existing SSMS connection (no re-auth) |
| **USE Statement** | Auto-adds `USE [Database]` with GO separator |
| **Temp Files** | Creates timestamped .sql files in `%TEMP%\SODA_PLUS_SSMS\` |
| **Graceful Fallback** | Shows manual instructions if automation fails |
| **Window Activation** | Brings SSMS to front (restores if minimized) |

### Button Location

**Toolbar:** Dependency Analyzer (right side, after Export button)  
**Icon:** 📤  
**Tooltip:** "Open this object in SQL Server Management Studio (SSMS 18-21)"

### Supported Objects

| Object Type | Supported | Notes |
|-------------|-----------|-------|
| **Stored Procedures** | ✅ Yes | Full code with USE statement |
| **Functions** | ✅ Yes | Full code with USE statement |
| **Views** | ✅ Yes | Full code with USE statement |
| **Tables** | ✅ Yes | Object name copied (no code) |

### Workflow Comparison

#### **Before (Manual - 10 steps, 30-45 seconds)**
1. Copy object name to clipboard
2. Activate SSMS window
3. Press Ctrl+F in Object Explorer
4. Paste object name (Ctrl+V)
5. Navigate to object
6. Right-click → Script As → CREATE
7. Copy SQL code
8. Press Ctrl+N for new query
9. Paste code (Ctrl+V)
10. Manually type `USE [Database]`

#### **After (Automated - 1 step, 3-5 seconds)** ⭐
1. Click 📤 "Open in SSMS" button

**Time Saved:** 10x faster!

### Dialog Messages

#### **SSMS Running + Code Available**
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

[Yes] [No]
```

#### **Automation Complete**
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

[OK]
```

#### **SSMS Not Found**
```
Could not find SQL Server Management Studio (SSMS) installation.

SSMS 18, 19, 20, or 21 must be installed to use this feature.

Would you like to download SSMS?

[Yes] [No]
```

### Temp File Format

**Location:** `%TEMP%\SODA_PLUS_SSMS\{ObjectName}_{Timestamp}.sql`

**Example:** `C:\Users\YourName\AppData\Local\Temp\SODA_PLUS_SSMS\dbo_GetCustomer_20250112_150000.sql`

**Content:**
```sql
-- Object: dbo.GetCustomer
-- Server: YourServer
-- Database: YourDatabase
-- Generated: 2025-01-12 15:00:00

USE [YourDatabase]
GO

CREATE PROCEDURE [dbo].[GetCustomer]
    @CustomerId INT
AS
BEGIN
    SELECT * FROM Customers WHERE Id = @CustomerId
END
```

### Troubleshooting

#### **Error:** "SSMS Not Found"
- **Cause:** SSMS not installed or not in standard location
- **Solution:**
  - Install SSMS 18, 19, 20, or 21
  - Download from: https://aka.ms/ssmsfullsetup
  - Restart SODA+ after installation

#### **Error:** "Automation Failed"
- **Cause:** SSMS window activation or keyboard events blocked
- **Solution:**
  - Code is in clipboard - follow manual instructions
  - Manual steps: Ctrl+N, Ctrl+V in SSMS
  - Check Windows security settings

#### **Error:** "Certificate Chain Not Trusted"
- **Cause:** Using old manual method (launching new SSMS)
- **Solution:**
  - Use "Open in SSMS" button (preserves connection)
  - Old method: Right-click → Open in SSMS (deprecated)

#### **SSMS Opens But No Code**
- **Possible Causes:**
  - SSMS window lost focus
  - Keyboard events blocked by security software
- **Solution:**
  - Code is in clipboard
  - Press Ctrl+N, Ctrl+V manually
  - Report issue if persistent

### Security & Privacy

**What's Stored:**
- Temp .sql files in `%TEMP%\SODA_PLUS_SSMS\`
- Files remain after SSMS closes (can save/reopen)
- Readable only by current Windows user

**What's NOT Stored:**
- No passwords or credentials
- No connection strings
- No sensitive data beyond SQL code

**Clipboard:**
- Code copied temporarily for automation
- Clipboard cleared after paste
- User's clipboard history unaffected

---

## Document Navigation

**You are here:** 🔍 Reference Guide

**Other Guides:**
- 🚀 **[Quick Start Guide](SODA_PLUS_QuickStart.md)** - 5-minute setup
- 📘 **[Concise Guide](SODA_PLUS_Guide_Concise.md)** - 30-minute essentials
- 📖 **[Full User Guide](SODA_PLUS_User_Guide.md)** - Complete reference

---

**End of Reference Guide** | **Version:** 1.5.2 | **Last Updated:** November 13, 2025  
**For detailed instructions:** [Full User Guide](SODA_PLUS_User_Guide.md)
