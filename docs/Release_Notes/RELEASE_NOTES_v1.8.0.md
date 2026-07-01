# SqlLens - Release Notes v1.8.0

**Release Date:** July 1, 2026  
**Type:** Major Feature Release  
**Scope:** Cumulative update since v1.6.0 (2025-12-31 baseline)  
**Download:** [https://sqllens.blob.core.windows.net/downloads/download.html](https://sqllens.blob.core.windows.net/downloads/download.html)

---

## 🎯 Release Summary

Version 1.8.0 captures six months of major product evolution after v1.6.0, including:

- A major **Compare subsystem restructuring** (standalone compare executable + shared compare library)
- New **Compare Table Data** workflow in the Compare menu
- **Quick Publish active-tab deployment** between environments
- Expanded **Git integration** and drift workflows
- New **SQL Agent Job** dependency and script lifecycle tooling
- Documentation modernization, including a dedicated **Git Integration Guide**

---

## 🚀 Major Additions

### 1) Compare Platform Restructure (April 2026)

The compare stack was split and re-architected for stability, deployment isolation, and future extensibility.

- Introduced `SqlLens_COMPARE_LIB` (shared comparison services/UI layer)
- Introduced standalone `SqlLens_COMPARE` WPF executable
- Wired `SqlLens.Desktop` → `SqlLens_COMPARE.exe` launch via named pipe
- Updated packaging/publish pipeline to include compare components
- Shifted compare deployment to self-contained publish model

**Impact:** comparison workflows are now more modular and resilient, with clearer ownership boundaries between MAIN and compare runtime.

---

### 2) Compare Menu Expansion: Compare Table Data

Added **Compare Table Data...** under the Compare menu for row-level data comparison workflows.

- Complements schema/object comparison with data-level inspection
- Supports exact row/column difference analysis scenarios
- Provides cleaner separation between object compare and data compare use cases

---

### 3) Quick Publish from Active Tab

Added **Quick Publish** workflow for targeted deployment from the active analyzer tab.

- Single-object deployment to target database from current analysis context
- Improved environment-to-environment workflow speed
- Added same-name database auto-selection for common TEST → PROD patterns

---

### 4) Git Integration Growth

Git features expanded significantly and moved from basic mapping toward operational workflows.

- Git status enrichment enhancements in comparison flows
- Mapping manager improvements and gating/validation hardening
- Reduced fallback ambiguity in path resolution behavior
- Better compare-to-Git workflow reliability and diagnostics

---

### 5) SQL Agent Job Workflow Suite

Added full SQL Agent-focused exploration and script management features.

- SQL Agent Job dependency graph support
- Step script viewer in modeless side-panel style
- Git-backed Agent script storage and snapshot workflows
- Active/Archive repository folder handling in UI
- Repo changes reporting window with CSV export
- Per-server repository target resolution improvements
- `msdb` mapping support and system-database mapping handling

---

## ✅ Key Improvements & Fixes

### Compare / Deployment Quality

- Semantic SQL normalization improvements to reduce cosmetic false diffs
- Diff normalization fixes (including line-ending consistency)
- Deploy script generation hardening and ordering refinements
- Various compare/deploy reliability fixes across object types and dependency ordering

### Git + Agent Reliability

- Base64-at-rest compatibility restored for Agent job/script SQL file storage
- Run/refresh behavior stabilized in Repo Changes UI
- Parallelized commit-detail retrieval for Repo Changes performance
- Bootstrap/readme content behavior corrected for Agent repo folders

### Packaging / Runtime

- Compare artifacts integrated into deployment pipeline
- Runtime process handling improvements around compare subprocesses
- Multiple publish-time corrections to ensure compare feature availability in shipped builds

---

## 📚 Documentation Updates

Documentation was expanded to reflect the broader platform surface:

- New **Git Integration Guide**
- Search Guide updated with Agent-search workflow coverage
- Public documentation sync script aligned with current guide set
- Release/public doc generation updated to include Search, Project Management, and Git guides

---

## 🔄 Behavioral Notes

- Compare now relies on the split compare architecture (`MAIN` + compare components)
- Agent search and Agent dependency flows now route users into Agent-specific tooling
- Git-backed Agent workflows include explicit Active/Archive semantics and repo reporting

---

## 📦 Included Functional Themes (Since v1.6.0)

1. Compare architecture split and stabilization  
2. Data comparison workflow in Compare menu  
3. Quick Publish active-tab deployment path  
4. Git mapping and drift workflow hardening  
5. SQL Agent Job graph + step script + Git lifecycle tooling  
6. Documentation and public sync modernization

---

## 🙏 Thank You

Thank you to all beta users and contributors who provided detailed workflow feedback across comparison, deployment, Git integration, and Agent job management scenarios.

---

## Notes for Finalization

Before final publication, update:

- `Release Date` above
- Any final links to versioned artifacts if you choose to publish version-specific assets for v1.8.0

