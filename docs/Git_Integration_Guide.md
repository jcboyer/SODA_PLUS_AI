# 🔗 SqlLens - Git Integration Guide
## Source Control, Drift Detection, and Agent Job Script Workflows

---

**Version:** 1.6.0 | **Last Updated:** June 2026  
**Target Audience:** DB Developers, DBAs, Release/DevOps Teams

---

[TOC]

---

## Why Git Integration Matters

SqlLens Git integration is designed to make your database workflow auditable and repeatable:

- Keep SQL objects in a repository as a source-of-truth reference
- Compare deployed SQL with Git versions to detect drift
- Track SQL Agent Job scripts and snapshots in Active/Archive folders
- Review recent Agent repository changes and export them to CSV

If your team treats Git as the contract and databases as runtime state, these features close the loop.

---

## What This Guide Covers

1. Connecting SqlLens to GitHub
2. Repository and mapping concepts
3. Database ↔ Git comparison and drift
4. SQL Agent Job script lifecycle (Active/Archive)
5. Repo Changes report and CSV export
6. Troubleshooting and operational guidance

---

## Prerequisites

Before using Git features:

- A GitHub PAT with repo read/write scope
- Access to the target organization/repositories
- A selected environment, server, and database in SqlLens
- Team conventions for repository naming and branch usage

---

## 1) Connect GitHub in SqlLens

From the **GitHub** menu:

1. Select **Connect GitHub...**
2. Enter your PAT
3. Validate connection

When connected, Git features become available (compare, mappings, Agent Job scripts).

---

## 2) Understand Repository Targeting

Git targeting for Agent workflows follows a clear precedence:

1. Explicit mapping (server/database → owner/repo)
2. Repository scan match
3. Credential/default fallback

For system databases (for example `msdb`), mapping behavior is intentionally more permissive so agent-specific workflows can still be configured.

---

## 3) Manage Server/Database Mappings

Use mapping management to bind a database context to the correct repository target:

1. Open the GitHub mapping manager from the GitHub menu
2. Select server + database
3. Assign owner/repo and branch strategy
4. Save and test mapping

### Notes

- `msdb` is supported in mapping workflows for Agent scenarios
- Mapping for system DB workflows does not require full folder-rule setup
- Test mapping validates that the target branch/repository is reachable

---

## 4) Compare Database with GitHub (Drift)

Use **GitHub → Compare Database with GitHub...** to detect differences between deployed database SQL and repository SQL.

Typical outputs:

- In sync
- Database ahead of Git
- Git ahead of database
- Not found in Git

Use this view before releases or incident response to quickly identify divergence.

---

## 5) SQL Agent Job Scripts Workflow

Open **GitHub → Agent Job Scripts...** for SQL Agent script management.

Core actions:

- Save current step script to Git
- Save full job snapshot
- Move between **Active** and **Archive**
- View step or snapshot content
- Copy/export related metadata

### Active vs Archive semantics

- **Active** = current, expected operational scripts
- **Archive** = historical/retired scripts

Moving to Archive is a relocation workflow (not a duplicate copy).

---

## 6) Repo Changes Report (Agent Repositories)

From Agent Job Scripts, use **Repo Changes** to list recent commit-level changes under:

- `AgentJobs/...`
- `AgentScripts/...`

You can:

- Run/refresh the query
- Review commit, author, path, change type, message
- Export results to CSV for release notes, audit, or handoff

---

## 7) Recommended Operating Pattern

For each release cycle:

1. Validate mappings for target servers/databases
2. Review drift (database vs Git)
3. Save/update Agent scripts and snapshots
4. Archive superseded Agent scripts where appropriate
5. Export Repo Changes CSV and attach to release evidence

This keeps deployment evidence and runtime configuration aligned.

---

## 8) Troubleshooting

### Git menu items disabled

- Ensure GitHub PAT connection is valid for the current session
- Confirm repository access rights
- Confirm server/database context is selected

### Mapping test fails

- Check owner/repo spelling
- Verify branch exists and is reachable
- Confirm PAT has access to the target organization/repo

### Repo Changes appears slow

- It scans recent commit history and commit file lists
- Large/high-churn repositories take longer
- Re-run with stable network connectivity

### Unexpected script content format

- Agent script storage is expected to remain compatible with existing base64-at-rest behavior used by this workflow
- UI reads should still render plain SQL content to the user

---

## Related Guides

- [Quick Start](SqlLens_QuickStart.md)
- [User Guide](SqlLens_User_Guide.md)
- [Reference Guide](SqlLens_Reference.md)
- [Cross-Database Search Guide](SqlLens_Search_Guide.md)
- [Project Management Guide](SqlLens_ProjectManagement_Guide.md)

