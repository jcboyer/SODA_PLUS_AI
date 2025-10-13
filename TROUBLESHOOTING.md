# 🔧 Troubleshooting Guide - SODA+ AI

## Common Issues

### 1. Application Won't Start

**Solutions:**

1. **Check Antivirus**
   - Add `SODA_PLUS_MAIN.exe` to exceptions
   
2. **Unblock File**
   - Right-click `SODA_PLUS_MAIN.exe`
   - Select **Properties**
   - Check **Unblock**
   - Click **OK**

3. **Run as Administrator**
   - Right-click `SODA_PLUS_MAIN.exe`
   - Select **Run as administrator**

---

### 2. Cannot Connect to SQL Server

#### **Enable Remote Connections**

Run in SQL Server Management Studio (SSMS) as admin:

\\\sql
EXEC sp_configure 'remote access', 1;
RECONFIGURE;
\\\

#### **Configure SQL Server for TCP/IP**

1. Open **SQL Server Configuration Manager**
2. Expand **SQL Server Network Configuration**
3. Click **Protocols for [Instance]**
4. Right-click **TCP/IP** → **Enable**
5. Restart SQL Server service

---

### 3. Dependency Analysis Not Working

**Check Permissions:**

\\\sql
USE [YourDatabase];
GRANT VIEW DEFINITION TO [YourLoginName];
\\\

---

## Still Having Issues?

[🐛 Report Bug on GitHub](https://github.com/jcboyer/SODA_PLUS_AI/issues/new?template=bug_report.md)

---

<div align="center">

**Thank you for using SODA+ AI!**

</div>
