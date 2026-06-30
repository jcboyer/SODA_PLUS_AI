# SqlLens — SQL Server Agent Jobs Guide

> **Version 1.9.0+** · Requires SQL Server Agent access on your connected server

## Overview

SqlLens provides first-class support for **SQL Server Agent Job management** — letting you visualize job structures, track stored procedure dependencies, detect drift between your live database and Git, and export change history as CSV.

This feature is unique to the SqlLens Desktop application.

---

## Getting Started

Access Agent Job features from the **main menu → Agent Jobs** (or press `Alt+J`).

You must be connected to a SQL Server instance where you have read access to `msdb.dbo.sysjobs` and `msdb.dbo.sysjobsteps`.

---

## Features

### 1. Agent Job Dependency Graph

**Menu → Agent Jobs → Dependency Graph**

Visualizes the full dependency tree of a selected Agent Job:

```
▶ Job: Harvest Shopify
  ├── Step 1: Retrieve Orders (T-SQL → VendorDB)
  │     └── dbo.RetrieveShopifyOrders
  │           └── dbo.MapOrderItems
  └── Step 2: Update Catalog (T-SQL → MainDB)
        └── dbo.RunCatalog
              └── dbo.RefreshProductIndex
```

- **Job root node** — shows job name and enabled/disabled status
- **Step nodes** — each T-SQL step with its target database
- **EXEC call nodes** — stored procedures confirmed to exist in the step target database
- Non-T-SQL steps (SSIS, PowerShell, etc.) are shown but not expanded

**How it works:** SqlLens tokenizes the step command, strips string literals and comments, then validates candidate identifiers against real stored procedures in the step target database. Only confirmed procs are shown.

---

### 2. Agent Job Script List

**Menu → Agent Jobs → Script List**

Displays all Agent Job step scripts stored in Git, organized by server and job:

| Column | Description |
|--------|-------------|
| Server | SQL Server instance name |
| Job | Agent job name |
| Step | Step number |
| Status | Active / Archived |
| Last Modified | Commit date |

Scripts are stored **Base64-encoded at rest** in Git to preserve exact formatting and avoid line-ending drift.

**Active vs Archived:** Scripts can be archived when a job is retired — they stay in Git history for auditing but are clearly marked.

---

### 3. Git Drift Detection

SqlLens compares every Agent Job step script in your live database against the version stored in Git and flags any divergence:

| Status | Meaning |
|--------|---------|
| ✓ **In Sync** | DB and Git are identical |
| ⬆ **DB Ahead** | Live DB has changes not yet committed to Git |
| ⬇ **Git Ahead** | Git has a newer version not yet applied to DB |
| ❌ **Not in Git** | Job exists in DB but no script committed yet |
| ❌ **Not in DB** | Script in Git but job no longer exists in DB |
| ⚠ **Error** | Comparison failed (permissions, connectivity) |

Drift is computed by normalizing scripts (stripping comments and whitespace) then comparing SHA-256 hashes — cosmetic differences are ignored.

---

### 4. Agent Repo Changes Report

**Menu → Agent Jobs → Repo Changes**

Shows the full Git commit history for all Agent Job scripts in the repository:

| Column | Description |
|--------|-------------|
| Date | Commit timestamp (UTC) |
| SHA | Short commit hash |
| Author | Committer name |
| Change | Added / Modified / Deleted |
| Path | Script file path in repo |
| Message | Commit message |

**Export to CSV:** Click **Export CSV** to save the full report for auditing or ticket tracking. File is timestamped automatically (`agent-repo-changes-YYYYMMDD-HHmmss.csv`).

---

## Git Storage Layout

Agent job scripts are stored under `AgentScripts/` in your configured Git repository:

```
AgentScripts/
  Active/
    SERVERNAME_JobName.sql        ← live jobs
  Archive/
    SERVERNAME_JobName.sql        ← retired/disabled jobs
```

Base64 encoding is applied before storage and reversed on retrieval.

---

## Git Repository Mapping

SqlLens uses **Git Target Mapping** (Settings → Git → Agent Targets) to determine which repository stores scripts for each SQL Server instance. Multiple servers can map to the same repo or separate repos.

---

## Requirements

- SQL Server 2016 or later
- `SQLAgentReaderRole` in `msdb` (read-only) or `sysadmin`
- GitHub PAT configured in Settings with `repo` scope
- Git repository mapped for the connected server

---

## Tips

- Run **Dependency Graph** before modifying a job step — see exactly which stored procedures will be affected
- Run **Drift Detection** after a deployment to confirm all changes were committed to Git
- Use **Repo Changes + CSV export** for sprint retrospectives or change-management documentation
- **Archive** retired jobs rather than deleting — preserves history for compliance

---

*Part of the [SqlLens SQL Server Analysis & Visualization](https://marketplace.visualstudio.com/items?itemName=sqllens.sqllens-sql-server-tools) toolset by [Thoughts In Motion](https://sodaplusai.com)*