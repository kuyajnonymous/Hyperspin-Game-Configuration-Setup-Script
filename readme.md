Documentation for the Repository
Title: Hyperspin Game Configuration Setup Script
Description:
This PowerShell script automates the process of creating the necessary files and configurations for integrating PC games into Hyperspin using RocketLauncher. It processes a set of directories, generates missing media files, creates batch files, and updates scan files for integration with Hyperspin. The script also ensures missing files (like logos, videos, and configurations) are copied from default templates.

Features:
Generate Media Files: If missing, the script copies default files (dump.png, dump.mp4, dump.cfg) to the appropriate directories (logo, flyer, title, wheel, video, and config).
Create Batch Files: The script generates .bat files for each game to allow launching the game from within Hyperspin.
Update Scan Files: The script adds entries for each game in the PC Games.txt and All Systems.txt scan files used by RocketLauncher.
Automatically Uses Current Directory: The script can be placed in any directory and automatically uses that directory as the source for the ROMs.
How to Use:
Place the script in the directory where your ROMs are stored. It will automatically use that directory as the source.
Modify the base directories at the beginning of the script if necessary, particularly the paths for logos, flyers, and other media.
Run the script from PowerShell:
powershell
Copy code
.\HyperspinGameSetup.ps1
After the script runs, manually configure RocketLauncher for the games to ensure proper launching.
Prerequisites:
PowerShell: The script is designed to run in a PowerShell environment.
RocketLauncher: Necessary for integration with Hyperspin. You will need to configure RocketLauncher manually after running the script.
Media Files: Default media files (e.g., dump.png, dump.mp4, dump.cfg) must be placed in the appropriate directories.
Notes:
The script generates basic .bat files for launching games; however, additional configuration may be required in RocketLauncher to ensure proper functionality in the frontend.
The script copies default files when specific files are missing but you may need to customize media files later.
