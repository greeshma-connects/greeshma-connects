# ============================================================
# PowerShell Practice — Day 4
# Name    : Siha S
# Date    : 19 March 2026
# Purpose : TSE Bootcamp — 10 Essential PowerShell Commands
# ============================================================

# ─────────────────────────────────────────
# COMMAND 1 — Get-Process
# Purpose : Show all running processes
# ─────────────────────────────────────────
Get-Process

# ─────────────────────────────────────────
# COMMAND 2 — Sort-Object + Select-Object
# Purpose : Sort processes by CPU or RAM, show top 10
# ─────────────────────────────────────────

# Top 10 by CPU usage (highest first)
Get-Process | Sort-Object CPU -Descending | Select-Object -First 10

# Top 10 by RAM usage (highest first)
Get-Process | Sort-Object WorkingSet -Descending | Select-Object -First 10

# ─────────────────────────────────────────
# COMMAND 3 — Get-Process -Name
# Purpose : Check one specific process
# ─────────────────────────────────────────
Get-Process -Name chrome
Get-Process -Name explorer
Get-Process -Name notepad

# Search for process when name is not known fully
Get-Process | Where-Object {$_.ProcessName -like "*whats*"}

# ─────────────────────────────────────────
# COMMAND 4 — Stop-Process
# Purpose : Force close a process
# WARNING : Never stop System, lsass, csrss, winlogon
# ─────────────────────────────────────────

# Kill by ID (safer — kills only one specific process)
# Step 1: find the Id first
Get-Process -Name notepad
# Step 2: use that Id to kill it
Stop-Process -Id 1432

# Kill by Name (kills ALL instances of that process)
Stop-Process -Name notepad -Force

# Real example used today:
# Killed WhatsApp.Root to fix WhatsApp not opening
Stop-Process -Name WhatsApp.Root -Force

# ─────────────────────────────────────────
# COMMAND 5 — Get-CimInstance
# Purpose : Check total RAM and free RAM
# Note    : Values come in KB — divide by 1,000,000 for GB
# ─────────────────────────────────────────
Get-CimInstance Win32_OperatingSystem | Select-Object FreePhysicalMemory, TotalVisibleMemorySize

# Real result on SUMMER PC today:
# FreePhysicalMemory = 875036 KB  = ~0.8 GB free
# TotalVisibleMemory = 4043084 KB = ~4 GB total
# Conclusion: 78% RAM was in use — PC running slow

# ─────────────────────────────────────────
# COMMAND 6 — Get-EventLog
# Purpose : Read Windows error logs
# ─────────────────────────────────────────

# Show 10 most recent System errors
Get-EventLog -LogName System -Newest 10 -EntryType Error

# Show 10 most recent Application errors
Get-EventLog -LogName Application -Newest 10 -EntryType Error

# Show full details of a specific error by Index number
Get-EventLog -LogName System -Index 19421 | Format-List

# Real finding today on SUMMER PC:
# Index 19421 — WhatsApp failed to update — error 0x80073d02
# Cause  : WhatsApp was open during Windows Update
# Fix    : Close WhatsApp → Run Windows Update → Restart

# ─────────────────────────────────────────
# COMMAND 7 — Get-Service
# Purpose : List all Windows services and their status
# ─────────────────────────────────────────

# Show all services
Get-Service

# Show only running services
Get-Service | Where-Object {$_.Status -eq "Running"}

# Show only stopped services
Get-Service | Where-Object {$_.Status -eq "Stopped"}

# Check a specific service
Get-Service -Name WinDefend

# Check if McAfee is fully removed
Get-Service | Where-Object {$_.DisplayName -like "*McAfee*"}

# Stop and Start a service (requires Admin PowerShell)
Stop-Service -Name ServiceName -Force
Start-Service -Name ServiceName
Restart-Service -Name ServiceName

# Real finding today:
# McAfee and Windows Defender both running = double antivirus
# Fix: Uninstalled McAfee completely via Settings → Apps
# Result: PC faster, RAM freed, no more conflict

# ─────────────────────────────────────────
# COMMAND 8 — Test-Connection
# Purpose : Ping a server — check network connectivity
# ─────────────────────────────────────────

# Basic ping to Google
Test-Connection -ComputerName google.com -Count 4

# Ping Microsoft
Test-Connection -ComputerName microsoft.com -Count 4

# Real result on SUMMER PC today:
# Time = 8-10ms → Excellent connection
# Status = Success → Internet working perfectly
# TSE conclusion: Internet fine, problem is app-side not network

# ─────────────────────────────────────────
# COMMAND 9 — Get-NetAdapter
# Purpose : Show all network adapters and their status
# Note    : Requires Administrator PowerShell
# ─────────────────────────────────────────
Get-NetAdapter

# Real result on SUMMER PC today:
# WiFi               → Status: Up    → 72.2 Mbps → Connected
# Local Area Connection → Status: Disconnected → TAP VPN adapter

# ─────────────────────────────────────────
# COMMAND 10 — Get-Disk
# Purpose : Check hard disk info and health status
# Note    : Requires Administrator PowerShell
# ─────────────────────────────────────────
Get-Disk

# Real result on SUMMER PC today:
# Disk 0 — INTEL SSD — Healthy — Online — 476.94 GB — GPT
# Conclusion: SSD (fast), Healthy, no disk problems

# ─────────────────────────────────────────
# BONUS — Useful combinations TSE uses daily
# ─────────────────────────────────────────

# Find top RAM consuming process and kill it
Get-Process | Sort-Object WorkingSet -Descending | Select-Object -First 1

# Open Windows Update
Start-Process "ms-settings:windowsupdate"

# Open Add or Remove Programs
Start-Process "appwiz.cpl"

# Search for any process by partial name
Get-Process | Where-Object {$_.ProcessName -like "*chrome*"}

# ─────────────────────────────────────────
# TSE QUICK REFERENCE
# ─────────────────────────────────────────
# Silence after command       = SUCCESS in PowerShell
# Error after Get-Process     = process not running
# Empty result                = open fresh Admin window
# 4xx API errors              = client side problem
# 5xx API errors              = server side problem
# 0x80073d02                  = app open during update
# HDD = spinning disk (slow)  SSD = no moving parts (fast)
# Time(ms) under 30           = excellent connection
# ─────────────────────────────────────────
# End of Day 4 PowerShell Practice
# Commit message: Day 4 PowerShell practice — 10 commands
# ─────────────────────────────────────────
