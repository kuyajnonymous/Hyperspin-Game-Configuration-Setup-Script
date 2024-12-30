# Hyperspin Game Configuration Setup Script

# Set base directories
$ROMS_DIR = Get-Location  # This will get the current directory where the script is run
$LOGO_DIR = "D:\RetroCade\RetroCade FULL\collections\PC Games\logo"
$FLYER_DIR = "D:\RetroCade\RetroCade FULL\collections\PC Games\Flyer"
$TITLE_DIR = "D:\RetroCade\RetroCade FULL\collections\PC Games\Title"
$WHEEL_DIR = "D:\RetroCade\RetroCade FULL\collections\PC Games\Wheel"
$VIDEOS_DIR = "D:\RetroCade\RetroCade FULL\collections\PC Games\Videos"
$CFG_DIR = "D:\RetroCade\RetroCade FULL\romlists\All Systems"
$TEXT_DIR = "D:\RetroCade\RetroCade FULL\romlists"
$PC_GAMES_FILE = "$TEXT_DIR\PC Games.txt"
$ALL_SYSTEMS_FILE = "$TEXT_DIR\All Systems.txt"

# Define the path for the scan files
$allSystemsFile = "D:\RetroCade\RetroCade FULL\romlists\All Systems.txt"
$pcGamesFile = "D:\RetroCade\RetroCade FULL\romlists\PC Games.txt"

# Get all directories in the ROMs folder
$folders = Get-ChildItem -Path $ROMS_DIR -Directory

# Function to add a line to a file if it doesn't already exist
function Add-UniqueLine($file, $line) {
    # Check if the file exists
    if (Test-Path $file) {
        # Read the existing content and check if the line already exists
        $existingLines = Get-Content $file
        if ($existingLines -notcontains $line) {
            # Prepend the line to the file content
            $newContent = $line + "`r`n" + ($existingLines -join "`r`n")
            Set-Content -Path $file -Value $newContent
        }
    } else {
        # If the file doesn't exist, create it and add the line
        Set-Content -Path $file -Value $line + "`r`n"
    }
}

# Process each folder in the ROMs directory
foreach ($folder in $folders) {
    $folderName = $folder.Name

    # Check if the logo file exists and copy default if not (flyer path)
    $flyerLogoFile = "$FLYER_DIR\$folderName.png"
    if (-not (Test-Path $flyerLogoFile)) {
        Copy-Item "$FLYER_DIR\dump.png" -Destination $flyerLogoFile
    }

    # Check if the logo file exists and copy default if not (title path)
    $titleLogoFile = "$TITLE_DIR\$folderName.png"
    if (-not (Test-Path $titleLogoFile)) {
        Copy-Item "$TITLE_DIR\dump.png" -Destination $titleLogoFile
    }

    # Check if the wheel file exists and copy default if not
    $wheelFile = "$WHEEL_DIR\$folderName.png"
    if (-not (Test-Path $wheelFile)) {
        Copy-Item "$WHEEL_DIR\dump.png" -Destination $wheelFile
    }

    # Check if the video file exists and copy default if not
    $videoFile = "$VIDEOS_DIR\$folderName.mp4"
    if (-not (Test-Path $videoFile)) {
        Copy-Item "$VIDEOS_DIR\dump.mp4" -Destination $videoFile
    }

    # Check if the cfg file exists and copy default if not
    $cfgFile = "$CFG_DIR\$folderName.cfg"
    if (-not (Test-Path $cfgFile)) {
        Copy-Item "$CFG_DIR\dump.cfg" -Destination $cfgFile
    }

    # Format the directory in the required string format for PC Games and All Systems
    $formattedLine = "$folderName;$folderName;PC Games;;2017;Capcom USA, Inc.;Fighting;;;;;0;;;;;;;;;"

    # Add the formatted string to both scan files if it doesn't already exist
    Add-UniqueLine -file $allSystemsFile -line $formattedLine
    Add-UniqueLine -file $pcGamesFile -line $formattedLine

    # Generate the .bat file for the game folder
    $batFile = "$ROMS_DIR\$folderName.bat"
    @"
@echo off
setlocal
set "GAMENAME=$folderName.exe"
set "GAMEPATH=\$folderName"
set HOME="%~dp0"
set "GAMEROOT=%~dp0%GAMEPATH%"
cd "%GAMEROOT%"
start "" /WAIT "%GAMEROOT%%GAMENAME%"
exit
"@ | Out-File -FilePath $batFile

    Write-Host "Processed $folderName"
}

Write-Host "Done creating .bat files, updating text files, and copying default files."
Pause
