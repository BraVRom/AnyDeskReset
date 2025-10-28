# AnyDeskReset Script - By Br4hx

This batch script helps reset AnyDesk by moving its configuration files to timestamped backup folders, ensuring AnyDesk is closed before proceeding. It solves the "100-second countdown" issue by clearing AnyDesk’s usage history and configuration files, while keeping a log of all operations.

## Purpose

Occasionally, AnyDesk may incorrectly detect commercial use and trigger a 100-second countdown delay when attempting to connect. This script helps bypass that issue by resetting AnyDesk’s configuration files, moving them to unique timestamped backup folders, and potentially removing the delay caused by AnyDesk's incorrect commercial usage detection.

## Features

- Closes AnyDesk if it is running.
- Moves AnyDesk configuration files (`service.conf` and `system.conf`) to **timestamped backup folders** to avoid overwriting previous backups.
- Logs every operation in a file located at `%TEMP%\AnyDeskReset_<timestamp>.log`.
- Ensures the script waits for the user to see the results before closing.
- Prevents data loss by moving files instead of deleting them.

## Requirements

- Windows OS
- Administrator privileges to run the script

## How to Use

1. **Download the script:**
   - Download the `AnyDeskReset.bat` file or create your own `.bat` file and paste the provided script.

2. **Run the script:**
   - Right-click the `.bat` file and select **Run as administrator**.
   - The script will automatically check if AnyDesk is running, close it if necessary, and move configuration files to timestamped backup folders.

3. **View results:**
   - The script will display the number of files moved, the location of the backup folders, and the log file path in the terminal.
   - Press any key to exit the script once done.

## What the Script Does

- **Closes AnyDesk:** Ensures AnyDesk is not running before making changes.
- **Moves Configuration Files:** Moves `service.conf` and `system.conf` from the following locations:
   - `%USERPROFILE%\AppData\Roaming\AnyDesk`
   - `C:\ProgramData\AnyDesk`
- **Timestamped Backup Folders:** Creates unique backup folders for each reset with a timestamp (e.g., `backup_2025-10-28_10-12`) to prevent overwriting previous backups.
- **Logging:** Records the status of each file operation in a log file in `%TEMP%`.
- **Completion:** Displays a summary of moved files, backup folder locations, and log file path. The script waits for a keypress so the user can review results.

## Important Notes

- **Non-Commercial Use:** This script is designed for non-commercial users. If you use AnyDesk for business or commercial purposes, consider purchasing a commercial license to comply with AnyDesk's terms of service.

- **File Recovery:** Files are moved, not deleted. You can manually restore them from the backup folder if needed.  
- **Multiple Resets:** Each reset creates a new timestamped backup folder, so multiple resets won’t overwrite previous backups.
