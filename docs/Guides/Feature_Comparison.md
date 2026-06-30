# SqlLens — Desktop vs VS Code Extension Feature Comparison

> Last updated: 2026-06-29 · Desktop v1.9.0+ · VS Code Extension v0.0.5

This document tracks which features exist in each client and highlights gaps that are candidates for future VS Code extension development.

---

## Feature Matrix

| Feature | 🖥️ Desktop | 🧩 VS Code | Notes |
|---------|:----------:|:----------:|-------|
| **Authentication** | | | |
| Login / Register / Logout | ✅ | ✅ | |
| Auto-login (session persistence) | ✅ | ✅ | |
| **SQL Server Connectivity** | | | |
| Connect to SQL Server | ✅ | ✅ | |
| Server Explorer (browse objects) | ✅ | ✅ via mssql | |
| Multi-server / environment management | ✅ | ✅ | |
| Right-click from mssql extension | ❌ | ✅ | VS Code only |
| **Dependency Analysis** | | | |
| Analyze object dependencies | ✅ Full UI | ✅ Basic | |
| Multi-tab drill-down chains | ✅ | ❌ | Gap |
| Upstream / Downstream toggle | ✅ | ❌ | Gap |
| Impact analysis (what calls this?) | ✅ | ❌ | Gap |
| Cross-database dependency search | ✅ | ✅ basic | |
| **AI Code Review** | | | |
| AI code review (Grok-4) | ✅ | ❌ | **Major gap** |
| AI-powered relevance filtering | ✅ | ❌ | Gap |
| Batch review notifications | ❌ | ✅ | VS Code only |
| AI SQL selection analysis | ❌ | ✅ | VS Code only |
| **Visualization** | | | |
| Mermaid dependency diagram | ✅ | ❌ | **Major gap** |
| SVG export | ✅ | ❌ | Gap |
| Logic flowcharts | ✅ | ❌ | Gap |
| Save/load chart files | ✅ | ❌ | Gap |
| Quick charting window | ✅ | ❌ | Gap |
| **Database Compare** | | | |
| Compare two databases | ✅ | ❌ | **Major gap** |
| Compare with Git | ✅ | ✅ | |
| **SQL Server Agent Jobs** | | | |
| Agent Job dependency graph | ✅ | ❌ | **Major gap** |
| Git drift detection for Agent Jobs | ✅ | ❌ | Gap |
| Agent Job script list (Active/Archive) | ✅ | ❌ | Gap |
| Repo changes report + CSV export | ✅ | ❌ | Gap |
| **Git Integration** | | | |
| GitHub PAT configuration | ✅ | ✅ | |
| Git repo mapping per server | ✅ | ✅ | |
| GitHub repo structure explorer | ❌ | ✅ | VS Code only |
| **Export & Reporting** | | | |
| Export dependencies (CSV/JSON/MD) | ✅ | ❌ | Gap |
| Export Mermaid/SVG charts | ✅ | ❌ | Gap |
| CSV export for Agent repo changes | ✅ | ❌ | Gap |
| **Cloud & Security** | | | |
| Azure Key Vault API key management | ✅ | ✅ | |
| Encrypted sessions (DPAPI) | ✅ | ❌ | |
| **SSMS Integration** | | | |
| SSMS extension (SqlLens.Ssms) | ✅ | ❌ | Separate product |

---

## Gap Priority (Candidates for VS Code Extension)

### 🔴 High Priority (High value, many users affected)
1. **AI Code Review** — the flagship feature; inline SQL review inside VS Code editor would be powerful
2. **Dependency drill-down** — multi-hop upstream/downstream chains in a panel
3. **Mermaid diagram** — render dependency graph in a WebView panel

### 🟠 Medium Priority
4. **SQL Server Agent Job viewer** — Agent job tree + drift status in VS Code Explorer
5. **Database Compare** — side-by-side diff of two schemas
6. **Export (CSV/Markdown)** — export dependency results from VS Code

### 🟡 Lower Priority (Desktop-specific UX)
7. SVG export (less critical in editor context)
8. Logic flowcharts
9. Quick charting window

---

## VS Code Extension — Current Commands (v0.0.5)

| Command | Description |
|---------|-------------|
| `SqlLens: Login` | Authenticate |
| `SqlLens: Register` | Create account |
| `SqlLens: Logout` | Sign out |
| `SqlLens: Connect to SQL Server` | Add/select connection |
| `SqlLens: Analyze Dependencies` | Analyze selected object |
| `SqlLens: Analyze Dependencies (from mssql Explorer)` | Right-click in mssql tree |
| `SqlLens: Analyze SQL Selection` | Analyze highlighted SQL |
| `SqlLens: Search Across Databases` | Cross-database search |
| `SqlLens: Compare with Git` | Git diff for selected object |
| `SqlLens: Manage Servers` | Add/edit server connections |
| `SqlLens: Manage Environments` | Environment configuration |
| `SqlLens: Configure GitHub PAT` | Set GitHub personal access token |
| `SqlLens: View Batch Review Notifications` | Show pending AI review results |
| `SqlLens: Explore GitHub Repo Structure` | Browse mapped Git repo |
| `SqlLens: Open Help` | Open VS Code guide in browser |

---

*Maintained in [sqllens-docs](https://github.com/jcboyer/sqllens-docs) · Part of the [Thoughts In Motion](https://sodaplusai.com) platform*