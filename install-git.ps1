# Define the directory where Git will be installed
$installDirGit = "C:\Git"

# Create the directory if it doesn't exist
if (-Not (Test-Path -Path $installDirGit)) {
    New-Item -ItemType Directory -Path $installDirGit
}

# Define the URL for the Git installer
$installerUrlGit = "https://github.com/git-for-windows/git/releases/download/v2.46.2.windows.1/Git-2.46.2-64-bit.exe"

# Define the path for the installer
$installerPathGit = "$installDirGit\InstallGit.exe"

# Download the installer
Invoke-WebRequest -Uri $installerUrlGit -OutFile $installerPathGit

#install Git
Start-Process -FilePath $installerPathGit -ArgumentList "/SILENT" -Wait

# Clean up the installer file
# Remove-Item -Path $installerPathGit

Write-Output "Git has been installed successfully in $installDirGit"

# End of script
