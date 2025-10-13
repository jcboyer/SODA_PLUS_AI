# 📥 Installation Guide - SODA+ AI

## Quick Installation

### Step 1: Download
[⬇️ Download SODA+ AI v1.0.0-beta](https://sodaplusbeta.blob.core.windows.net/downloads/download_1.0.0-beta.html)

### Step 2: Extract
Right-click the downloaded ZIP file and select **Extract All...**

### Step 3: Run
Double-click `SODA_PLUS_MAIN.exe` - No installation required!

---

## System Requirements

| Requirement | Specification |
|-------------|---------------|
| **Operating System** | Windows 10 or Windows 11 (64-bit) |
| **RAM** | 4GB minimum (8GB recommended) |
| **Disk Space** | 500MB free space |
| **Internet Connection** | Required for AI features |
| **.NET Runtime** | Included (self-contained) |

---

## First Launch

### 1. Run the Application
Double-click `SODA_PLUS_MAIN.exe`

### 2. Windows Security Warning
If you see "Windows protected your PC":
- Click **More info**
- Click **Run anyway**

This is normal for new applications.

### 3. Login
- Enter your **email address**
- Your API key will be assigned automatically
- Internet connection required for first login

### 4. Connect to SQL Server

**Choose Authentication:**
- **Windows Authentication** (recommended if on domain)
- **SQL Server Authentication** (username/password)

**Enter Server Details:**
- Server name (e.g., `localhost` or `SERVER\INSTANCE`)
- Database name (or browse available databases)

---

## Folder Structure

After extraction, you'll have:

\\\
SODA_PLUS_AI_1.0.0-beta/
├── SODA_PLUS_MAIN.exe          # Main application (single file)
├── README.md                    # Quick start guide
├── RELEASE_NOTES.md            # Version history
└── SODA_PLUS_User_Guide.md     # Complete documentation
\\\

---

## Troubleshooting

### "Windows protected your PC" Warning

**Cause:** SmartScreen filter for new applications

**Solution:**
1. Click **More info**
2. Click **Run anyway**

### Antivirus Blocking

**Cause:** Some antivirus software blocks unknown executables

**Solution:**
- Add `SODA_PLUS_MAIN.exe` to antivirus exceptions
- Or temporarily disable antivirus during first run

### Cannot Connect to SQL Server

**Verify:**
- ✅ SQL Server is running
- ✅ SQL Server Browser service is running (for named instances)
- ✅ Remote connections are enabled
- ✅ Firewall allows SQL Server (port 1433)
- ✅ Credentials are correct

**Check SQL Server Configuration:**
\\\sql
-- Enable remote connections (run in SSMS as admin)
EXEC sp_configure 'remote access', 1;
RECONFIGURE;
\\\

### Application Crashes on Startup

**Solution:**
- Check Windows Event Viewer for error details
- Ensure you extracted ALL files from ZIP
- Try running as Administrator
- Report issue on GitHub with error details

---

## Uninstallation

Simply delete the extracted folder - no registry entries or system files are created.

---

## Upgrading

1. Download new version
2. Extract to a new folder (or replace old files)
3. Your settings are stored in:
   - `%APPDATA%\SODA_PLUS_AI\`
   - Login credentials are preserved

---

## Network Requirements

### Outbound Connections Required:
- **Azure Blob Storage** - Download updates
- **Azure Functions** - API key management
- **OpenAI API** - AI-powered code review

### SQL Server Connections:
- Default port: **1433** (TCP)
- Named instances use dynamic ports

---

## Need Help?

- 📖 [User Guide](SODA_PLUS_User_Guide.md)
- 🔧 [Troubleshooting Guide](TROUBLESHOOTING.md)
- 🐛 [Report Issues](https://github.com/jcboyer/SODA_PLUS_AI/issues)
- 💬 [Discussions](https://github.com/jcboyer/SODA_PLUS_AI/discussions)

---

## Security Notes

- ✅ Application is **self-contained** - no system-wide .NET installation modified
- ✅ SQL queries run **locally** on your server
- ✅ No database data is sent to cloud (only code definitions for AI review)
- ✅ API keys stored securely in Azure

---

<div align="center">

**Ready to analyze your SQL Server dependencies?**

[⬇️ Download Now](https://sodaplusbeta.blob.core.windows.net/downloads/download_1.0.0-beta.html)

</div>
