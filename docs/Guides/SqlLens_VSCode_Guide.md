# SqlLens VS Code Extension — User Guide

> **Extension:** SqlLens SQL Server Tools · Publisher: sqllens · Version 0.0.2+
> **Install:** [Visual Studio Marketplace](https://marketplace.visualstudio.com/items?itemName=sqllens.sqllens-sql-server-tools)

## Overview

The SqlLens VS Code extension brings SQL Server dependency analysis directly into your editor workflow. Analyze stored procedures, views, functions, and tables without leaving VS Code — and connect to the same SqlLens account you use in the Desktop application.

> **Note:** The VS Code extension and the Desktop application share the same account and server connections. Features unique to the Desktop (Mermaid diagrams, AI code review, database compare, Agent Jobs) are listed in the [Feature Comparison](Feature_Comparison.md).

---

## Installation

1. Open VS Code Extensions (`Ctrl+Shift+X`)
2. Search **SqlLens SQL Server Tools**
3. Click **Install** — reload if prompted

**Recommended:** Install [SQL Server (mssql)](https://marketplace.visualstudio.com/items?itemName=ms-mssql.mssql) to unlock right-click analysis from the mssql Object Explorer.

---

## Getting Started

### Step 1 — Sign In

Open Command Palette (`Ctrl+Shift+P`):

```
SqlLens: Login
```

Enter your SqlLens email and password. No account yet? Run **SqlLens: Register** first.

### Step 2 — Add a SQL Server

```
SqlLens: Add Server
```

| Field | Example |
|-------|---------|
| Server name | `localhost` or `.\SQLEXPRESS` |
| Database | `MyDatabase` |
| Username | `sa` (SQL auth) |
| Password | your password |

### Step 3 — Open Server Explorer

Click the **SqlLens icon** in the Activity Bar (left sidebar) to open the Server Explorer panel. Expand a server to browse databases and objects.

---

## Server Explorer Panel

```
▶ localhost
  └── MyDatabase
        ├── Stored Procedures
        │     └── dbo.GetOrderSummary    [graph icon]
        ├── Views
        │     └── dbo.vw_ActiveOrders    [graph icon]
        ├── Functions
        │     └── dbo.fn_FormatDate      [graph icon]
        └── Tables
              └── dbo.Orders             [graph icon]
```

**Toolbar:**
- 🔍 **Search Objects** — filter tree by name
- 🔄 **Refresh** — reload from server

**Right-click a database:** Search Objects · Compare with Git

**Right-click a stored procedure / view / function / table:** Analyze Dependencies

---

## Core Features

### Dependency Analysis

Three ways to trigger:

**1. From Server Explorer**
Right-click any stored procedure, view, function, or table → **Analyze Dependencies**

**2. From mssql Object Explorer**
Right-click any object in the mssql extension tree → **SqlLens: Analyze Dependencies**
*(Supports: Tables, Views, Stored Procedures, Scalar Functions, Table-Valued Functions)*

**3. From SQL editor selection**
Highlight an object name in any `.sql` file → right-click → **SqlLens: Analyze SQL Object Dependencies**
*(File must be `.sql` or `mssql` language and have an active selection)*

---

### Cross-Database Search

```
SqlLens: Search Across Databases
```

Searches all databases on the connected server simultaneously. Results show database, schema, object name, and type. Also accessible via the 🔍 toolbar icon or right-click on a database node.

---

### Compare Database with Git

```
SqlLens: Compare Database with Git
```

Diffs stored procedure definitions in your live database against versions committed in your mapped Git repository. Shows added, modified, and deleted objects. Requires GitHub PAT and a server → repo mapping (see Git Setup below).

---

### Batch Review Notifications

```
SqlLens: Configure Batch Review Notifications
```

Schedule automated AI analysis jobs on a set of SQL objects. Configure frequency, target objects, and notification preferences. Results are delivered as VS Code notifications.

---

### Explore GitHub Repo Structure

```
SqlLens: Explore GitHub Repo Structure
```

Browse the folder and file tree of your mapped GitHub repository from inside VS Code.

---

## Git & GitHub Setup

### 1. Configure GitHub PAT

```
SqlLens: Configure GitHub PAT
```

Enter a GitHub Personal Access Token with **`repo`** scope. Required for Compare with Git, Explore Repo Structure, and Batch Review.

[Create a GitHub PAT →](https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/managing-your-personal-access-tokens)

### 2. Manage GitHub Mappings

```
SqlLens: Manage GitHub Mappings
```

Map each SQL Server instance to a GitHub repository (`ServerName → owner/repo-name`).

---

## Environment Management

Organize servers by environment (Development, Staging, Production):

| Command | Description |
|---------|-------------|
| `SqlLens: Select Environment` | Switch active environment |
| `SqlLens: Create New Environment` | Add a new environment |

---

## Settings Reference

**File → Preferences → Settings** → search `SqlLens`:

| Setting | Default | Description |
|---------|---------|-------------|
| `sqllens.azureFunctions.baseUrl` | `https://sqllens-functions.azurewebsites.net` | Backend API URL |
| `sqllens.azureFunctions.functionKey` | *(empty)* | API key (from account registration) |
| `sqllens.connections` | `[]` | Saved SQL Server connections |

---

## Full Command Reference

| Command | Description |
|---------|-------------|
| `SqlLens: Login` | Sign in |
| `SqlLens: Register` | Create account |
| `SqlLens: Logout` | Sign out |
| `SqlLens: Show User Info` | Display account details |
| `SqlLens: Add Server` | Add SQL Server connection |
| `SqlLens: Remove Server` | Remove saved connection |
| `SqlLens: Update Server Password` | Update credentials |
| `SqlLens: Connect to SQL Server` | Select active connection |
| `SqlLens: Select Environment` | Switch environment |
| `SqlLens: Create New Environment` | Add environment |
| `SqlLens: Analyze Dependencies` | Analyze object from Explorer |
| `SqlLens: Analyze SQL Object Dependencies` | Analyze highlighted SQL in editor |
| `SqlLens: Search Across Databases` | Cross-database search |
| `SqlLens: Compare Database with Git` | Diff live DB vs Git |
| `SqlLens: Configure GitHub PAT` | Set GitHub token |
| `SqlLens: Manage GitHub Mappings` | Map servers to repos |
| `SqlLens: Configure Batch Review Notifications` | Schedule AI review |
| `SqlLens: Explore GitHub Repo Structure` | Browse mapped Git repo |
| `SqlLens: Check Key Vault Credentials` | Diagnostic: Key Vault access |
| `SqlLens: Test mssql Extension Integration` | Diagnostic: mssql connection |

---

## Suggested Keyboard Shortcuts

No default bindings assigned. Add via **File → Preferences → Keyboard Shortcuts** → search `SqlLens`:

```json
{ "key": "ctrl+shift+d", "command": "sqllens.analyzeDependencies" },
{ "key": "ctrl+shift+s", "command": "sqllens.searchDatabases" }
```

---

## Troubleshooting

**Cannot connect to SQL Server**
- Verify server name: `localhost`, `.\SQLEXPRESS`, or `SERVER\INSTANCE`
- Run `SqlLens: Update Server Password` if credentials changed

**"Not logged in" errors**
- Run `SqlLens: Login` — sessions expire periodically

**mssql right-click menu not showing**
- Confirm the [mssql extension](https://marketplace.visualstudio.com/items?itemName=ms-mssql.mssql) is installed
- Must right-click on a Table, View, Stored Procedure, or Function node (not a folder)

**Compare with Git returns no results**
- Set GitHub PAT (`SqlLens: Configure GitHub PAT`) with `repo` scope
- Add a server mapping (`SqlLens: Manage GitHub Mappings`)

---

## Related Resources

| Resource | Link |
|----------|------|
| 🖥️ Desktop Application | [Download](https://sqllens.blob.core.windows.net/downloads/download.html) |
| 📊 Desktop vs VS Code Feature Comparison | [Feature_Comparison.md](Feature_Comparison.md) |
| 🔍 Full Desktop Reference Guide | [SqlLens_Reference_Guide.md](SqlLens_Reference_Guide.md) |
| 🐛 Report Issues | [GitHub Issues](https://github.com/jcboyer/sqllens-docs/issues) |

---

*Part of the [SqlLens SQL Server Analysis & Visualization](https://marketplace.visualstudio.com/items?itemName=sqllens.sqllens-sql-server-tools) toolset by [Thoughts In Motion](https://sodaplusai.com)*

