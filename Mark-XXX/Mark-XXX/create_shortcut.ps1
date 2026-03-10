# create_shortcut.ps1
# Run this script ONCE to create the desktop shortcut with a hotkey

# ---------------------------------------------------------------
# EDIT THIS PATH to where your Mark-XXX project folder is located
$projectPath = "E:\Mepco College\Mini Project\Mark-XXX"
# ---------------------------------------------------------------

$batFile     = "$projectPath\run_markxxx.bat"
$shortcutPath = "$env:USERPROFILE\Desktop\Mark XXX.lnk"

# Copy the batch file into the project folder if not already there
if (-Not (Test-Path $batFile)) {
    Copy-Item "$PSScriptRoot\run_markxxx.bat" -Destination $batFile
    Write-Host "Copied run_markxxx.bat to project folder."
}

# Create the desktop shortcut
$shell    = New-Object -ComObject WScript.Shell
$shortcut = $shell.CreateShortcut($shortcutPath)

$shortcut.TargetPath       = $batFile
$shortcut.WorkingDirectory = $projectPath
$shortcut.WindowStyle      = 1
$shortcut.Hotkey           = "CTRL+ALT+M"       # <-- Change hotkey here if you want
$shortcut.IconLocation     = "shell32.dll,13"   # Robot/computer icon
$shortcut.Description      = "Launch Mark XXX AI Assistant"
$shortcut.Save()

Write-Host ""
Write-Host "✅ Shortcut created on Desktop: 'Mark XXX'"
Write-Host "⌨️  Hotkey assigned: CTRL + ALT + M"
Write-Host ""
Write-Host "👉 To change the hotkey: Right-click the shortcut > Properties > Shortcut key"
