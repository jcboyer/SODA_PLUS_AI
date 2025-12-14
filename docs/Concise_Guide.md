# 📘 SODA PLUS - Concise User Guide
## Essential Features in 30 Minutes

---

**Version:** 1.0 | **Last Updated:** November 2025  
**Target Audience:** Learning Users | **Estimated Time:** 30 minutes  
**Purpose:** 80% of what you need to know

---

## 📑 **Table of Contents**

1. [About This Guide](#about-this-guide)
2. [Getting Started (10 min)](#getting-started-10-min)
   - [Login & Registration](#login--registration)
   - [Environment Selection](#environment-selection)
   - [Connect Your First Server](#connect-your-first-server)
3. [Core Analysis (15 min)](#core-analysis-15-min)
   - [Find & Analyze Objects](#find--analyze-objects)
   - [Understand Dependencies](#understand-dependencies)
   - [Use Object Search](#use-object-search)
   - [Multi-Tab Workflow](#multi-tab-workflow)
4. [Advanced Features (5 min)](#advanced-features-5-min)
   - [Cross-Database Search](#cross-database-search-new)
   - [Quick Charting](#quick-charting)
   - [AI Analysis Basics](#ai-analysis-basics)
   - [Export Dependencies](#export-dependencies)
5. [Quick Reference](#quick-reference)
   - [Keyboard Shortcuts](#keyboard-shortcuts)
   - [Common Tasks](#common-tasks)
   - [Top 5 Tips](#top-5-tips)
6. [Troubleshooting](#troubleshooting)
7. [What's Not Covered Here](#whats-not-covered-here)
8. [Next Steps](#next-steps)

---

## About This Guide

This guide covers **essential SODA PLUS features** in 30 minutes. It's the middle ground between:
- 🚀 [Quick Start](SODA_PLUS_QuickStart.md) - Too brief (5 min)
- 📖 [Full Guide](SODA_PLUS_User_Guide.md) - Too detailed (2-3 hours)

**You'll learn:**
- ✅ Core dependency analysis workflow
- ✅ Essential navigation and searching
- ✅ Basic charting and AI features
- ✅ Common tasks and shortcuts

**Not covered here:**
- ❌ Advanced AI analysis types
- ❌ Detailed troubleshooting
- ❌ Configuration file editing
- ❌ Alternative workflows

**For those topics**, see the [Full User Guide](SODA_PLUS_User_Guide.md).

---

## Getting Started (10 min)

### Login & Registration

**First Time Users:**

1. Launch `SODA_PLUS_MAIN.exe`
2. **Register** tab appears:
   - Email: `your.email@company.com`
   - Display Name: `Your Name`
   - Company: (Optional)
   - Click **Register**

3. **Login** tab:
   - Email: (pre-filled)
   - Click **Login**

**Returning Users:**
- Auto-login from saved session
- If session expired, just enter email and login

**✅ Done!** You're logged in with secure API key assignment.

> **📖 For details:** See [Step 0: Initial Login](SODA_PLUS_User_Guide.md#step-0-initial-login--registration-new)

---

### Environment Selection

**Choose your environment:**

| Environment | Color | When to Use |
|-------------|-------|-------------|
| **SANDBOX** | 🟢 Green | **First time, testing, learning** |
| **TEST** | 🟠 Orange | Development databases |
| **PROD** | 🔴 Red | Production (⚠️ be careful!) |

**Recommendation:** Start with **SANDBOX**.

**✅ Selected!** Environment is locked for this session.

> **Note:** To switch environments, restart the application.

---

### Connect Your First Server

**Add SQL Server:**

1. **Right-click** in **Server Explorer** (top-left panel)
2. Select **"Add Server..."**

**Fill in dialog:**
```
Server name: localhost              (or .\SQLEXPRESS)
Display Name: My Dev Server         (optional)

Authentication: ● Windows Authentication  ← Easiest

Connection Options:
  ✓ Trust server certificate
  Connection timeout: 30 seconds

[Test Connection] → Shows success/failure
[Connect] → Saves server
```

**✅ Connected!** Server appears in Server Explorer.

> **📖 For SQL Auth details:** See [Step 3: Connect to Servers](SODA_PLUS_User_Guide.md#step-3-connect-to-servers-enhanced)

---

## Core Analysis (15 min)

### Find & Analyze Objects

**Select database:**
1. Click your **server** in Server Explorer
2. Click a **database** in Database Explorer (middle-left)
3. Wait for Object Explorer to populate

**Find an object:**
- Use **search box**: `🔍 Search: GetCustomer`
- Or **browse**: Expand Stored Procedures → dbo → Pick object

**Analyze:**
1. **Right-click** the object
2. Select **"🔍 Analyze Dependencies"**

**✅ Analysis opens!** You now see a new analyzer tab.

---

### Understand Dependencies

**Analyzer Layout:**

```
┌──────────────────────┬───────────────────────┐
│ LEFT PANEL (3 tabs)  │ RIGHT PANEL           │
│                      │                       │
│ ⬆️ Upstream          │ SQL Code Viewer       │
│ ⬇️ Downstream        │                       │
│ 📊 Call Order        │ (Shows code of        │
│                      │  selected object)     │
│ (Dependency trees)   │                       │
└──────────────────────┴───────────────────────┘
```

**⬆️ Upstream Tab:**
- Shows what **this object depends on**
- Tables, views, procedures it needs to function
- Example: `dbo.GetCustomers` needs `dbo.Customers` table

**⬇️ Downstream Tab:**
- Shows what **depends on this object**
- Impact analysis: what breaks if you change this
- Example: If you modify `dbo.Users` table, see all procedures that query it

**📊 Call Order Tab:**
- Shows **execution order**
- Click "Generate Call Order" button
- Numbered list: 1. First object, 2. Second object, etc.

**RIGHT PANEL (Code Viewer):**
- Shows SQL code of selected object
- Click any dependency in tree → code updates
- Search within code using search box
- Breadcrumb shows: `Server.Database.Schema.Object`

**✅ Now you understand:** Upstream = needs, Downstream = impact, Call Order = sequence.

> **📖 For deep dive:** See [Step 8: Review Analysis Results](SODA_PLUS_User_Guide.md#step-8-review-analysis-results)

---

### Use Object Search

**Why search?**
- Databases can have 1000+ objects
- Browsing is slow and tedious
- Search finds instantly

**How to search:**

1. Click in search box (above Object Explorer tree)
2. Type part of object name: `Customer`
3. **Results update as you type**
4. Matching objects auto-expand
5. Non-matching objects hide

**Search Examples:**

| Search | Finds |
|--------|-------|
| `Get` | All objects containing "Get" |
| `dbo.Get` | Only `dbo` schema objects with "Get" |
| `order` | Views, procedures with "order" in name |

**Clear search:**
- Click **✖** button
- Or press **Escape**

**✅ Tip:** Use search for 90% of your object navigation!

> **📖 For search features:** See [Step 6: Search for Objects](SODA_PLUS_User_Guide.md#step-6-search-for-objects-new-)

---

### Multi-Tab Workflow

**Why multiple tabs?**
- Analyze several objects simultaneously
- Compare dependencies side-by-side
- Drill down without losing original analysis

**Open new tabs:**
1. In dependency tree, **right-click** a dependency
2. Select **"Analyze Dependencies"**
3. **NEW TAB opens** for that object
4. **Original tab stays open**

**Tab Features:**

| Feature | Description |
|---------|-------------|
| **Tab Icon** | 📋 Procedure, 🔧 Function, 👁️ View, 📊 Table |
| **Tab Name** | Short object name (hover for details) |
| **Close (✖)** | Close individual tabs |
| **Max 10 tabs** | System limit to prevent clutter |
| **Independent** | Each tab has own state, depth, search |

**Switch tabs:**
- Click tab header
- Or press **Ctrl+Tab**

**Close tabs:**
- Click **✖** on tab header
- Close individual tabs to stay organized

**✅ Workflow:** Drill down → New tabs → Compare → Close unused tabs

> **📖 For tab patterns:** See [Step 8: Common Multi-Tab Patterns](SODA_PLUS_User_Guide.md#common-multi-tab-patterns)

---

## Advanced Features (5 min)

### Cross-Database Search ⭐ NEW!

**Search across multiple databases simultaneously:**

1. Go to **Search** menu → **Search Current Server**
2. **Search Dialog opens** with options:
   - **Search scope:** Current server or ALL servers
   - **Search term:** Enter object name (e.g., "Customer")
   - **Database selection:** Choose which databases to search
   - **Object types:** Tables, Views, Procedures, Functions
   - **🔍 Search inside code** - Find references in procedure/view/function code
   - **🤖 AI Filtering** - Remove irrelevant matches (commented code, dead code)

3. Click **🔍 Search**

**What you get:**
- Results from ALL selected databases in seconds
- Server.Database.Schema.Object format
- Sortable, filterable results grid
- Match location indicator (Name vs Code vs Column)

**Search Options:**

**Search Mode:**
| Mode | What It Does | Example ("Get") |
|------|--------------|-----------------|
| **Contains** (default) | Anywhere in name | GetCustomer, CustomerGetter, TargetGet |
| **Exact Match** | Exact name only | Get (only) |
| **Starts With** | Beginning of name | GetCustomer, GetOrder |
| **Ends With** | End of name | CustomerGet, OrderGet |

**Match Locations:**
| Option | Searches | Speed |
|--------|----------|-------|
| **Object Names** | Table/view/procedure names | ⚡ Fast (~2 sec) |
| **Code Definitions** | Inside SQL code | 🐢 Slower (~10-20 sec) |
| **Column Names** | Table column names | ⚡ Fast (~3-5 sec) |

**AI-Powered Filtering** ⭐ NEW!

When enabled (requires API key + code search):
- ✅ Removes commented code references
- ✅ Filters out dead code paths
- ✅ Shows confidence score (0-100%)
- ✅ Provides reasoning for each result
- ⏱️ Adds 30-60 seconds to search time

**Example: Search for "Customer" with AI filtering**
```
Before AI:  100 results (includes comments, old code)
After AI:   65 results (only active references)
Removed:    35 false positives
```

**Performance:**
- **Fast search** (Names only): 2-5 seconds for 20 databases
- **Comprehensive** (All locations): 15-20 seconds for 20 databases  
- **With AI filtering**: +30-60 seconds (but higher precision)

**Multi-Server Search:**
- Search menu → **Search All Servers**
- Select databases from multiple servers
- See results with Server: Database prefixes
- Great for finding all instances across environments

✅ **Use search for:** Finding objects by name OR content, impact analysis, code audits, GDPR compliance

> **📖 For complete guide:** See [Cross-Database Search Guide](SODA_PLUS_Search_Guide.md)

---

### Quick Charting

**Generate visual dependency diagram:**

1. **Right-click** Procedure/Function/View
2. Select **📊 Chart Analysis** → **Quick Chart**
3. Chart window opens with Mermaid diagram

**Chart Window Features:** ⭐ UPDATED!

**Toolbar Controls:**
- **Chart Type** dropdown - Quick, AI-Enhanced, or Flow Chart
- **Direction** dropdown - ⬇️ Downstream (default) or ⬆️ Upstream ⭐ NEW!
- **Depth** display - Shows depth from Analyzer (read-only)
- **Generate Chart** button - Creates chart based on selections

**Dependency Direction Options:** ⭐ NEW!
- **⬇️ Downstream** - What this object depends on (default)
- **⬆️ Upstream** - What depends on this object (impact analysis)

**File Menu** (📁 dropdown): ⭐ NEW!
- **💾 Save Mermaid (.mmd)** - Save chart source code
- **📂 Load Mermaid (.mmd)** - Load saved chart ⭐ NEW!
- **📋 Copy to Clipboard** - Copy Mermaid code
- **🗑️ Clear Chart** - Clear current chart ⭐ NEW!

**Output Menu** (🖼️ dropdown): ⭐ NEW!
- **🎨 Render to SVG** - Create graphic file
- **📂 Open SVG** - View in browser
- **💾 Save SVG As...** - Save to custom location ⭐ NEW!

**What you get:**
- Visual node graph of dependencies
- Color-coded by object type (Tables=Blue, Views=Orange, Procedures=Purple)
- Direction-filtered (shows only Downstream OR Upstream, never both)
- Exportable as SVG for documentation
- Loadable from saved .mmd files

**✅ Use charts for:** Documentation, presentations, code reviews, impact analysis

> **📖 For all chart types:** See [Step 10: Dependency Charting](SODA_PLUS_User_Guide.md#step-10-dependency-charting-new-)

---

### AI Analysis Basics

**Get AI-powered code insights:**

1. **Right-click** Procedure/Function
2. Select **🤖 AI Analysis** → **Summary**
3. AI Review window opens

**AI Review Window has 3 tabs:**

| Tab | Use |
|-----|-----|
| **📤 Sent Prompt** | See what was sent to AI |
| **🤖 AI Response** | Plain text analysis |
| **✨ Formatted View** | HTML rendering with syntax highlighting |

**Recommended:** Use **Formatted View** tab for reading - much easier!

**AI Analysis Types:**

| Type | Best For |
|------|----------|
| **Summary** | Quick overview |
| **Low Hanging Improvements** | Easy quick wins |
| **Security Analysis** | Find vulnerabilities |
| **Performance Analysis** | Optimize speed |

**✅ Start with:** Summary analysis to understand code quality

> **📖 For all AI types:** See [Step 11: AI Analysis Types](SODA_PLUS_User_Guide.md#step-11-working-with-ai-analysis-types)

---

### Export Dependencies

**Export analysis results:**

1. In analyzer tab, click **💾 Export** button (toolbar)
2. Choose format:
   - **CSV** - Excel analysis
   - **JSON** - API integration
   - **Markdown** - GitHub/Confluence
   - **Text** - Email/reports
3. Save file to disk

**Exports include:**
- Object names and types
- Dependency levels
- Schema information
- Hierarchy structure

**✅ Use exports for:** Impact documentation, reports, version control

> **📖 For export formats:** See [Step 8b: Export Button](SODA_PLUS_User_Guide.md#-export-button-new)

---

## Quick Reference

### Keyboard Shortcuts

| Shortcut | Action |
|----------|--------|
| **F1** | Toggle Server Explorer |
| **F2** | Toggle Database Explorer |
| **F3** | Toggle Object Explorer |
| **Ctrl+Tab** | Cycle through analyzer tabs |
| **Escape** | Clear object search |
| **Alt+F4** | Close application |

### Common Tasks

**Add Server:**
→ Right-click Server Explorer → Add Server...

**Search for Object:**
→ Type in search box above Object Explorer

**Cross-Database Search:** ⭐ NEW!
→ Search menu → Search Current Server → Enter term → Search

**Analyze Dependencies:**
→ Right-click object → Analyze Dependencies

**Generate Chart:**
→ Right-click object → Chart Analysis → Quick Chart

**Select Chart Direction:** ⭐ NEW!
→ Chart Window → Direction dropdown → Downstream or Upstream

**Save Chart:** ⭐ NEW!
→ Chart Window → File menu → Save Mermaid (.mmd)

**Load Saved Chart:** ⭐ NEW!
→ Chart Window → File menu → Load Mermaid (.mmd)

**Render Chart to SVG:** ⭐ NEW!
→ Chart Window → Output menu → Render to SVG

**Save SVG File:** ⭐ NEW!
→ Chart Window → Output menu → Save SVG As...

**Get AI Suggestions:**
→ Right-click procedure → AI Analysis → Summary

**Export Dependencies:**
→ Click Export button (💾) → Choose format

**Open Full Window:**
→ Click Full Window button (📺)

**Close Tab:**
→ Click ✖ on tab header

**Switch Tabs:**
→ Click tab or Ctrl+Tab

**View Code:**
→ Click dependency in tree → Right panel updates

### Top 5 Tips

1. **🔍 Use Search Always**
   - Don't browse manually
   - Search finds instantly
   - Works across all object types

2. **📑 Embrace Multi-Tabs**
   - Open related objects in new tabs
   - Compare side-by-side
   - Close unused tabs to stay organized

3. **⬇️ Check Downstream First**
   - Before changing any object
   - See impact analysis
   - Prevent breaking dependencies

4. **📊 Quick Chart for Quick Understanding**
   - Generate charts in < 1 second
   - Choose **Direction** (Downstream or Upstream) for focused view ⭐ NEW!
   - Visual > text for dependencies
   - Use **File menu** to save/load charts ⭐ NEW!
   - Export for documentation via **Output menu** ⭐ NEW!

5. **🚀 Start in SANDBOX**
   - Safe environment for learning
   - No risk to production
   - Experiment freely

---

## Troubleshooting

### **Can't connect to SQL Server**

**Problem:** "Cannot connect to server" error

**Solutions:**
- ✅ Verify server name: `localhost`, `.\SQLEXPRESS`, or actual server
- ✅ Try **Windows Authentication** first (easiest)
- ✅ Click **Test Connection** to see detailed error
- ✅ Check SQL Server service is running
- ✅ Verify firewall allows connection

### **No objects showing**

**Problem:** Object Explorer is empty

**Solutions:**
- ✅ Make sure you **clicked a database** (not just server)
- ✅ Wait a few seconds for objects to load
- ✅ Check Messages panel (bottom) for errors
- ✅ Verify you have permissions to view objects

### **Search not finding objects**

**Problem:** Search returns "No objects found"

**Solutions:**
- ✅ Check spelling
- ✅ Try partial name: `Get` instead of `GetCustomer`
- ✅ Try without schema: `Customer` instead of `dbo.Customer`
- ✅ Verify database is selected and loaded

### **Tabs not opening**

**Problem:** Right-click → Analyze doesn't open tab

**Solutions:**
- ✅ Check you have < 10 tabs open (max limit)
- ✅ Close unused tabs with ✖ button
- ✅ Try restarting application
- ✅ Verify object type is supported (not all objects have full analysis)

### **AI Analysis unavailable**

**Problem:** AI Analysis menu is grayed out

**Solutions:**
- ✅ AI only works on **Procedures and Functions** (not Tables/Views)
- ✅ Check you're logged in with valid session
- ✅ Contact admin if "No API keys available"
- ✅ Verify internet connection (AI requires online)

### **Cross-database search returns no results** ⭐ NEW!

**Problem:** Search finds nothing

**Solutions:**
- ✅ Check at least one database is selected
- ✅ Verify object types are checked (Tables/Views/Procedures/Functions)
- ✅ Try broader search term (e.g., "Customer" instead of rare names)
- ✅ Enable "Search inside code" for comprehensive search
- ✅ Check Messages panel for permission errors

### **Multi-server search shows errors** ⭐ NEW!

**Problem:** Some servers fail during search

**Solutions:**
- ✅ Check error message in results window
- ✅ Verify connection to failed servers
- ✅ Test authentication settings
- ✅ Partial results OK - successful servers still show results

> **📖 For more errors:** See [Full Guide: Help and Support](SODA_PLUS_User_Guide.md#help-and-support)

---

## What's Not Covered Here

This concise guide **does not cover**:

**Advanced AI Features:**
- ❌ All 7 AI analysis types in detail
- ❌ Custom AI prompts
- ❌ Refactor Control window
- ❌ AI-Enhanced charting
- ❌ Logic Flowcharts

**Advanced Workflows:**
- ❌ SQL Server Authentication setup
- ❌ Cross-database dependency analysis
- ❌ Linked server object analysis
- ❌ Behind-the-scenes configuration

**Deep Troubleshooting:**
- ❌ Session file recovery
- ❌ API key management
- ❌ Configuration file editing
- ❌ Detailed error messages

**Alternative Methods:**
- ❌ Menu bar navigation (vs. right-click)
- ❌ Double-click shortcuts
- ❌ Manual configuration

**For these topics**, see:
- 📖 **[Full User Guide](SODA_PLUS_User_Guide.md)** - Complete reference (2-3 hours)
- 🔍 **[Reference Guide](SODA_PLUS_Reference.md)** - Quick lookup

---

## Next Steps

### **You've Completed the Concise Guide!**

**You can now:**
- ✅ Login and select environments
- ✅ Connect to SQL Servers
- ✅ Search and find objects quickly
- ✅ Use cross-database search to find objects across all databases ⭐ NEW!
- ✅ Analyze dependencies (Upstream/Downstream/Call Order)
- ✅ Use multi-tab workflow
- ✅ Generate Quick Charts
- ✅ Run basic AI analysis
- ✅ Export dependencies

### **Continue Learning:**

**Practice These Workflows:**

1. **Cross-Database Search Workflow** (10 min) ⭐ NEW!
   - Go to Search menu → Search Current Server
   - Search for "Customer" across all databases
   - Try "Search inside code" option
   - Enable AI filtering to remove noise
   - Export results for documentation
   - Use for finding all references to a table/procedure

2. **Impact Analysis Workflow** (10 min)
   - Find a table (e.g., `dbo.Customers`)
   - Analyze dependencies
   - Check **Downstream** tab
   - See what procedures/views use it
   - Use this before schema changes

3. **Dependency Chain Workflow** (15 min)
   - Find a procedure
   - Analyze dependencies
   - Check **Upstream** tab
   - Right-click a dependency → Analyze
   - New tab opens
   - Continue drilling down
   - Switch between tabs to see full chain

4. **Documentation Workflow** (10 min)
   - Analyze a complex procedure
   - Generate **Quick Chart**
   - **Select Direction**: Choose Downstream or Upstream ⭐ NEW!
   - Use **File menu** → Save Mermaid (.mmd) ⭐ NEW!
   - Use **Output menu** → Render to SVG ⭐ NEW!
   - Export dependencies as **Markdown**
   - Save both chart (.svg) and export (.md)
   - Use for code review or wiki

### **Explore Advanced Features:**

**When you're comfortable, try:**

**Multi-Server Search** (10-15 min) ⭐ NEW!
- Search menu → Search All Servers
- Search across entire environment (DEV/TEST/PROD)
- Select specific databases per server
- See results with Server: Database prefixes
- Great for finding all instances of an object

**AI-Enhanced Charting** (5-10 min)
- Right-click object → Chart Analysis → **AI-Enhanced Chart**
- **Select Direction** - Downstream or Upstream ⭐ NEW!
- See AI-optimized layout with logical grouping
- Great for complex dependencies (10+ objects)
- Use **File** and **Output** menus for save/render operations ⭐ NEW!

**Deep AI Analysis** (15-20 min)
- Right-click procedure → AI Analysis → **Deeper Improvements**
- Progress through levels 1-4
- Get expert-level refactoring suggestions
- Use Refactor Control window to apply changes

**Full Window Mode** (5 min)
- Click **Full Window** button (📺) in analyzer toolbar
- Get standalone window
- Perfect for dual monitors
- Independent from main window

**Performance Analysis** (10-15 min)
- Right-click slow procedure → AI Analysis → **Performance Analysis**
- Get index recommendations
- Query optimization suggestions
- Resource usage improvements

### **Read Full Documentation:**

**📖 [Full User Guide](SODA_PLUS_User_Guide.md)** (2-3 hours)
- All 13 steps in detail
- Advanced workflows
- Complete troubleshooting
- Configuration reference

**🔍 [Reference Guide](SODA_PLUS_Reference.md)** (Quick Lookup)
- Alphabetical feature index
- All keyboard shortcuts
- Context menu reference
- Common error messages

**🚀 [Quick Start Guide](SODA_PLUS_QuickStart.md)** (5 min)
- Share with new team members
- First-time setup walkthrough
- Visual quick reference

---

## Document Navigation

**You are here:** 📘 Concise User Guide

**Other Guides:**
- 🚀 **[Quick Start Guide](SODA_PLUS_QuickStart.md)** - 5-minute setup
- 🔍 **[Reference Guide](SODA_PLUS_Reference.md)** - Quick lookup
- 📖 **[Full User Guide](SODA_PLUS_User_Guide.md)** - Complete reference

---

## 🔍 **Navigation Help**

**Can't find a specific section?** All guides have built-in search:
- **Ctrl+F** - Search for any keyword in the current guide
- **↑ Button** (bottom-right) - Scroll back to Table of Contents  
- **Clear Button** - Reset search to view full guide

**💡 Quick Search Tips:**
- Feature names: "Search", "Charting", "AI Analysis"
- Actions: "export", "analyze", "connect"
- Errors or issues: search the exact error message

---

**End of Concise User Guide** | **Version:** 1.0 | **Last Updated:** November 2025  
**Completed?** 🎉 You now know **80% of SODA PLUS** essentials!  
**Next:** Explore advanced features or read [Full User Guide](SODA_PLUS_User_Guide.md)
