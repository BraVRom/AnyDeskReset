# AnyDeskReset Script - By Br4hx (January 2026 updated)

This advanced batch utility automates the process of resetting the AnyDesk ID while preserving essential user data like favorites and thumbnails. It is specifically designed to bypass the "commercial use" detection and the 100-second connection delay by performing a clean configuration wipe followed by a forced ID regeneration.

## Key Improvements in v2.0

* **Flicker-Free Progress Bar:** Replaced the `cls` loop with a Carriage Return (`CR`) based progress tracker for a smoother UI. No more flickering console!
* **Smart ID Regeneration:** The script doesn't just delete files; it launches AnyDesk, waits for the system to generate a new unique ID, and then closes it safely to commit changes.
* **Data Preservation:** Automatically backs up and restores `user.conf` (Favorites) and the `thumbnails` folder, so you don't lose your remote contacts.
* **File-Lock Protection:** Includes a 2-second buffer and service-stop commands to prevent "Access Denied" errors when Windows locks configuration files.
* **Security Verification:** Checks if files were actually moved before proceeding, preventing false-positive success messages.

## 🛠 Features

* **Automated Service Management:** Stops `AnyDeskService` and kills active processes.
* **Timestamped Backups:** All old configurations are moved to `%TEMP%\AnyDeskBackup_[Timestamp]`—nothing is permanently deleted.
* **Trace Cleaning:** Wipes `.trace` files to remove usage history logs.
* **Admin Validation:** Built-in check to ensure the script has the necessary permissions to modify `ProgramData`.

## Requirements

* **Windows OS** (10 or 11).
* **Administrator Privileges** (Right-click > Run as Administrator).
* **AnyDesk Installed** in default paths (`Program Files` or `Program Files (x86)`).

## How to Use

1.  **Download:** Get the `AnyDeskReset.bat` file.
2.  **Run:** Right-click the file and select **Run as administrator**.
3.  **Wait:** The script will:
    * Close AnyDesk.
    * Backup your current ID.
    * Launch AnyDesk briefly to generate a new ID (you will see a progress **%** in the console).
    * Close AnyDesk and restore your favorites.
4.  **Done:** Launch AnyDesk normally; you will have a brand new ID and no connection delays.

## Technical Details

The script targets the following critical paths:
* **Roaming:** `%APPDATA%\AnyDesk` (Local configuration and user data).
* **ProgramData:** `C:\ProgramData\AnyDesk` (System-wide service configuration).

### Files Handled

| File/Folder | Action | Purpose |
| :--- | :--- | :--- |
| `system.conf` / `service.conf` | **Reset** | Removes the old ID and license trace. |
| `user.conf` | **Restore** | Keeps your "Favorites" list intact. |
| `thumbnails/` | **Restore** | Keeps the preview images of your remote desktops. |
| `*.trace` | **Delete** | Clears the connection log history. |

## ⚠️ Important Notes

* **Non-Commercial Use:** This tool is intended for personal use. If you use AnyDesk for professional purposes, please support the developers by purchasing a formal license.
* **Safe Recovery:** Since the script moves files to the `%TEMP%` folder instead of deleting them, you can always undo the process by manually moving the files back from the backup directory.
* **Logging:** A full log of the operation is saved at the backup path for troubleshooting.
