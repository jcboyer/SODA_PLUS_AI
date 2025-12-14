# 🚀 SODA PLUS - Quick Start Guide
## Get Productive in 5 Minutes!

---

**Version:** 1.1 | **Last Updated:** December 2025 
**Target Audience:** New Users | **Estimated Time:** 5 minutes

---

## 📑 **Table of Contents**

1. [Welcome to SODA PLUS](#welcome-to-soda-plus)
2. [What You'll Learn](#what-youll-learn)
3. [Prerequisites](#prerequisites)
4. [Quick Start: 3 Steps to Your First Analysis](#quick-start-3-steps-to-your-first-analysis)
   - [Step 1: Login & Select Environment](#step-1-login--select-environment)
   - [Step 2: Connect to SQL Server](#step-2-connect-to-sql-server)
   - [Step 3: Analyze Your First Object](#step-3-analyze-your-first-object)
5. [What You Just Did](#what-you-just-did)
6. [Common Mistakes to Avoid](#common-mistakes-to-avoid)
7. [What to Do Next](#what-to-do-next)
8. [Need More Help?](#need-more-help)

---

## Welcome to SODA PLUS!

**SODA PLUS** is your AI-powered SQL Object Dependency Analyzer. This guide will get you analyzing database dependencies in **under 5 minutes**.

---

## What You'll Learn

In the next 5 minutes, you'll:
- ✅ Login and select your work environment
- ✅ Connect to a SQL Server database
- ✅ Analyze your first stored procedure or table
- ✅ See dependency relationships instantly

---

## Prerequisites

Before you start:
- ✅ **SODA PLUS installed** - You should have the `SODA_PLUS_MAIN.exe` on your machine
- ✅ **SQL Server access** - You need connection details for a SQL Server
- ✅ **Basic SQL knowledge** - You should know what procedures, tables, and views are

**Don't have these?** Contact your database administrator for SQL Server connection details.

---

## Quick Start: 3 Steps to Your First Analysis

### Step 1: Login & Select Environment

**1.1 Launch SODA PLUS**
- Double-click `SODA_PLUS_MAIN.exe`
- **First time?** Registration dialog appears automatically

**1.2 Register (First Time Only)**
```
📝 Registration Form:
   Email: your.email@company.com
   Display Name: John Smith
   Company: (Optional) Acme Corp

   Click [📝 Register]
```

**1.3 Login**
```
🔑 Login Form:
   Email: your.email@company.com (pre-filled)
   
   Click [🔑 Login]
```

**1.4 Select Environment**
```
Environment Selection:
   ● SANDBOX (Green) ← Choose this for first time
   ○ TEST (Orange)
   ○ PROD (Red - Be careful!)
   
   Click [Apply]
```

**✅ You're logged in!** The main window opens.

---

### Step 2: Connect to SQL Server

**2.1 Add Your First Server**
- **Right-click** in the **Server Explorer** panel (top-left)
- Select **"Add Server..."**

**2.2 Fill in Server Details**
```
Enhanced Add Server Dialog:

Server Name:
   localhost              ← For local SQL Server
   OR .\SQLEXPRESS        ← For SQL Express
   OR your-server-name    ← For remote server

Display Name: (Optional)
   Dev Server

Authentication:
   ● Windows Authentication  ← Easiest option
   
Connection Options:
   ✓ Trust server certificate
   Connection timeout: 30

Click [🔌 Test Connection]
```

**2.3 Test & Save**
- Click **"🔌 Test Connection"** - You should see:
  ```
  ✅ Connected successfully!
  Server: MYSERVER\SQLEXPRESS
  Version: SQL Server 2019
  ```
- Click **"Connect"** to save

**✅ Server added!** You should see it in the Server Explorer tree.

---

### Step 3: Analyze Your First Object

**3.1 Select Database**
- **Click** your server in the **Server Explorer**
- Wait for databases to load
- **Click** a database name in the **Database Explorer** (middle-left)

**3.2 Find an Object**
- In the **Object Explorer** (bottom-left), use the search box:
  ```
  🔍 Search: GetCustomer
  ```
- Or manually expand:
  - **Stored Procedures** → **dbo** → Pick any procedure

**3.3 Analyze Dependencies**
- **Right-click** the object (e.g., `dbo.GetCustomerOrders`)
- Select **"🔍 Analyze Dependencies"**

**✅ Analysis Complete!** You now see:

**LEFT PANEL (3 Tabs):**
- **⬆️ Upstream** - What this object needs (tables, other procedures)
- **⬇️ Downstream** - What depends on this object
- **📊 Call Order** - Execution sequence

**RIGHT PANEL:**
- **SQL Code** - The object's definition with syntax highlighting

---

## What You Just Did

🎉 **Congratulations!** You just:

1. ✅ **Logged in** to SODA PLUS with secure session management
2. ✅ **Connected** to a SQL Server database
3. ✅ **Analyzed** dependencies for a database object
4. ✅ **Viewed** upstream/downstream relationships
5. ✅ **Inspected** SQL code in the viewer

**Why this matters:**
- You can now see **impact analysis** before making changes
- You understand **dependency chains** across objects
- You can **document** database architecture visually

---

## Common Mistakes to Avoid

❌ **Mistake 1: Selecting PROD Environment**
- **Problem:** PROD is for production databases - risky for learning!
- **Solution:** Always use SANDBOX for first-time exploration

❌ **Mistake 2: Skipping "Test Connection"**
- **Problem:** You won't know if server details are correct
- **Solution:** Always click "🔌 Test Connection" before saving

❌ **Mistake 3: Not Using Search**
- **Problem:** Databases can have 1000+ objects - hard to browse
- **Solution:** Use the search box: `🔍 Search objects...`

❌ **Mistake 4: Forgetting to Expand Sub-Tabs**
- **Problem:** You only see part of the analysis
- **Solution:** Check all 3 sub-tabs: Upstream, Downstream, Call Order

❌ **Mistake 5: Ignoring the Right Panel**
- **Problem:** You miss seeing actual SQL code
- **Solution:** Click items in dependency trees to view their code

---

## What to Do Next

### **Immediate Next Steps:**

**1. Explore More Objects** (5 minutes)
- Try analyzing a **Table** - see what uses it
- Try analyzing a **View** - understand its dependencies
- Try analyzing a **Function** - see its call chain

**2. Use the Object Search Feature** (2 minutes)
- In Object Explorer, use the search box: `🔍 Search objects...`
- Search for objects by name: `Customer`
- Try schema-qualified search: `dbo.Get`
- Clear search and try again

**3. Try Cross-Database Search** ⭐ NEW! (5 minutes)
- Go to **Search** menu → **Search Current Server**
- Enter search term: `Customer`
- Select object types to search (Tables, Views, Procedures, Functions)
- Check **"Search inside code definitions"** for comprehensive search
- Optional: Enable **"Use AI to filter irrelevant results"** (requires API key)
- Click **🔍 Search**
- See results from all databases!
- **Tip:** Double-click a result to open it in Dependency Analyzer
- **→ See [Step 11: Cross-Database Search](SODA_PLUS_Search_Guide.md) in Search Guide**

**4. Check Drill-Down** (3 minutes)
- In the dependency tree, **right-click** a dependency
- Select **"Analyze Dependencies"**
- See how a **new tab opens** for that object
- Switch between tabs with **Ctrl+Tab**

### **Learn Advanced Features:**

Once you're comfortable, explore these:

**🔍 Cross-Database & Multi-Server Search** (15 minutes) ⭐ NEW!
- Search across multiple databases simultaneously
- Find objects by name OR code content
- Search inside stored procedures, views, functions
- Multi-server search across entire environments
- **Features:**
  - 🚀 **20x faster** - Searches 20 databases in parallel
  - 🔍 **Comprehensive** - Searches names, code, columns, triggers, constraints
  - 🌐 **Multi-server** - Search entire environments (DEV, TEST, PROD)
  - 🤖 **AI Filtering** - Remove irrelevant matches with Grok AI
- **→ See [Step 11: Cross-Database Search](SODA_PLUS_Search_Guide.md) in Search Guide**

**📊 Charting** (10 minutes)
- Right-click object → **Chart Analysis** → **Quick Chart**
- **NEW:** Select **Direction** (Downstream or Upstream) to control what dependencies appear
- See visual dependency diagrams
- **NEW:** Use **File menu** to save, load, or copy Mermaid charts
- **NEW:** Use **Output menu** to render, open, or save SVG files
- Export as SVG for documentation
- **→ See [Step 10: Dependency Charting](SODA_PLUS_User_Guide.md#step-10-dependency-charting-new-) in Full Guide**

**🤖 AI Analysis** (15 minutes)
- Right-click procedure → **AI Analysis** → **Summary**
- Get AI-powered code improvements
- See formatted recommendations
- **→ See [Step 9: AI Code Analysis](SODA_PLUS_User_Guide.md#step-9-ai-code-analysis---new-enhanced-workflow-) in Full Guide**

**💾 Export Dependencies** (5 minutes)
- Click **Export** button in analyzer toolbar
- Choose format: CSV, JSON, Markdown, or Text
- Save for documentation or reports
- **→ See [Step 8b: Toolbar Actions](SODA_PLUS_User_Guide.md#step-8b-dependency-analyzer-toolbar-actions-new) in Full Guide**

**📺 Full Window Mode** (2 minutes)
- Click **Full Window** button in analyzer toolbar
- Get standalone window for analysis
- Great for dual monitors
- **→ See [Step 8b: Full Window](SODA_PLUS_User_Guide.md#-full-window-button-new) in Full Guide**

### **Read the Full Documentation:**

📖 **[Complete User Guide](SODA_PLUS_User_Guide.md)** (2-3 hours)
- Comprehensive reference for all features
- Advanced workflows and troubleshooting
- Deep dives into AI analysis and refactoring

📘 **[Concise User Guide](SODA_PLUS_Guide_Concise.md)** (30 minutes)
- Essential features without the deep details
- Perfect for onboarding and training
- 80% of what you need to know

🔍 **[Reference Guide](SODA_PLUS_Reference.md)** (Quick Lookup)
- Alphabetical feature index
- Keyboard shortcuts cheat sheet
- Fast answers to "How do I...?"

---

## Need More Help?

### **Built-in Help**

**Messages Panel** (Bottom of main window)
- Shows real-time feedback and errors
- Right-click to copy messages for support

**Status Bar** (Very bottom)
- Shows connection status
- Displays current operations

### **Documentation**

**Help Menu → Use Cases**
- Opens detailed use case documentation
- Step-by-step scenarios
- Best practices

### **Troubleshooting**

**Problem: Can't connect to SQL Server**
- ✅ Check server name is correct
- ✅ Try Windows Authentication first
- ✅ Click "Test Connection" to see error details
- ✅ Verify SQL Server is running
- ✅ Check firewall settings

**Problem: No objects showing in Object Explorer**
- ✅ Make sure you clicked a database (not just server)
- ✅ Check Database Explorer shows database name
- ✅ Wait a few seconds for objects to load
- ✅ Check Messages panel for errors

**Problem: Analysis tabs not opening**
- ✅ Make sure you right-clicked the object (not the schema)
- ✅ Try single-clicking first, then right-clicking
- ✅ Check you have < 10 tabs open already
- ✅ Close unused tabs with ✖ button

**Problem: Search not finding objects**
- ✅ Check spelling
- ✅ Try partial name: `Get` instead of `GetCustomer`
- ✅ Try without schema: `Customer` instead of `dbo.Customer`
- ✅ Make sure database is selected first

**Problem: Cross-database search returns no results**
- ✅ Check at least one database is selected in the dialog
- ✅ Verify at least one object type is checked (Tables/Views/Procedures/Functions)
- ✅ Try a more common search term (e.g., "Customer" instead of rare names)
- ✅ Enable "Search inside code" for comprehensive search
- ✅ Check Messages panel for permission errors

**Problem: Multi-server search shows server errors**
- ✅ Check the error message in the results window
- ✅ Verify you can connect to the server manually
- ✅ Test authentication settings for that server
- ✅ Some servers failing is OK - results from successful servers still shown

**Problem: AI filtering not working**
- ✅ Make sure you're logged in with a valid session
- ✅ Check "Search inside code" is enabled (AI filtering only works with code search)
- ✅ Verify Grok API key is assigned to your user account
- ✅ See AI filtering checkbox tooltip for requirements

## 🎯 **Success Checklist**

After 5 minutes, you should be able to:

- ✅ Login to SODA PLUS
- ✅ Select SANDBOX environment
- ✅ Add a SQL Server
- ✅ Connect to a database
- ✅ Search for objects
- ✅ Analyze dependencies
- ✅ View Upstream/Downstream relationships
- ✅ Read SQL code in the viewer
- ✅ Understand basic dependency impact

**All checked?** 🎉 You're ready to explore advanced features!

**Next Steps:**
- 🔍 Try **Cross-Database Search** to find objects across all databases
- 📊 Explore **Dependency Charting** for visual diagrams
- 🤖 Test **AI Analysis** for code improvements

**Need more?** 📖 Move to the [Concise User Guide](SODA_PLUS_Guide_Concise.md) for essential features.

---

## 🔍 **Can't Find a Section?**

All guides have built-in search to help you navigate:

- **Search in Guide:** Press `Ctrl+F` while viewing any guide to search for keywords
- **Floating Top Button:** Click the blue **↑** button (bottom-right) to return to Table of Contents
- **Clear Search:** Click the "Clear" button to reset search and view full guide

**💡 Search Tips:**
- Try partial words: "login", "server", "analyze"
- Use feature names: "AI Analysis", "Charting", "Dependencies"
- Search error messages or symptoms directly

**Still can't find what you need?** See the [Complete User Guide](SODA_PLUS_User_Guide.md) for comprehensive coverage.

---

