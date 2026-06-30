# 🔍 SqlLens - Cross-Database Search Guide
## Search Objects Across Multiple Databases and Servers

---

**Version:** 1.0 | **Last Updated:** February 2026  
**Feature:** Cross-Database Search | **Estimated Time:** 15 minutes

---

## 📑 **Table of Contents**

1. [Overview](#overview)
2. [What is Cross-Database Search?](#what-is-cross-database-search)
3. [Key Features](#key-features)
4. [How to Access](#how-to-access)
5. [Search Dialog Options](#search-dialog-options)
   - [Search Scope](#search-scope)
   - [Search Term](#search-term)
   - [Object Types](#object-types)
   - [Match Locations](#match-locations)
   - [Search Mode](#search-mode)
   - [System Objects](#system-objects)
   - [Result Limit](#result-limit)
   - [Database Selection](#database-selection)
6. [Search Modes Explained](#search-modes-explained)
7. [Match Location Options](#match-location-options)
8. [AI-Powered Filtering](#ai-powered-filtering)
9. [Search Performance](#search-performance)
10. [Search Results Window](#search-results-window)
11. [Common Use Cases](#common-use-cases)
12. [Performance Tips](#performance-tips)
13. [Troubleshooting](#troubleshooting)
14. [Keyboard Shortcuts](#keyboard-shortcuts)

---

## Overview

Cross-Database Search is a powerful feature that allows you to search for database objects across multiple databases and servers simultaneously. It supports searching object names, code definitions, column names, and more, with optional AI-powered relevance filtering.

**What makes it special:**
- ✅ **20x faster** than sequential searching (parallel processing)
- ✅ **Comprehensive** - searches names, code, columns, triggers, constraints
- ✅ **Multi-server** - search across entire environments
- ✅ **AI-powered** - optional filtering to remove false positives
- ✅ **Agent-aware** - can optionally search SQL Agent Jobs in `msdb`

---

## What is Cross-Database Search?

Cross-Database Search searches for database objects across:

**Search Targets:**
- **Object Names** - Tables, Views, Stored Procedures, Functions, Triggers
- **Code Definitions** - SQL code inside procedures, views, functions, triggers
- **Column Names** - Table column definitions and metadata
- **Table Definitions** - Column data types, defaults, constraints
- **Triggers** - Trigger code and definitions
- **Constraints** - CHECK, DEFAULT, FOREIGN KEY, PRIMARY KEY, UNIQUE constraints

**Search Scope:**
- **Current Server** - Search selected databases on one server
- **All Servers** - Search across all servers in current environment (SANDBOX/TEST/PROD)

---

## Key Features

### 🚀 **Performance**
- **20x Faster** - Parallel processing searches up to 20 databases simultaneously
- **Connection Pooling** - Optimized SQL connections (max 50 concurrent)
- **Smart Querying** - Single SQL call retrieves complete dependency trees

### 🔍 **Comprehensive Search**
- **Object Names** - Tables, Views, Stored Procedures, Functions, Triggers
- **Code Content** - SQL definitions in programmable objects
- **Column Names** - Table column definitions (name-based)
- **Table Definitions** - Column data types, defaults, constraints (metadata-based)
- **Triggers** - Trigger definitions and code
- **Constraints** - CHECK, DEFAULT, FK, PK, UNIQUE constraints

### 🌐 **Multi-Server Support**
- **Environment-Wide** - Search all servers in SANDBOX, TEST, or PROD
- **Server Selection** - Choose specific servers or all
- **Database Filtering** - Select specific databases per server
- **Error Handling** - Partial results if some servers fail

### 🤖 **AI-Powered Filtering** (Optional)
- **Relevance Analysis** - Filters out commented/dead code
- **Smart Detection** - Identifies active vs inactive references
- **Confidence Scoring** - 0-100% relevance confidence
- **Reasoning** - Explains why results are relevant/irrelevant

### 🎯 **Advanced Options**
- **Search Modes** - Exact, StartsWith, EndsWith, Contains
- **Match Locations** - Names, Code, Columns (any combination)
- **System Objects** - Include/exclude system objects
- **Result Limits** - 100, 250, 500, 1000, or unlimited
- **Database Selection** - All or specific databases
- **SQL Agent Jobs** - Optional Agent Job search on the current server

---

## How to Access

### **Menu Bar**
```
Search → Search Current Server
Search → Search All Servers
```

**Tip:** Use these menu options to start searching across databases!

**Agent Job note:** SQL Agent Job searching is an **opt-in** search option and runs against `msdb` on the **current server**. Agent Job results open an Agent-specific dependency flow instead of the standard object analyzer.

---

## Search Dialog Options

### **Search Scope**

**Radio Buttons:**
- ⚫ **Current Server Only** - Search databases on connected server
- ⚫ **All Servers (X servers)** - Search all servers in environment

**When to use:**
- **Current Server** - Fastest, when you know which server
- **All Servers** - Find all instances across environment

---

### **Search Term**

**Text Input:**
```
Example: Customer
```

**Tips:**
- Case-insensitive (e.g., "customer" = "Customer" = "CUSTOMER")
- No wildcards needed (handled by Search Mode)
- Can be partial names (e.g., "Get" finds "GetCustomer")
- Can include schema prefix (e.g., "dbo.Get")

**Examples:**
```
Search Term          Finds
─────────────────────────────────────────────
Customer             All objects with "Customer"
dbo.Get              Objects in dbo schema with "Get"
sp_                  All objects starting with "sp_"
Order                Tables, views, procedures with "Order"
```

---

### **Object Types**

**Checkboxes:**
- ☑ **📊 Tables** - User tables (type 'U')
- ☑ **👁 Views** - Views (type 'V')
- ☑ **⚙ Stored Procedures** - Procedures (type 'P')
- ☑ **🔧 Functions** - Scalar, inline, table-valued (types 'FN', 'IF', 'TF')
- ☑ **⚡ Triggers** - Database triggers (type 'TR')

**Select at least one** - Dialog validates selection

**Default:** All checked (search everything)

**What each type searches:**

| Object Type | Searches In | Example |
|-------------|-------------|---------|
| **Tables** | Table names, column names, column definitions | Find table with "ContractNo" column |
| **Views** | View names, view definitions (SQL code) | Find views that select from "Customers" |
| **Procedures** | Procedure names, SQL code inside procedures | Find procs that call "GetCustomer" |
| **Functions** | Function names, function code | Find functions returning "CustomerID" |
| **Triggers** | Trigger names, trigger code | Find triggers on "Orders" table |

---

### **Match Locations**

**Checkboxes:**
- ☑ **📝 Object Names** - Search object names (e.g., "dbo.GetCustomer")
- ☑ **📄 Code Definitions** - Search inside SQL code
- ☑ **🔤 Column Names** - Search table column names

**Select at least one** - Dialog validates selection

**Default:** All checked (comprehensive search)

**How it works:**

**Example: Searching for "Customer"**

| Match Location | Finds |
|----------------|-------|
| **Names Only** | `dbo.GetCustomer` (procedure name)<br/>`dbo.Customers` (table name) |
| **Code Only** | Procedures with `SELECT * FROM Customers` in code<br/>Views with `JOIN Customers` in definition |
| **Columns Only** | Tables with `CustomerID`, `CustomerName`, `CustomerEmail` columns |
| **All Three** | All of the above |

**Advanced Column Search:**

When **Column Names** is checked AND **Tables** is selected:
- ✅ Searches `sys.columns.name` for matching column names
- ✅ Finds tables containing columns like "ContractNo", "CustomerID", etc.
- ✅ Case-insensitive matching
- ✅ Shows table name and matched column in results

**Example:**
```
Search: "ContractNo"
Columns checkbox: ✅ Checked
Tables checkbox: ✅ Checked

Results:
✓ dbo.Contracts - User Table (Column: ContractNo)
✓ dbo.Orders - User Table (Column: ContractNumber)
✓ dbo.Invoices - User Table (Column: CONTRACTNO)
```

---

### **SQL Agent Jobs** ⭐ NEW!

When enabled in the search dialog, SqlLens also searches **SQL Agent Jobs** on the **current server**.

**How it works:**
- Searches Agent Job metadata and step content in `msdb`
- Uses your normal search term and search mode
- Returns Agent Job results alongside regular object results
- Opens the **Agent Job dependency graph** when selected

**Important scope rule:**
- Agent Job search is **current-server only**
- It is not part of the multi-server environment-wide search pass

**Best use cases:**
- Find jobs that call a stored procedure
- Find jobs referencing a database, server, or integration endpoint
- Trace from a job result into related stored procedures for dependency analysis

For Git persistence, Active/Archive handling, and Repo Changes reporting, see the [Git Integration Guide](Git_Integration_Guide.md).

**Table Definition Search (Advanced):**

When **Code Definitions** is checked AND **Tables** is selected:
- ✅ Searches `INFORMATION_SCHEMA.COLUMNS` metadata
- ✅ Finds tables by column **data types** (e.g., "GEOGRAPHY", "XML", "VARCHAR(MAX)")
- ✅ Finds tables by column **default values** (e.g., "GETDATE()", "NEWID()")
- ✅ Shows full column definition in SqlCode column

**Example:**
```
Search: "GETDATE"
Code checkbox: ✅ Checked
Tables checkbox: ✅ Checked

Results:
✓ dbo.Orders - User Table (Default: GETDATE())
  SqlCode: "OrderDate datetime YES DEFAULT (getdate())"
✓ dbo.Audit - User Table (Default: GETDATE())
  SqlCode: "CreatedDate datetime NO DEFAULT (getdate())"
```

---

### **Search Mode**

**Dropdown Options:**

| Mode | Behavior | Example (Search: "Get") |
|------|----------|------------------------|
| **Contains** | Anywhere in name | `GetCustomer`, `CustomerGetter`, `TargetGet` |
| **Exact Match** | Exact name only | `Get` (only) |
| **Starts With** | Beginning of name | `GetCustomer`, `GetOrder` |
| **Ends With** | End of name | `CustomerGet`, `OrderGet` |

**Default:** Contains (most flexible)

**SQL Pattern Translation:**
```
Contains    → %Get%
Exact Match → Get
Starts With → Get%
Ends With   → %Get
```

---

### **System Objects**

**Checkbox:**
- ☑ **Exclude system objects and built-in procedures**

**What gets excluded when checked:**
- `is_ms_shipped = 1` (Microsoft-shipped objects)
- Names starting with `sp_` (system stored procedures)
- Names starting with `dt_` (data tools procedures)

**Default:** Checked (exclude system objects)

**When to uncheck:**
- Debugging system procedure calls
- Auditing system object usage
- Learning SQL Server internals

---

### **Result Limit**

**Dropdown Options:**
- 100 results
- 250 results
- 500 results (default)
- 1000 results
- Unlimited

**Why limit results:**
- Faster display
- Reduced memory usage
- Focused results

**When to use unlimited:**
- Complete inventory
- Exporting all results
- Comprehensive audits

**Note:** Limit applies **globally** (not per database)

---

### **Database Selection**

**List Box:**
- Multi-select list of available databases
- Shows database name (and server name if multi-server)
- Buttons: **Select All** | **Clear All**
- Status text shows selection count

**Example:**
```
☑ AdventureWorks (SERVER01)
☑ Northwind (SERVER01)
☐ master (SERVER01)
☑ AdventureWorks (SERVER02)
```

**Tips:**
- Use **Select All** for comprehensive search
- Deselect `master`, `msdb`, `tempdb` for user databases only
- Remember: System objects can be excluded separately

---

## Search Modes Explained

### **1. Contains (Default) - Most Flexible**

**Best for:** General searching, finding variations

**How it works:**
- Matches search term anywhere in name
- SQL pattern: `%searchTerm%`

**Example: Search term "Order"**
```
✅ Matches:
   dbo.CreateOrder
   dbo.GetCustomerOrders
   dbo.OrderHistory
   dbo.ProcessOrderPayment
   sales.CustomerOrderSummary

❌ Does not match:
   dbo.Customer
   dbo.Payment
```

---

### **2. Exact Match - Precise**

**Best for:** Finding specific object, avoiding partial matches

**How it works:**
- Matches only exact name
- SQL pattern: `searchTerm` (no wildcards)

**Example: Search term "Order"**
```
✅ Matches:
   dbo.Order (exact match only)

❌ Does not match:
   dbo.Orders (plural)
   dbo.CreateOrder (has prefix)
   dbo.CustomerOrder (has prefix)
```

---

### **3. Starts With - Prefix Search**

**Best for:** Naming conventions, finding object families

**How it works:**
- Matches names beginning with search term
- SQL pattern: `searchTerm%`

**Example: Search term "Get"**
```
✅ Matches:
   dbo.GetCustomer
   dbo.GetOrders
   dbo.GetUserProfile

❌ Does not match:
   dbo.CustomerGet (doesn't start with "Get")
   dbo.RetrieveCustomer (different prefix)
```

---

### **4. Ends With - Suffix Search**

**Best for:** Finding objects by type suffix

**How it works:**
- Matches names ending with search term
- SQL pattern: `%searchTerm`

**Example: Search term "Report"**
```
✅ Matches:
   dbo.SalesReport
   dbo.CustomerActivityReport
   dbo.MonthlyFinancialReport

❌ Does not match:
   dbo.ReportGenerator (doesn't end with "Report")
   dbo.ReportingTools (has suffix after "Report")
```

---

## Match Location Options

### **1. Object Names** ✅ Fastest

**Searches:**
- Table names
- View names
- Stored procedure names
- Function names
- Constraint names

**How it works:**
```sql
SELECT name FROM sys.objects
WHERE name LIKE @SearchTerm
```

**Speed:** ⚡ Very Fast (~2 seconds for 20 databases)

**Use when:**
- Searching for specific object
- You know (part of) the name
- Fast results needed

---

### **2. Code Definitions** ⚡ Comprehensive

**Searches:**
- Stored procedure code
- Function code
- View definitions
- Trigger code

**How it works:**
```sql
SELECT o.name, m.definition
FROM sys.objects o
JOIN sys.sql_modules m ON o.object_id = m.object_id
WHERE m.definition LIKE @SearchTerm
```

**Speed:** 🐢 Slower (~10-20 seconds for 20 databases)

**Use when:**
- Finding usage in code
- Searching for table references
- Finding SQL patterns

**Example: Search "CustomerID"**
```
Finds procedures with:
   SELECT * FROM Orders WHERE CustomerID = @ID
   UPDATE Customers SET Status = 1 WHERE CustomerID = @ID
```

---

### **3. Column Names** 🔍 Database Schema

**Searches:**
- Table column names
- View column names (base table columns)

**How it works:**
```sql
SELECT t.name, c.name
FROM sys.tables t
JOIN sys.columns c ON t.object_id = c.object_id
WHERE c.name LIKE @SearchTerm
```

**Speed:** ⚡ Fast (~3-5 seconds for 20 databases)

**Use when:**
- Finding tables with specific column
- Schema analysis
- Data modeling

**Example: Search "Email"**
```
Finds tables with:
   Users.EmailAddress
   Customers.Email
   ContactInfo.EmailVerified
```

---

### **Combining Match Locations**

**Recommended Combinations:**

| Combination | Speed | Use Case |
|-------------|-------|----------|
| **Names Only** | ⚡⚡⚡ Fast | Quick object lookup |
| **Names + Columns** | ⚡⚡ Fast | Schema analysis |
| **Names + Code** | 🐢 Slow | Comprehensive search |
| **All Three** | 🐢🐢 Slowest | Complete inventory |

**Example: Search "Customer" with all three:**
```
Names:    dbo.Customers (table name)
          dbo.GetCustomer (procedure name)
          
Code:     dbo.ValidateOrder (has "SELECT * FROM Customers")
          dbo.ProcessPayment (has "WHERE CustomerID = @ID")
          
Columns:  Orders.CustomerID
          Sales.CustomerName
```

---

## AI-Powered Filtering

### **What is AI Filtering?**

AI filtering uses Grok AI to analyze search results and filter out:
- Commented code (e.g., `-- SELECT * FROM Customers`)
- Dead code (unreachable paths)
- False positives (mentions in strings/comments)

**Checkbox:**
- ☑ **Use AI to filter irrelevant results (code search only)**

**Requirements:**
- Valid user session (logged in)
- "Search inside code" must be enabled
- Grok API key assigned to your account

---

### **How AI Filtering Works**

**Step 1: Normal Search**
```sql
-- Finds 100 results mentioning "Customer"
```

**Step 2: AI Analysis**
```
For each result:
  1. Send SQL code to Grok AI
  2. AI analyzes: Is "Customer" actively used?
  3. AI returns: IsActive (bool) + Confidence (0-100)
  4. Filter out: IsActive = false
```

**Step 3: Filtered Results**
```
100 results → 65 relevant results
(35 filtered out as comments/dead code)
```

---

### **AI Filtering Example**

**Without AI Filtering:**
```sql
✅ Result 1: Active code
CREATE PROCEDURE GetCustomer
AS
  SELECT * FROM Customers WHERE Active = 1

✅ Result 2: Commented code (false positive)
CREATE PROCEDURE GetOrder
AS
  -- Old code: SELECT * FROM Customers
  SELECT * FROM Orders

✅ Result 3: String literal (false positive)
CREATE PROCEDURE LogMessage
AS
  INSERT INTO Logs VALUES ('Checking Customers table')
```

**With AI Filtering:**
```sql
✅ Result 1: Active code (Confidence: 95%)
   Reasoning: "Customer table actively queried"

❌ Result 2: Filtered out (Confidence: 10%)
   Reasoning: "Reference is in commented code"

❌ Result 3: Filtered out (Confidence: 15%)
   Reasoning: "Mention is in string literal only"
```

---

### **When to Use AI Filtering**

**Use AI Filtering when:**
- ✅ Searching inside code
- ✅ High number of results (50+)
- ✅ Removing false positives is important
- ✅ You have time (adds 30-60 seconds)

**Skip AI Filtering when:**
- ❌ Searching names/columns only (not applicable)
- ❌ Few results (< 20)
- ❌ Speed is critical
- ❌ You want to see ALL matches (including comments)

---

## Search Performance

### **Performance Comparison**

| Search Type | Speed | Databases | Time |
|-------------|-------|-----------|------|
| **Names Only** | ⚡⚡⚡ Fast | 20 | ~2 sec |
| **Names + Columns** | ⚡⚡ Fast | 20 | ~5 sec |
| **Names + Code** | 🐢 Slow | 20 | ~15 sec |
| **All Three** | 🐢🐢 Slower | 20 | ~20 sec |
| **With AI Filter** | 🐢🐢🐢 Slowest | 20 | ~50 sec |

### **Multi-Server Performance**

| Servers | Databases | Time (Names) | Time (All + AI) |
|---------|-----------|--------------|-----------------|
| 1 | 10 | 1 sec | 15 sec |
| 3 | 30 | 3 sec | 45 sec |
| 5 | 50 | 5 sec | 90 sec |
| 10 | 100 | 10 sec | 180 sec |

### **Performance Factors**

**Faster:**
- ✅ Fewer match locations (Names only)
- ✅ Specific search term (exact match)
- ✅ System objects excluded
- ✅ Result limit enforced
- ✅ Fewer databases selected

**Slower:**
- ❌ All match locations (Names + Code + Columns)
- ❌ Contains mode (broadest)
- ❌ AI filtering enabled
- ❌ Unlimited results
- ❌ Many databases (50+)

---

## Search Results Window

### **Results Grid**

**Columns:**
| Column | Description |
|--------|-------------|
| **Server** | SQL Server name |
| **Database** | Database name |
| **Schema** | Object schema (e.g., dbo) |
| **Object** | Object name |
| **Type** | Object type (Table, View, Procedure, Function) |
| **Match Type** | Where it matched (Name, Code, Column) |

**Example:**
```
Server     Database        Schema  Object           Type              Match
────────────────────────────────────────────────────────────────────────────
SERVER01   AdventureWorks  dbo     Customers        User Table        Name
SERVER01   AdventureWorks  dbo     GetCustomer      Stored Procedure  Name
SERVER01   AdventureWorks  dbo     ValidateOrder    Stored Procedure  Code
SERVER01   Northwind       dbo     Orders           User Table        Column
SERVER02   AdventureWorks  sales   CustomerOrders   View              Name
```

---

### **Results Actions**

**1. Double-Click Row**
- Opens object in Dependency Analyzer
- New analyzer tab created
- Shows upstream/downstream dependencies
- Displays SQL code in right panel

**2. Right-Click Menu**
- **Analyze Dependencies** - Open in analyzer
- **Copy Object Name** - Copy to clipboard
- **Export Results** - Save to CSV/Excel

**3. Sort Results**
- Click column header to sort
- Multi-level sorting (Shift+Click)
- Default: Server → Database → Schema → Object

**4. Filter Results**
- Type in search box to filter displayed results
- Filter by any column
- Case-insensitive

**5. Export Results**
- Click **Export** button
- Choose CSV or Excel format
- Includes all columns

---

### **Result Statistics**

**Status Bar Shows:**
```
🔍 Found 156 results in 18 databases across 3 servers (12.5 seconds)
```

**Information Displayed:**
- Total results found
- Number of databases searched
- Number of servers searched
- Time taken

---

## Common Use Cases

### **Use Case 1: Find All References to a Table**

**Scenario:** You want to modify the `Customers` table schema and need to find all procedures/views that reference it.

**Steps:**
1. Search menu → Search Current Server
2. Search term: `Customers`
3. Object types: ☑ Stored Procedures, ☑ Views, ☑ Functions
4. Match locations: ☑ Code Definitions (only)
5. Search mode: Contains
6. Click Search

**Result:** All procedures/views with `FROM Customers` or `JOIN Customers` in code

---

### **Use Case 2: Find Object by Partial Name**

**Scenario:** You remember a procedure has "Order" in the name but can't remember the full name.

**Steps:**
1. Search menu → Search Current Server
2. Search term: `Order`
3. Object types: ☑ Stored Procedures (only)
4. Match locations: ☑ Object Names (only)
5. Search mode: Contains
6. Click Search

**Result:** `GetCustomerOrders`, `ProcessOrder`, `OrderHistory`, etc.

---

### **Use Case 3: Find All Instances Across Environments**

**Scenario:** You need to update `sp_UpdateInventory` on all servers (DEV, TEST, PROD).

**Steps:**
1. Search menu → Search All Servers
2. Search term: `sp_UpdateInventory`
3. Object types: ☑ Stored Procedures
4. Match locations: ☑ Object Names
5. Search mode: Exact Match
6. Select all databases
7. Click Search

**Result:** Shows every instance with server name, easy to see where to deploy

---

### **Use Case 4: Find Tables with Specific Column**

**Scenario:** Find all tables with an `EmailAddress` column for GDPR audit.

**Steps:**
1. Search term: `Email`
2. Object types: ☑ Tables (only)
3. Match locations: ☑ Column Names (only)
4. Search mode: Contains
5. Exclude system objects: ☑ Yes
6. Click Search

**Result:** All user tables with columns containing "Email"

```
Example Results:
✓ dbo.Customers - User Table (Column: EmailAddress)
✓ dbo.Employees - User Table (Column: WorkEmail)
✓ dbo.Contacts - User Table (Column: Email)
```

---

### **Use Case 5: Find Tables Using Specific Data Types**

**Scenario:** Find all tables using `GEOGRAPHY` data type for migration planning.

**Steps:**
1. Search term: `GEOGRAPHY`
2. Object types: ☑ Tables (only)
3. Match locations: ☑ Code Definitions (searches table definitions)
4. Search mode: Contains
5. Click Search

**Result:** All tables with GEOGRAPHY columns, showing full column definition

```
Example Results:
✓ dbo.Locations - User Table (Data Type: geography)
  SqlCode: "Coordinates geography YES"
✓ dbo.Stores - User Table (Data Type: geography)
  SqlCode: "StoreLocation geography NO"
```

---

### **Use Case 6: Find Tables with Auto-Generated Defaults**

**Scenario:** Find all tables using `GETDATE()` or `NEWID()` defaults.

**Steps:**
1. Search term: `GETDATE`
2. Object types: ☑ Tables (only)
3. Match locations: ☑ Code Definitions (searches table definitions)
4. Search mode: Contains
5. Click Search

**Result:** All tables with GETDATE() defaults, showing full column definition

```
Example Results:
✓ dbo.Orders - User Table (Default: GETDATE())
  SqlCode: "OrderDate datetime YES DEFAULT (getdate())"
✓ dbo.Audit - User Table (Default: GETDATE())
  SqlCode: "CreatedDate datetime NO DEFAULT (getdate())"
```

**Other Useful Searches:**
```
Search: "NEWID"     → Find tables with GUID defaults
Search: "IDENTITY"  → Find tables with identity columns
Search: "VARCHAR(MAX)" → Find unbounded text columns
```

---

### **Use Case 7: Find Triggers on Specific Tables**

**Scenario:** Find all triggers related to the "Orders" table.

**Steps:**
1. Search term: `Orders`
2. Object types: ☑ Triggers (only)
3. Match locations: ☑ Code Definitions
4. Search mode: Contains
5. Click Search

**Result:** All triggers that reference "Orders" table

```
Example Results:
✓ dbo.trg_Orders_Audit - Trigger (in code)
✓ dbo.trg_Orders_UpdateTimestamp - Trigger (in code)
✓ dbo.trg_Cascade_OrderItems - Trigger (in code)
```

---

### **Use Case 8: Code Audit - Remove Deprecated Procedure Calls**

**Scenario:** `dbo.OldProcedure` is deprecated. Find all procedures that call it.

**Steps:**
1. Search term: `OldProcedure`
2. Object types: ☑ Stored Procedures
3. Match locations: ☑ Code Definitions (only)
4. Search mode: Contains
5. AI filtering: ☑ Enabled (remove commented references)
6. Click Search

**Result:** Only active calls to OldProcedure (comments filtered out)

---

### **Use Case 9: Find All Objects by Naming Convention**

**Scenario:** Find all procedures starting with `sp_Get` for documentation.

**Steps:**
1. Search term: `sp_Get`
2. Object types: ☑ Stored Procedures
3. Match locations: ☑ Object Names
4. Search mode: Starts With
5. Click Search

**Result:** `sp_GetCustomer`, `sp_GetOrders`, `sp_GetInventory`, etc.

---

### **Use Case 10: Find SQL Agent Jobs That Reference a Procedure or Integration Target**

**Scenario:** You need to find which SQL Agent Jobs reference a procedure, website, vendor, queue, or integration endpoint before making a change.

**Steps:**
1. Search menu → Search Current Server
2. Enter a search term such as `Agent_Harvest`, `Service Broker`, or a vendor/site token
3. Enable **SQL Agent Jobs**
4. Use a search mode such as **Contains**
5. Click Search

**Result:** Matching SQL Agent Jobs are returned from `msdb`.

**Next step workflow:**
1. Open the matching Agent Job result
2. Review the Agent dependency graph
3. Open linked stored procedures in the Dependency Analyzer
4. If needed, continue with Git-side save/archive/report workflows via the [Git Integration Guide](Git_Integration_Guide.md)

---

## Performance Tips

### **Optimize Search Speed**

**1. Narrow Search Scope**
```
❌ Slow:  All Servers + All Databases + All Match Locations
✅ Fast:  Current Server + Selected Databases + Names Only
```

**2. Use Specific Search Terms**
```
❌ Slow:  "a" (matches everything)
✅ Fast:  "GetCustomer" (specific)
```

**3. Choose Right Search Mode**
```
❌ Slow:  Contains (broadest)
✅ Fast:  Exact Match (narrowest)
```

**4. Limit Result Count**
```
❌ Slow:  Unlimited results
✅ Fast:  500 results limit
```

**5. Skip AI Filtering When Possible**
```
❌ Slow:  AI filtering on 200 results (+60 seconds)
✅ Fast:  No AI filtering (instant)
```

---

### **Recommended Settings by Use Case**

**Quick Object Lookup:**
```
Match Locations: Names only
Search Mode: Exact Match
Result Limit: 100
Speed: ⚡⚡⚡ 1-2 seconds
```

**Schema Analysis:**
```
Match Locations: Names + Columns
Search Mode: Contains
Result Limit: 500
Speed: ⚡⚡ 3-5 seconds
```

**Comprehensive Code Search:**
```
Match Locations: All three
Search Mode: Contains
Result Limit: 500
AI Filtering: No
Speed: 🐢 15-20 seconds
```

**High-Precision Code Search:**
```
Match Locations: Code only
Search Mode: Contains
Result Limit: 500
AI Filtering: Yes
Speed: 🐢🐢 45-60 seconds
```

---

## Troubleshooting

### **Problem: No Results Found**

**Possible Causes:**
1. Search term doesn't match any objects
2. All matching objects are system objects (excluded)
3. Match location filters too restrictive
4. Wrong databases selected

**Solutions:**
- ✅ Try broader search term (e.g., "Get" instead of "GetCustomer")
- ✅ Uncheck "Exclude system objects"
- ✅ Enable all match locations (Names + Code + Columns)
- ✅ Click "Select All" databases
- ✅ Change search mode to "Contains"

---

### **Problem: Too Many Results**

**Possible Causes:**
1. Search term too generic (e.g., "a", "id")
2. "Contains" mode too broad
3. All databases selected
4. No result limit

**Solutions:**
- ✅ Use more specific search term
- ✅ Try "Exact Match" or "Starts With" mode
- ✅ Select specific databases only
- ✅ Set result limit to 100 or 250
- ✅ Enable AI filtering to remove false positives

---

### **Problem: Search is Slow**

**Possible Causes:**
1. Too many databases (50+)
2. "Code Definitions" match location enabled
3. AI filtering enabled
4. Unlimited results

**Solutions:**
- ✅ Search fewer databases
- ✅ Disable "Code Definitions" if not needed
- ✅ Disable AI filtering (saves 30-60 seconds)
- ✅ Set result limit to 500

---

### **Problem: AI Filtering Unavailable**

**Error Message:** "AI filtering unavailable"

**Possible Causes:**
1. Not logged in
2. "Search inside code" not enabled
3. No Grok API key assigned

**Solutions:**
- ✅ Check you're logged in (see environment bar)
- ✅ Enable "Code Definitions" match location
- ✅ Contact administrator to verify API key assignment

---

### **Problem: Permission Denied**

**Error Message:** "Permission denied accessing database"

**Possible Causes:**
1. User lacks VIEW DEFINITION permission
2. Database in recovery mode
3. Database offline

**Solutions:**
- ✅ Contact database administrator
- ✅ Request VIEW DEFINITION permission on database
- ✅ Exclude that database from search
- ✅ Check database status in SQL Server Management Studio

---

### **Problem: Multi-Server Search Failed**

**Error Message:** "Multi-server search failed on some servers"

**Possible Causes:**
1. Connection timeout
2. Authentication failure
3. Network issues
4. Server offline

**Solutions:**
- ✅ Check error message in results window
- ✅ Verify you can connect to server manually
- ✅ Test authentication settings in Server Explorer
- ✅ Partial results from successful servers still shown

---

### **Problem: Search Results Not Opening in Analyzer**

**Possible Causes:**
1. Maximum 10 analyzer tabs already open
2. Object type not supported for analysis

**Solutions:**
- ✅ Close unused analyzer tabs (click ✖)
- ✅ Check object type (some constraints can't be analyzed)
- ✅ Try right-click → Analyze Dependencies

---

## Keyboard Shortcuts

| Shortcut | Action | Context |
|----------|--------|---------|
| **Enter** | Execute search | Search dialog |
| **Escape** | Close dialog | Search dialog |
| **Ctrl+A** | Select all databases | Database list |
| **Ctrl+C** | Copy selected result | Results window |
| **F5** | Refresh results | Results window |
| **Double-Click** | Open in Dependency Analyzer | Results row |

---

## Additional Resources

**Related Features:**
- [Object Search](Concise_Guide.md#use-object-search) - Search within current database
- [Dependency Analyzer](User_Guide_Full.md#step-8-review-analysis-results) - Analyze search results
- [Multi-Tab Workflow](Concise_Guide.md#multi-tab-workflow) - Work with multiple objects
- [Git Integration Guide](Git_Integration_Guide.md) - Save Agent workflows to Git, manage Active/Archive, review Repo Changes

**Documentation:**
- [Quick Start Guide](Quick_Start_Guide.md) - Getting started
- [Concise Guide](Concise_Guide.md) - Essential features
- [Reference Guide](Reference_Guide.md) - Quick lookup
- [Full User Guide](User_Guide_Full.md) - Complete reference

---

## Summary

**Cross-Database Search is:**
- ✅ **Fast** - 20x faster than sequential searching
- ✅ **Comprehensive** - Searches names, code, columns
- ✅ **Flexible** - Multiple search modes and filters
- ✅ **Powerful** - Multi-server support
- ✅ **Smart** - Optional AI filtering

**Best Practices:**
1. Start with "Names Only" for quick lookups
2. Use "Contains" mode for exploratory searching
3. Enable AI filtering for high-precision code searches
4. Limit results to 500 for performance
5. Use multi-server search for environment-wide analysis

**Remember:**
- More match locations = slower search
- AI filtering adds 30-60 seconds
- System object exclusion is recommended
- Result limits improve performance
- Agent Job search is current-server only and opens an Agent-specific workflow

---

---

**End of Search Feature Guide** | **Version:** 1.0 | **Last Updated:** November 2025  
**For more help:** See [Full User Guide](User_Guide_Full.md)
