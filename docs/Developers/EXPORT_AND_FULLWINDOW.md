# Export & Full Window Features

## Overview
Added two powerful features to the Dependency Analyzer:
1. **📤 Export** - Export dependency data to multiple formats
2. **📺 Full Window** - Open analyzer in standalone maximized window

---

## 🎯 **1. Export Feature**

### **What It Does**
Exports complete dependency analysis data to various file formats for:
- Documentation
- Sharing with team members
- Integration with other tools
- Archival and reporting

### **Supported Formats**

#### **1. JSON (.json)** - Machine-readable structured data
```json
{
  "object": {
    "name": "dbo.GetCustomerOrders",
    "type": "Procedure",
    "server": "SERVER01",
    "database": "SalesDB",
    "environment": "PROD"
  },
  "analysis": {
    "date": "2025-01-15T14:30:00Z",
    "maxDepth": 3
  },
  "dependencies": {
    "upstream": [...],
    "downstream": [...],
    "callOrder": [...]
  },
  "summary": {
    "totalUpstream": 5,
    "totalDownstream": 12,
    "totalOrdered": 17
  }
}
```

**Best for:**
- API integrations
- Automated processing
- Version control tracking
- Importing into other tools

#### **2. CSV (.csv)** - Spreadsheet-friendly tabular data
```csv
# Dependency Analysis: dbo.GetCustomerOrders
# Date: 2025-01-15 14:30:00
# Server: SERVER01
# Database: SalesDB

Upstream Dependencies (Used By)
Type,Schema,Name,FullName,Level
Procedure,dbo,ProcessOrders,dbo.ProcessOrders,1
Function,dbo,ValidateOrder,dbo.ValidateOrder,1

Downstream Dependencies (Uses)
Type,Schema,Name,FullName,Level
Table,dbo,Customers,dbo.Customers,1
Table,dbo,Orders,dbo.Orders,1
View,dbo,vw_OrderSummary,dbo.vw_OrderSummary,1
```

**Best for:**
- Excel analysis
- Pivot tables
- Bulk import to databases
- Quick data inspection

#### **3. Markdown (.md)** - Documentation-friendly formatted text
```markdown
# Dependency Analysis: dbo.GetCustomerOrders

**Date:** 2025-01-15 14:30:00  
**Server:** SERVER01  
**Database:** SalesDB  
**Environment:** PROD  
**Analysis Depth:** 3  

## Summary

- **Upstream Dependencies (Used By):** 5
- **Downstream Dependencies (Uses):** 12
- **Call Order Items:** 17

## Upstream Dependencies (Used By)

- 📋 **dbo.ProcessOrders** _Procedure_
- 🔧 **dbo.ValidateOrder** _Function_

## Downstream Dependencies (Uses)

- 📊 **dbo.Customers** _Table_
- 📊 **dbo.Orders** _Table_
- 👁️ **dbo.vw_OrderSummary** _View_

## Execution Call Order

1. `dbo.Customers` (Table)
2. `dbo.Orders` (Table)
3. `dbo.vw_OrderSummary` (View)
...
```

**Best for:**
- README files
- Wiki documentation
- GitHub/GitLab docs
- Team knowledge base

#### **4. Plain Text (.txt)** - Simple readable format
```
═══════════════════════════════════════════════════════════
 Dependency Analysis: dbo.GetCustomerOrders
═══════════════════════════════════════════════════════════

Date:        2025-01-15 14:30:00
Server:      SERVER01
Database:    SalesDB
Environment: PROD
Max Depth:   3

─────────────────────────────────────────────────────────
Summary
─────────────────────────────────────────────────────────
  Upstream Dependencies (Used By):  5
  Downstream Dependencies (Uses):   12
  Call Order Items:                 17

─────────────────────────────────────────────────────────
Upstream Dependencies (Used By)
─────────────────────────────────────────────────────────
▪ dbo.ProcessOrders (Procedure)
▪ dbo.ValidateOrder (Function)

─────────────────────────────────────────────────────────
Downstream Dependencies (Uses)
─────────────────────────────────────────────────────────
▪ dbo.Customers (Table)
▪ dbo.Orders (Table)
▪ dbo.vw_OrderSummary (View)
```

**Best for:**
- Email attachments
- Log files
- Console output
- Legacy system compatibility

### **How to Use**

#### **From Toolbar:**
1. Click the **📤 Export** button in the analyzer toolbar
2. Choose save location and file format from the dialog
3. Click **Save**
4. Optional: Click **Yes** to open the exported file immediately

#### **File Naming:**
- Auto-generated: `{ObjectName}_dependencies.{extension}`
- Example: `GetCustomerOrders_dependencies.json`
- Automatically removes invalid filename characters

### **What Gets Exported**

✅ **Object metadata:**
- Name, Type, Schema
- Server, Database, Environment

✅ **Analysis settings:**
- Date/time of analysis
- Maximum depth used

✅ **Dependency data:**
- Complete upstream dependency tree (what uses this)
- Complete downstream dependency tree (what this uses)
- Execution call order (if generated)

✅ **Summary statistics:**
- Total upstream dependencies
- Total downstream dependencies
- Call order item count

✅ **Advanced properties:**
- Linked server indicators
- Cross-database flags
- Error markers
- Hierarchical relationships

### **Use Cases**

#### **1. Documentation**
Export to Markdown and commit to Git:
```bash
# Export procedure dependencies
Export → Markdown → SaveAs: docs/dependencies/GetCustomerOrders.md
git add docs/dependencies/GetCustomerOrders.md
git commit -m "Add dependency documentation for GetCustomerOrders"
```

#### **2. Change Impact Analysis**
Export to CSV and analyze in Excel:
- Filter by Type to find all affected procedures
- Pivot by Level to understand impact depth
- Highlight cross-database dependencies

#### **3. Automated Testing**
Export to JSON for CI/CD pipelines:
```json
{
  "dependencies": {
    "downstream": [
      {"name": "dbo.Orders", "type": "Table"}
    ]
  }
}
```
Use in test scripts to ensure test data coverage.

#### **4. Architecture Review**
Export to Text for presentations:
- Print and annotate during design meetings
- Include in architecture decision records (ADRs)
- Share via email without requiring special tools

---

## 📺 **2. Full Window Feature**

### **What It Does**
Opens the current dependency analysis in a **dedicated standalone window** with:
- ✅ Full screen real estate (1400x900 default)
- ✅ Independent window positioning
- ✅ Maximizable for detailed analysis
- ✅ Side-by-side comparison with other analyses
- ✅ Persistent window state across sessions

### **How to Use**

#### **From Toolbar:**
1. Click the **📺 Full Window** button in the analyzer toolbar
2. New window opens with the current analysis
3. Resize, move, or maximize as needed

#### **From Context Menu:**
_(Not yet implemented in context menu)_

### **Window Features**

#### **Independent Analysis:**
- Full analyzer functionality in standalone window
- All toolbar buttons available (Refresh, AI Analysis, Chart, Export)
- Complete dependency trees and code viewer
- Search functionality works normally

#### **Smart Event Handling:**
- ✅ **AI Review** - Opens AI window like normal
- ✅ **Chart** - Opens chart window
- ✅ **Analyze in New Tab** - Opens in MAIN window's tab control (not in full window)
- ❌ **Full Window** button removed (already in full window!)

#### **Window State Persistence:**
- Position saved when closed
- Size saved when closed
- Next "Full Window" opens at same position/size
- Uses Windows DPAPI encryption
- Storage: `%APPDATA%\SODA_PLUS\DependencyAnalyzerFullWindow.dat`

### **Use Cases**

#### **1. Dual Monitor Setup**
```
Monitor 1: Main SODA+ window (Object Explorer + Tabs)
Monitor 2: Full Window analyzer (Detailed dependency analysis)
```

**Workflow:**
1. Browse objects in Main window
2. Open complex procedure in Full Window (Monitor 2)
3. Deep dive into dependencies without losing object explorer
4. Compare with another object in a Main window tab

#### **2. Presentation Mode**
```
During team meeting:
1. Project Main window (Object Explorer visible)
2. Open Full Window on external projector
3. Maximize for audience visibility
4. Navigate dependencies while maintaining context
```

#### **3. Complex Analysis**
```
Analyzing stored procedure with 50+ dependencies:
1. Open in Full Window
2. Maximize to full screen
3. Expand all dependency trees
4. Use search to find specific dependencies
5. Export when done
```

#### **4. Multi-Object Comparison**
```
Comparing two similar procedures:
1. Open Procedure A in Main window tab
2. Open Procedure B in Full Window
3. Side-by-side visual comparison
4. Toggle between downstream/upstream tabs
```

### **Technical Details**

#### **Window Configuration:**
- **Default Size:** 1400x900 pixels
- **Startup Position:** Center of main window
- **Owner:** Main SODA+ window (always on top of parent)
- **Icon:** Inherits from main window

#### **Event Wiring:**
All analyzer events work normally:
- `AIReviewRequested` → Opens AI Review window
- `ChartRequested` → Opens Chart window
- `AnalyzeRequested` → Opens new tab in MAIN window
- `StatusChanged` → Shows in Messages panel

**Note:** `FullWindowRequested` is NOT wired in Full Window mode (prevents infinite recursion).

#### **Memory Management:**
- Window creates new `DependencyAnalyzerControl` instance
- Independent ViewModel for data
- GC collects when window closes
- No memory leaks

---

## 🎯 **Implementation Files**

### **Export Feature:**
- `DependencyAnalyzerControl.Export.cs` - New partial class (255 lines)
  - `ExportDependencyData()` - Main export method
  - `ExportToJson()` - JSON serialization
  - `ExportToCsv()` - CSV generation with proper escaping
  - `ExportToMarkdown()` - Markdown formatting with icons
  - `ExportToText()` - Plain text with ASCII art
  - Helper methods for formatting and safety

### **Full Window Feature:**
- `MainShell.TabManagement.cs` - Updated
  - `OnFullWindowRequested()` - Handler (new, ~40 lines)
  - Creates standalone window
  - Wires up events properly
  - Initializes analyzer control

### **Modified Files:**
- `DependencyAnalyzerControl.xaml.cs` - Updated
  - `ExportButton_Click()` - Now calls `ExportDependencyData()`

---

## 🧪 **Testing Checklist**

### **Export Feature:**
- [ ] Export to JSON works
- [ ] Export to CSV works (including special characters)
- [ ] Export to Markdown works
- [ ] Export to Text works
- [ ] File opens after save (when "Yes" clicked)
- [ ] Safe filename generation (removes invalid chars)
- [ ] Empty dependencies handled gracefully
- [ ] Large datasets export without errors

### **Full Window Feature:**
- [ ] Full Window button opens new window
- [ ] Window size/position correct (1400x900, centered)
- [ ] All toolbar buttons work in Full Window
- [ ] AI Review opens from Full Window
- [ ] Chart opens from Full Window
- [ ] Analyze in New Tab opens in MAIN window
- [ ] Window state persists across sessions
- [ ] Multiple Full Windows can open simultaneously
- [ ] Closing Full Window doesn't affect Main window

---

## 🚀 **Future Enhancements**

### **Export:**
- [ ] Excel (.xlsx) format with formatting
- [ ] PDF export with charts
- [ ] HTML export with interactive tree
- [ ] Custom export templates
- [ ] Batch export (multiple objects at once)
- [ ] Export to database table
- [ ] Email export directly from app

### **Full Window:**
- [ ] "Detach Tab" context menu option
- [ ] "Open in Full Window" from Object Explorer context menu
- [ ] Multiple Full Window support with tab bar
- [ ] Snap Full Window to edges (Windows 11 style)
- [ ] "Pin Full Window" to keep on top
- [ ] Dark mode toggle
- [ ] Custom window themes

---

## 📝 **User Feedback Requested**

### **Export:**
1. Which export format do you use most?
2. Are there any missing formats you need?
3. Should exports include SQL code by default?
4. Would you like auto-export on every analysis?

### **Full Window:**
1. Should Full Window maximize by default?
2. Should Full Window have a minimal toolbar?
3. Would you like a "Compare Mode" with 2 analyzers side-by-side?
4. Should Full Window have its own AI Review history?

---

**Implementation Date:** January 15, 2025  
**Status:** ✅ Complete - Ready for Testing  
**Build:** Successful  

