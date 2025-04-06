# AnyDeskReset Script - By Br4hx

This batch script helps reset AnyDesk by moving its configuration files to a backup folder, ensuring AnyDesk is closed before proceeding. It solves the "100-second countdown" issue by clearing AnyDesk’s usage history and configuration files.

## Purpose

Occasionally, AnyDesk may incorrectly detect commercial use and trigger a 100-second countdown delay when attempting to connect. This script helps bypass that issue by resetting AnyDesk’s configuration files, moving them to a backup folder, and potentially removing the delay caused by AnyDesk's incorrect commercial usage detection.

## Features
- Closes AnyDesk if it is running.
- Moves AnyDesk configuration files to backup folders.
- Resets AnyDesk’s configuration, preventing the 100-second countdown.
- Simple and easy-to-use script for non-commercial users of AnyDesk.
- Prevents any data loss by moving files instead of deleting them.

## Requirements
- Windows OS
- Administrator privileges to run the script

## How to Use

1. **Download the script:**
   - Download the `AnyDeskReset.bat` file or create your own `.bat` file and paste the provided script.

2. **Run the script:**
   - Right-click the `.bat` file and select **Run as administrator**.
   - The script will automatically check if AnyDesk is running, close it if necessary, and move configuration files.

3. **Done!**
   - The script will display the results in the terminal and inform you if AnyDesk was reset successfully.

## What the Script Does

- **Closes AnyDesk**: Ensures that AnyDesk is not running before making any changes.
- **Moves Configuration Files**: The script moves `service.conf` and `system.conf` from the following locations:
   - `%USERPROFILE%\AppData\Roaming\AnyDesk`
   - `C:\ProgramData\AnyDesk`
- **Backup Folder**: It creates an "old" folder in the same directory where the configuration files are moved.
- **Completion**: After completing, it will let you know how many files were moved and provide a success message.


## Important Notes

- **Non-Commercial Use**: This script is designed for non-commercial users. If you use AnyDesk for business or commercial purposes, consider purchasing a commercial license from AnyDesk to comply with their terms of service.
  
- **File Recovery**: The files are moved, not deleted. If needed, you can restore the files manually from the backup folder.
