# 🔧 Troubleshooting Guide - SODA+ AI

## Common Issues

### 1. Application Won't Start

**Symptom:** Double-clicking `SODA_PLUS_MAIN.exe` does nothing

**Solutions:**

1. **Check Antivirus**
   - Temporarily disable antivirus
   - Add `SODA_PLUS_MAIN.exe` to exceptions
   
2. **Unblock File**
   - Right-click `SODA_PLUS_MAIN.exe`
   - Select **Properties**
   - Check **Unblock** at bottom
   - Click **OK**

3. **Run as Administrator**
   - Right-click `SODA_PLUS_MAIN.exe`
   - Select **Run as administrator**

4. **Check Windows Event Viewer**
   - Open Event Viewer
   - Windows Logs → Application
   - Look for recent errors

---

### 2. "Windows protected your PC"

**Symptom:** SmartScreen warning appears

**Solution:**
1. Click **More info**
2. Click **Run anyway**

**Why this happens:**
- New application without extensive download history
- Microsoft SmartScreen protection
- Normal for beta software

**To prevent warning:**
- Download always from official Azure Blob Storage link
- Verify file hash (see release notes)

---

### 3. Cannot Connect to SQL Server

**Symptom:** Connection fails or times out

#### **A. Check SQL Server is Running**

\\\powershell
# Check SQL Server service status
Get-Service -Name MSSQLSERVER  # Default instance
Get-Service -Name "MSSQL$INSTANCENAME"  # Named instance
\\\

#### **B. Enable Remote Connections**

Run in SQL Server Management Studio (SSMS) as admin:

\\\sql
-- Enable remote access
EXEC sp_configure 'remote access', 1;
RECONFIGURE;

-- Check current settings
EXEC sp_configure;
\\\

#### **C. Configure SQL Server for TCP/IP**

1. Open **SQL Server Configuration Manager**
2. Expand **SQL Server Network Configuration**
3. Click **Protocols for [Instance]**
4. Right-click **TCP/IP** → **Enable**
5. Restart SQL Server service

#### **D. Configure Windows Firewall**

\\\powershell
# Allow SQL Server through firewall
New-NetFirewallRule -DisplayName "SQL Server" -Direction Inbound -Protocol TCP -LocalPort 1433 -Action Allow

# Allow SQL Server Browser (for named instances)
New-NetFirewallRule -DisplayName "SQL Browser" -Direction Inbound -Protocol UDP -LocalPort 1434 -Action Allow
\\\

#### **E. Verify Credentials**

**Windows Authentication:**
- Ensure your Windows account has SQL Server access
- Check if SQL Server allows Windows Authentication

**SQL Server Authentication:**
- Verify username and password
- Ensure SQL Server Authentication is enabled:

\\\sql
-- Check authentication mode (run in SSMS)
SELECT SERVERPROPERTY('IsIntegratedSecurityOnly') AS AuthMode;
-- 0 = Mixed Mode (Windows + SQL)
-- 1 = Windows Only
\\\

To enable SQL Server Authentication:
1. Right-click SQL Server in SSMS
2. **Properties** → **Security**
3. Select **SQL Server and Windows Authentication mode**
4. Restart SQL Server service

---

### 4. API Key Issues

**Symptom:** "Invalid API key" or authentication errors

**Solutions:**

1. **Check Internet Connection**
   - Ensure stable internet connection
   - Test: `ping azure.microsoft.com`

2. **Re-login**
   - Logout from SODA+ AI
   - Login again with your email
   - Wait for API key assignment

3. **Clear Cache**
   - Close SODA+ AI
   - Delete: `%APPDATA%\SODA_PLUS_AI\cache`
   - Restart application

4. **Contact Support**
   - If issue persists, [open an issue](https://github.com/jcboyer/SODA_PLUS_AI/issues) with:
     - Your email address
     - Error message screenshot
     - Timestamp of error

---

### 5. Dependency Analysis Not Working

**Symptom:** No dependencies shown or analysis fails

**Solutions:**

1. **Check Permissions**
   - Your SQL login needs **VIEW DEFINITION** permission
   
\\\sql
-- Grant permission (run as admin)
USE [YourDatabase];
GRANT VIEW DEFINITION TO [YourLoginName];
\\\

2. **Refresh Object List**
   - Click **Refresh** button
   - Re-select database

3. **Check Object Type**
   - Not all objects have dependencies
   - Try analyzing stored procedures or views

---

### 6. Chart Window Not Opening

**Symptom:** Chart button does nothing or window is blank

**Solutions:**

1. **Select an Object First**
   - Ensure you've selected a database object
   - Click **Analyze Dependencies** first

2. **Check for Errors**
   - Look for error messages in status bar
   - Check Windows Event Viewer

3. **WebView2 Runtime**
   - Charts require Microsoft Edge WebView2
   - It's usually pre-installed on Windows 10/11
   - If missing, download from: [Microsoft Edge WebView2](https://developer.microsoft.com/microsoft-edge/webview2/)

---

### 7. AI Code Review Fails

**Symptom:** AI analysis fails, times out, or shows errors

**Solutions:**

1. **Check Internet Connection**
   - AI review requires internet access
   - Test: `ping api.openai.com`

2. **Object Has Code**
   - Only objects with SQL code can be reviewed
   - Tables don't have code to review

3. **Code Size**
   - Very large code may timeout
   - Try analyzing smaller procedures first

4. **API Limits**
   - Beta accounts have usage limits
   - Wait a few minutes and retry

---

### 8. Performance Issues

**Symptom:** Application is slow or unresponsive

**Solutions:**

1. **Large Databases**
   - Use schema filters to narrow results
   - Analyze specific object types only
   - Break analysis into smaller batches

2. **Memory Usage**
   - Close other applications
   - Recommended: 8GB RAM for large databases
   - Check Task Manager for memory usage

3. **SQL Server Load**
   - Check SQL Server CPU/memory usage
   - Avoid analyzing during peak hours
   - Consider indexing system tables

---

### 9. Mermaid Charts Not Rendering

**Symptom:** Chart window opens but diagram doesn't display

**Solutions:**

1. **Check Internet Connection**
   - Mermaid renderer requires internet for CDN
   
2. **Firewall/Proxy**
   - Ensure CDN access is not blocked
   - Check corporate firewall rules

3. **Export as Text**
   - Use **Export** button to save diagram code
   - View in online Mermaid editor: [Mermaid Live Editor](https://mermaid.live)

---

## Error Messages

### "Access Denied"

**Cause:** Insufficient SQL Server permissions

**Solution:**
\\\sql
-- Grant required permissions (run as admin)
USE [YourDatabase];
GRANT VIEW DEFINITION TO [YourLoginName];
GRANT SELECT ON SCHEMA::dbo TO [YourLoginName];
\\\

### "Object Not Found"

**Cause:** Object was deleted, renamed, or you don't have permission

**Solution:**
- Refresh object list
- Verify object exists in SSMS
- Check permissions

### "Connection Timeout"

**Cause:** Network issues or slow SQL Server response

**Solutions:**
- Increase connection timeout in settings
- Check network connectivity
- Verify SQL Server isn't overloaded

### "Login Failed for User"

**Cause:** Invalid credentials or authentication mode

**Solutions:**
- Verify username/password
- Check SQL Server authentication mode
- Ensure SQL login exists and is enabled

---

## Logs and Diagnostics

### Application Logs

Located in: `%APPDATA%\SODA_PLUS_AI\Logs\`

Files:
- `application.log` - General application logs
- `errors.log` - Error details
- `api.log` - API communication logs

### Collect Diagnostic Info

When reporting issues, include:

1. **Windows Version**
   \\\powershell
   winver  # Run this command
   \\\

2. **SQL Server Version**
   \\\sql
   SELECT @@VERSION;
   \\\

3. **Application Version**
   - Help → About in SODA+ AI

4. **Error Logs**
   - Copy from `%APPDATA%\SODA_PLUS_AI\Logs\`

5. **Screenshots**
   - Capture error messages
   - Include full window context

---

## Still Having Issues?

### Before Opening an Issue

1. ✅ Check this troubleshooting guide
2. ✅ Review [Installation Guide](INSTALLATION.md)
3. ✅ Search [existing issues](https://github.com/jcboyer/SODA_PLUS_AI/issues)
4. ✅ Check [discussions](https://github.com/jcboyer/SODA_PLUS_AI/discussions)

### Open a New Issue

[🐛 Report Bug on GitHub](https://github.com/jcboyer/SODA_PLUS_AI/issues/new?template=bug_report.md)

**Include:**
- Windows version (`winver`)
- SQL Server version
- SODA+ AI version
- Error message (exact text)
- Steps to reproduce
- Screenshots (if applicable)
- Log files (from `%APPDATA%\SODA_PLUS_AI\Logs\`)

---

## Community Support

- 💬 [GitHub Discussions](https://github.com/jcboyer/SODA_PLUS_AI/discussions) - Ask questions
- 🐛 [GitHub Issues](https://github.com/jcboyer/SODA_PLUS_AI/issues) - Report bugs
- 📖 [User Guide](SODA_PLUS_User_Guide.md) - Full documentation

---

<div align="center">

**Thank you for using SODA+ AI!**

Your feedback helps make the application better for everyone.

</div>
