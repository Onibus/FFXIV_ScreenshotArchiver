<#
.SYNOPSIS
Easily organize FFXIV screenshots in to folders by year and date to avoid the agonizing wait when loading directory in excess of 1,000 files.
.DESCRIPTION
Love taking screenshots? With time, you've likely amassed quite the collection. The problem though is when opening the screenshot directory, you've likely sat waiting for Windows to do its thing before files are sorted or thumbnails are shown. Sans technical explanation, this is quite the annoying behavior, especially when the directory is opened multiple times. This script will sort the screenshots in to folders organized by year and month thereby reducing the number of files having to be shown..PARAMETER directory
Sets the screenshot directory. Defaults to '$env:userprofile\Documents\My Games\FINAL FANTASY XIV - A Realm Reborn\screenshots'.
.PARAMETER showlog
Show the log file once script has ran. Located in '$env:temp\FFXIV_ScreenshotArchiver.txt'.
.EXAMPLE
Default parameters.
.\FFXIV_ScreenshotArchiver.ps1
.EXAMPLE
Custom directory location and show log file.
.\FFXIV_ScreenshotArchiver.ps1 -directory "$env:userprofile\Documents\My Games\FFXIV\Screenshots" -showlog
.LINK
https://github.com/Onibus/FFXIV_ScreenshotArchiver
#>
[Cmdletbinding()]
param(
    [Parameter(Mandatory = $false, HelpMessage = "Screenshot Directory. If not set, defaults to 'C:\username\Documents\My Games\FINAL FANTASY XIV - A Realm Reborn\screenshots'")]
    [string]$directory = "$env:userprofile\Documents\My Games\FINAL FANTASY XIV - A Realm Reborn\screenshots",
    [Parameter(Mandatory = $false, HelpMessage = "Whether or not to show the log after script execution. The log file may be found in '`$env:temp\FFXIV_ScreenshotArchiver.txt'")]
    [switch]$showlog
)
function write-log {
    # Outputs messages to both console and log file
    [Cmdletbinding()]
    param(
        $message,
        [Parameter(Mandatory = $false, HelpMessage = "Folder\Filename.txt where to save log file")]
        $location = "$env:temp\FFXIV_ScreenshotArchiver.txt",
        [Parameter(Mandatory = $false, HelpMessage = "Whether to tab message entry.")]
        [switch]$tab)
    $timestamp = $(get-date -f "yyyy-MM-dd_HH:mm:ss")
    if ($tab.IsPresent) {
        write-host "$timestamp|`t$message"
        "$timestamp|`t$message" | out-file -Append $location
    }
    else {
        write-host "$timestamp|$message"
        "$timestamp|$message" | out-file -Append $location
    }
}
if (!(test-path $directory)) { #Unable to find specified directory set in $directory.
    $directory = Read-Host "Could not find screenshot directory location '$directory'. Enter in the directory where screenshots are kept"
}
write-log "Beginning screenshot cleanup"
write-log "Screenshot folder: '$directory'" -tab
$Files = Get-ChildItem -Path $directory | ? { $_.extension -like "*.png" -or $_.extension -like "*.jpg" -or $_.extension -like "*.jpeg" } | Sort LastWriteTime #Retrieve list of files in $directory
write-log "There are $($files.count) files to be archived..."
$ErrorActionPreference = "Stop"
try {
    foreach ($file in $files) {
        $filedate = $('{0:yyyy-MM}' -f $($file | select -ExpandProperty LastWriteTime)) #Retrieve the year and month of file creation. To be used for moving file in to respective folder.
        $path = "$($file.directory)\$filedate" #Folder we will place the image in. Organized by year and month.
        if (!(test-path $path)) {
            New-Item $path -ItemType directory | out-null #Create the directory if it doesn't exist.
        }
        write-log "Moving image '$($file.name)' to folder '\$filedate'" -tab
        Move-Item "$($file.fullname)" "$path\$($file.name)" -Force
    }
}
catch { 
    write-log "ERROR: $($error[0])"
}
write-log "Cleanup complete!"
if ($showlog.IsPresent) { #Show the log file in Notepad is '-showlog' switch was set.
    Start-Process "notepad.exe" -ArgumentList "$env:temp\FFXIV_ScreenshotArchiver.txt"
}