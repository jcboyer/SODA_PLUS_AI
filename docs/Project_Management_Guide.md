# 📁 SqlLens - Project Management Guide
## Organize, Save, and Copy Your Database Objects Across Environments

---

**Version:** 1.0 | **Last Updated:** January 2026  
**Feature:** Project Management & Cross-Environment Copying | **Estimated Time:** 15 minutes

---

## 📑 **Table of Contents**

1. [Overview](#overview)
2. [What are Projects?](#what-are-projects)
3. [Key Features](#key-features)
4. [Getting Started](#getting-started)
   - [Opening Project Manager](#opening-project-manager)
   - [Creating Your First Project](#creating-your-first-project)
   - [Adding Objects to a Project](#adding-objects-to-a-project)
5. [Working with Projects](#working-with-projects)
   - [Viewing Project Details](#viewing-project-details)
   - [Opening All Objects](#opening-all-objects)
   - [Editing Projects](#editing-projects)
   - [Deleting Projects](#deleting-projects)
6. [Cross-Environment Features](#cross-environment-features)
   - [Server Translation Rules](#server-translation-rules)
   - [Copying Projects to Different Environments](#copying-projects-to-different-environments)
7. [Common Use Cases](#common-use-cases)
8. [Best Practices](#best-practices)
9. [Troubleshooting](#troubleshooting)
10. [Keyboard Shortcuts](#keyboard-shortcuts)

---

## Overview

**Project Management** in SqlLens allows you to organize and save collections of database objects (procedures, tables, views, functions) into persistent projects. Think of projects as **folders** or **bookmarks** for your database work.

**What makes it special:**
- ✅ **Persistent** - Projects are saved to the cloud and available across sessions
- ✅ **Organized** - Group related objects together (e.g., "Customer Module", "Order Processing")
- ✅ **Quick Access** - Open all project objects with one click
- ✅ **Cross-Environment** - Copy projects from DEV → TEST → PROD with automatic server translation
- ✅ **Shareable** - Projects are tied to your account and accessible from any machine

---

## What are Projects?

A **Project** is a named collection of database objects that you want to keep together.

**Example Projects:**
- **"Customer Orders - Phase 1"** - 15 procedures and 5 tables related to order processing
- **"Security Audit"** - All procedures accessing sensitive customer data
- **"Migration - Q1 2025"** - Objects that need to be migrated to new environment
- **"Performance Improvements"** - Procedures identified for optimization

**Each Project Contains:**
- **Project Name** - Descriptive name (e.g., "Customer Orders - Phase 1")
- **Description** - Optional notes (e.g., "Objects for initial customer order release")
- **Environment** - The primary environment (DEV, TEST, UAT, PROD)
- **Object List** - Collection of stored procedures, tables, views, functions
  - Each object includes: Name, Type, Server, Database, Schema

**Projects are Saved:**
- ✅ In Azure SQL Database (cloud)
- ✅ Tied to your user account
- ✅ Available on any machine where you login
- ✅ Persistent across SODA+ sessions

---

## Key Features

### 📁 **Project Organization**
- **Create Projects** - Group related database objects
- **Add Objects** - From analyzer toolbar with one click
- **View Details** - See all objects in a project with metadata
- **Object Count** - Track how many objects in each project
- **Last Modified** - See when project was last updated

### 🚀 **Quick Access**
- **Open All Objects** - Open analyzer tabs for all objects with one button
- **Project Selection** - Quick dialog to select project when adding objects
- **Default Project** - Set a default project for rapid additions
- **Auto-Select** - Newly created projects are automatically selected

### 🌍 **Cross-Environment**
- **Environment Badges** - Visual indicators (DEV = green, TEST = orange, PROD = red)
- **Server Translation** - Define rules to map server names across environments
- **Copy Projects** - Duplicate entire projects from DEV → TEST → PROD
- **Automatic Translation** - Server names are translated automatically during copy
- **Unmapped Warnings** - Get alerts for servers without translation rules

### 🔄 **Project Management**
- **Edit Projects** - Change name or description anytime
- **Delete Projects** - Remove projects with confirmation
- **Remove Objects** - Remove individual objects from projects
- **Refresh** - Reload projects from server

---

## Getting Started

### Opening Project Manager

**Option 1: From Menu** (Recommended)
1. Click **File** → **Project Manager** (or similar menu location)
2. Project Manager dialog opens

**Option 2: After Adding Object**
1. Analyze any database object (procedure, table, view)
2. Click **📁 Add to Project** in analyzer toolbar
3. Project Manager dialog opens automatically

---

### Creating Your First Project

**Step 1: Open Project Manager**
- Follow steps above to open Project Manager

**Step 2: Click "➕ New Project"**
- Green button in top-right toolbar

**Step 3: Fill in Project Details**
```
Create New Project Dialog:

Project Name: *Required
   Customer Orders - Phase 1

Primary Environment: *Required
   ● DEV (Green)
   ○ TEST (Orange)
   ○ UAT (Yellow)
   ○ PROD (Red)

Description: Optional
   Initial release of customer order processing module.
   Includes order creation, updates, and reporting procedures.

   Click [Create]
```

**✅ Success!** Your project appears in the project list with:
- 📁 Project name
- 🟢 Environment badge (DEV)
- 📦 0 objects (initially)
- 📅 Today's date

---

### Adding Objects to a Project

**Method 1: From Analyzer Toolbar** (Most Common)

1. **Analyze an Object**
   - Open any stored procedure, table, or view in SqlLens
   - Example: Right-click `dbo.usp_GetCustomerOrders` → Analyze

2. **Click "📁 Add to Project"**
   - Button is in analyzer toolbar (after Export button)

3. **Choose Project**
   - If you have existing projects:
     - **Project Selection Dialog** appears
     - Select project from list
     - Click **[Add to Project]**
   
   - If no projects exist:
     - Prompt: "No projects found. Create one?"
     - Click **[Yes]** → Create Project dialog opens
     - Follow "Creating Your First Project" steps above

4. **Confirmation**
   - Status bar shows: "✅ Added to project: Customer Orders - Phase 1"

**Method 2: From Project Manager** (Batch Mode)

1. Open **Project Manager**
2. Analyze multiple objects and add them one by one using Method 1
3. Keep Project Manager open to see objects accumulate in real-time

---

## Working with Projects

### Viewing Project Details

**Step 1: Open Project Manager**
- Menu: **File** → **Project Manager**

**Step 2: Select a Project**
- Click on any project in the **left panel**
- **Right panel** shows all objects:
  - ⚙️ **Procedures** - Stored procedures
  - 👁️ **Views** - Database views
  - 📊 **Tables** - Tables
  - ƒ **Functions** - Scalar/Table-valued functions
  
**Each Object Shows:**
- **Name** - e.g., `dbo.usp_GetCustomerOrders`
- **Type** - Procedure, Table, View, Function
- **Server** - `SQL-PROD-01`
- **Database** - `ERP_Production`
- **Environment** - (DEV) badge

**Object Actions:**
- **❌ Remove** - Click red X to remove from project (confirmation required)

---

### Opening All Objects

**Use Case:** You have a project with 10 procedures you need to review.

**Step 1: Select Project**
- In Project Manager, click on the project

**Step 2: Click "🚀 Open All Objects"**
- Green button in top-right of right panel
- Analyzer tabs open for **every object** in the project

**Result:**
```
10 Analyzer Tabs Open:
   [dbo.usp_GetCustomerOrders]
   [dbo.usp_UpdateCustomer]
   [dbo.usp_DeleteOrder]
   [dbo.vw_CustomerDetails]
   [dbo.usp_CalculateTotal]
   ...
```

**✅ Instant Access** - All objects loaded with SQL code and dependencies!

---

### Editing Projects

**Step 1: Select Project**
- Click project in left panel

**Step 2: Click "✏️ Edit"**
- Button in bottom action bar

**Step 3: Modify Details**
```
Edit Project Dialog:

Project Name:
   Customer Orders - Phase 1 ✏️

Description:
   Updated: Phase 1 complete. Ready for TEST deployment. ✏️

   Click [Save]
```

**✅ Changes Saved** - Project list updates instantly

**Note:** You **cannot** change the Primary Environment after creation. If you need a different environment, use the **Copy Project** feature (see below).

---

### Deleting Projects

**⚠️ Warning:** Deleting a project removes it permanently. Objects themselves are not deleted from the database, only the project container.

**Step 1: Select Project**
- Click project in left panel

**Step 2: Click "🗑️ Delete"**
- Red button in bottom action bar

**Step 3: Confirm Deletion**
```
Confirmation Dialog:

⚠️ Delete Project?

Are you sure you want to delete "Customer Orders - Phase 1"?
This will remove the project and all its object associations.

The database objects themselves will NOT be deleted.

   [Yes, Delete]  [Cancel]
```

**Step 4: Confirm Again**
- Click **[Yes, Delete]**

**✅ Project Deleted** - Removed from list

---

## Cross-Environment Features

### Server Translation Rules

**What are Translation Rules?**

Translation Rules define how server names should be mapped when copying projects across environments.

**Example:**
```
DEV Environment → TEST Environment:
   DEV-SQL-01\INSTANCE  →  TEST-SQL-01\INSTANCE
   DEV-SQL-02           →  TEST-SQL-02
   DEV-ANALYTICS        →  TEST-ANALYTICS
```

**Why are they needed?**

When you copy a project from **DEV** to **TEST**, the database objects reference server names like `DEV-SQL-01`. In TEST, you need these to become `TEST-SQL-01` automatically.

**Without Translation Rules:**
- ❌ Manual editing required for every server reference
- ❌ Error-prone (easy to miss servers)
- ❌ Time-consuming

**With Translation Rules:**
- ✅ Automatic server name translation
- ✅ Reusable rules for future copies
- ✅ Warnings for unmapped servers

---

### Managing Translation Rules

**Step 1: Open Translation Rules Manager**
- In **Project Manager**, click **🔄 Translation Rules**
- Orange button in top toolbar

**Step 2: Create a Translation Rule**

Click **➕ Add Rule**

```
Translation Rule Editor:

Source Environment: *Required
   ● DEV
   ○ TEST
   ○ UAT
   ○ PROD

Source Server Name: *Required
   DEV-SQL-01\INSTANCE

Target Environment: *Required
   ○ DEV
   ● TEST
   ○ UAT
   ○ PROD

Target Server Name: *Required
   TEST-SQL-01\INSTANCE

Description: Optional
   Primary SQL Server for application data

Active:
   ☑ Rule is active (use for translations)

   Click [💾 Save Rule]
```

**✅ Rule Created!**

**Step 3: Create More Rules**
- Repeat for each server that needs translation
- You can create rules for:
  - DEV → TEST
  - DEV → UAT
  - DEV → PROD
  - TEST → UAT
  - TEST → PROD
  - UAT → PROD

**Managing Rules:**
- **Edit Rule** - Click rule in list, modify fields, click Save
- **Delete Rule** - Click rule, click **🗑️ Delete Rule**
- **Toggle Active** - Uncheck "Active" to temporarily disable a rule

**Important Notes:**
- ✅ Server names are **automatically normalized** (uppercase, FQDN stripped)
- ✅ Instance names are **preserved** (`\INSTANCE` remains)
- ✅ Rules are **reusable** - create once, use for all project copies

---

### Copying Projects to Different Environments

**Use Case:** You've developed 25 procedures in **DEV** and need them in **TEST**.

**Step 1: Setup Translation Rules** (One-Time)
- Follow "Managing Translation Rules" above
- Create rules for **DEV → TEST** server mappings

**Step 2: Select Source Project**
- In Project Manager, select your DEV project
- Example: "Customer Orders - Phase 1" (DEV environment)

**Step 3: Click "📋 Copy to..."**
- Blue button in bottom action bar (between Edit and Delete)

**Step 4: Configure the Copy**
```
Copy Project Dialog:

📁 Source Project
   Name: Customer Orders - Phase 1
   Environment: DEV (Green badge)
   Objects: 25

➡️ Copy Settings

Target Environment: *Required
   ○ DEV
   ● TEST (Orange badge)
   ○ UAT
   ○ PROD

New Project Name: *Required
   Customer Orders - TEST

New Description: Optional
   TEST environment deployment of Customer Orders module

🔍 Translation Preview

   Server Translation:
   ✅ 3 servers will be translated
   ⚠️ 0 unmapped servers

   💡 Tip: Review translation rules to ensure all servers are mapped

   Click [📋 Copy Project]
```

**Step 5: Review & Confirm**
- Click **[📋 Copy Project]**

**Confirmation Dialog:**
```
⚠️ Copy Project?

This will create a new project with 25 objects in TEST environment.
Server names will be translated automatically.

   [Yes, Copy]  [Cancel]
```

**Step 6: Success!**
```
✅ Project Copied Successfully!

New Project: Customer Orders - TEST
Objects Copied: 25
Servers Translated: 3
Unmapped Servers: 0

The new project has been created in TEST environment.
```

**✅ Result:**
- New project appears in project list
- **Environment badge** shows TEST (orange)
- All 25 objects copied with **translated server names**:
  - `DEV-SQL-01\INSTANCE` → `TEST-SQL-01\INSTANCE`
  - `DEV-SQL-02` → `TEST-SQL-02`
  - `DEV-ANALYTICS` → `TEST-ANALYTICS`

**Step 7: Verify the Copy**
- Select the new project in left panel
- Click **🚀 Open All Objects**
- Review objects to confirm server names are correct

---

### Handling Unmapped Servers

**What if a server doesn't have a translation rule?**

**Example:**
```
Your DEV project references:
   ✅ DEV-SQL-01 (HAS rule → TEST-SQL-01)
   ✅ DEV-SQL-02 (HAS rule → TEST-SQL-02)
   ❌ DEV-REPORTING-SERVER (NO rule!)
```

**During Copy:**
```
⚠️ Warning: Unmapped Servers

The following servers do not have translation rules:
   • DEV-REPORTING-SERVER
   • DEV-OLD-ARCHIVE

These servers will keep their original names in the copied project.
You may need to update them manually or create translation rules.

   [Continue Anyway]  [Cancel and Add Rules]
```

**Options:**
1. **Continue Anyway** - Copy proceeds, unmapped servers keep original names
2. **Cancel and Add Rules** - Go back and create translation rules first

**Best Practice:** Create all translation rules **before** copying projects to avoid manual editing.

---

## Common Use Cases

### Use Case 1: Daily Development

**Scenario:** You're working on a new feature that spans 10 procedures and 3 tables.

**Workflow:**
1. **Create Project:** "Feature X - Development"
2. **Analyze Objects:** As you work on each procedure/table
3. **Add to Project:** Click 📁 Add to Project after each analysis
4. **Quick Access:** Open Project Manager → Open All Objects to review everything
5. **Iterate:** Continue development, adding new objects as needed

**Benefits:**
- ✅ All related objects in one place
- ✅ Quick access for code review
- ✅ Easy to track progress (10/10 objects complete)

---

### Use Case 2: Code Migration

**Scenario:** Migrate 50 procedures from DEV → TEST → PROD.

**Workflow:**
1. **Setup Translation Rules:**
   - DEV → TEST server mappings
   - TEST → PROD server mappings

2. **Create DEV Project:**
   - "Q1 Migration - Wave 1"
   - Add all 50 procedures

3. **Copy to TEST:**
   - Select project, click Copy
   - Target: TEST
   - New name: "Q1 Migration - Wave 1 (TEST)"
   - All server names translated automatically

4. **Test in TEST:**
   - Open All Objects in TEST project
   - Run tests, verify functionality

5. **Copy to PROD:**
   - Select TEST project, click Copy
   - Target: PROD
   - New name: "Q1 Migration - Wave 1 (PROD)"
   - Server names translated DEV → TEST → PROD

**Benefits:**
- ✅ No manual server name editing
- ✅ Consistent deployments across environments
- ✅ Reusable translation rules for future migrations
- ✅ Clear audit trail (3 projects: DEV, TEST, PROD)

---

### Use Case 3: Security Audit

**Scenario:** Identify all procedures accessing `dbo.Customers` table.

**Workflow:**
1. **Use Cross-Database Search:**
   - Search for: "Customers"
   - Match Location: Code Content
   - Find 30 procedures

2. **Create Project:** "Security Audit - Customer Access"

3. **Add All 30 Procedures:**
   - Analyze each one
   - Click 📁 Add to Project

4. **Review:**
   - Project Manager → Open All Objects
   - Review all 30 procedures in analyzer tabs
   - Document findings

**Benefits:**
- ✅ Persistent list of audited objects
- ✅ Easy to revisit later
- ✅ Can share project name with team (future: project sharing)

---

### Use Case 4: Performance Optimization

**Scenario:** Track procedures identified for optimization.

**Workflow:**
1. **Create Project:** "Performance - Phase 1"
2. **Add Slow Procedures:**
   - Analyze each slow procedure
   - Add to project with notes in description

3. **Optimize:**
   - Open All Objects
   - Work through each procedure
   - Remove from project after optimization

4. **Track Progress:**
   - Object count shows remaining work (e.g., "12 objects")

**Benefits:**
- ✅ Clear todo list
- ✅ Track progress (remove objects as you complete them)
- ✅ Quick access to all target procedures

---

## Best Practices

### 1. **Use Descriptive Project Names**
✅ **Good:**
- "Customer Orders - Phase 1"
- "Q1 2025 Migration - Wave 1"
- "Security Audit - PII Access"

❌ **Bad:**
- "Project 1"
- "Stuff"
- "Temp"

### 2. **Include Environment in Project Name**
When copying projects across environments, include environment in the name:
- "Customer Orders - DEV"
- "Customer Orders - TEST"
- "Customer Orders - PROD"

This makes it clear which version is which.

### 3. **Setup Translation Rules Early**
Create all DEV → TEST → PROD translation rules **before** starting development:
- ✅ Rules are reusable for all future projects
- ✅ Avoids manual editing during migrations
- ✅ Reduces errors

### 4. **Use Projects as Deployment Checklists**
Create a project for each deployment:
- Add all objects that need to be migrated
- Copy project to target environment
- Open All Objects to verify
- Remove objects from project as you deploy them

### 5. **Leverage Descriptions**
Add detailed descriptions to projects:
```
Description:
   Q1 2025 Migration - Wave 1
   
   Includes:
   - Customer order processing (10 procedures)
   - Reporting views (5 views)
   - Helper functions (3 functions)
   
   Status: Ready for TEST deployment
   Owner: John Smith
   Jira: PROJ-1234
```

### 6. **Clean Up Old Projects**
Periodically delete projects you no longer need:
- ✅ Completed migrations
- ✅ One-off audits
- ✅ Temporary analysis projects

This keeps your project list manageable.

### 7. **Set a Default Project for Rapid Development**
If you're working on one main project:
- Select the project
- Click **⭐ Set Default**
- Future "Add to Project" actions will use this project by default

---

## Troubleshooting

### Problem: "No projects found" when trying to add object

**Cause:** You haven't created any projects yet.

**Solution:**
1. Click **[Create New Project]** in the prompt
2. Fill in project details
3. After creation, object will be added automatically

---

### Problem: Translation rules not working during copy

**Symptoms:**
- Server names unchanged after copy
- Unmapped server warnings

**Solution:**
1. Verify rules are **Active** (checkbox in Translation Rules dialog)
2. Check **Source Environment** matches project environment (e.g., DEV)
3. Check **Target Environment** matches copy target (e.g., TEST)
4. Verify **Source Server Name** matches exactly (case-insensitive, but spacing matters)

**Server Name Normalization:**
- Rules automatically strip FQDN: `server.domain.com` → `SERVER`
- Rules convert to uppercase: `server` → `SERVER`
- Instance names preserved: `SERVER\INSTANCE`

---

### Problem: Can't find Project Manager in menu

**Solution:**
1. **Quick Access:** Analyze any object → Click **📁 Add to Project**
2. **Menu:** Check File → Project Manager (or Tools → Project Manager)
3. If not visible, contact administrator to enable feature

---

### Problem: Objects missing from project after refresh

**Cause:** Project was deleted or objects were removed by another user.

**Solution:**
1. Check if project still exists in left panel
2. If project deleted, you'll need to recreate it
3. If objects removed, re-add them using **📁 Add to Project**

---

### Problem: Copy Project creates duplicate objects

**Expected Behavior:** Copying creates a **new project** with **copies** of objects. Original project and objects remain unchanged.

**This is normal:**
- DEV project: "Customer Orders - Phase 1" (25 objects)
- TEST project: "Customer Orders - TEST" (25 objects)

Both projects exist independently.

---

### Problem: Server names not translating correctly

**Symptoms:**
```
Expected: TEST-SQL-01
Actual: DEV-SQL-01 (unchanged)
```

**Debugging Steps:**
1. **Check Translation Rule:**
   - Open Translation Rules
   - Verify rule exists: `DEV-SQL-01` → `TEST-SQL-01`
   - Ensure Source Environment = DEV
   - Ensure Target Environment = TEST
   - Ensure rule is **Active**

2. **Check Server Name Format:**
   - Rules normalize names: `DEV-sql-01.domain.com` → `DEV-SQL-01`
   - Verify your object uses `DEV-SQL-01` (not `DEV-sql-01` with different case)

3. **Re-create Rule:**
   - Delete existing rule
   - Create new rule with exact server names
   - Try copy again

---

## Keyboard Shortcuts

| Shortcut | Action | Context |
|----------|--------|---------|
| **Ctrl + P** | Open Project Manager | Main Window |
| **Ctrl + N** | Create New Project | Project Manager |
| **Ctrl + T** | Open Translation Rules | Project Manager |
| **Ctrl + E** | Edit Selected Project | Project Manager |
| **Delete** | Delete Selected Project | Project Manager |
| **Enter** | Open Project Details | Project List |
| **Ctrl + O** | Open All Objects | Project Details |
| **Escape** | Close Dialog | Any Dialog |

---

## Summary

**Project Management in SqlLens provides:**
- ✅ **Persistent Collections** - Save groups of related database objects
- ✅ **Quick Access** - Open all project objects with one click
- ✅ **Cross-Environment** - Copy projects from DEV → TEST → PROD
- ✅ **Automatic Translation** - Server names mapped automatically via rules
- ✅ **Organized Workflow** - Group objects by feature, migration, audit, etc.

**Key Features:**
1. **Create Projects** - Group related objects
2. **Add Objects** - One-click from analyzer toolbar
3. **Open All** - Load all objects instantly
4. **Translation Rules** - Define server name mappings
5. **Copy Projects** - Duplicate across environments with automatic translation

**Next Steps:**
1. Create your first project
2. Add some database objects
3. Setup translation rules for DEV → TEST
4. Try copying a project to TEST
5. Open All Objects to verify

**Questions?** Check the [SqlLens User Guide](User_Guide_Full.md) or contact support.

---

**Happy Organizing!** 🎉
