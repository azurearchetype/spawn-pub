# Define the directory where Bicep will be installed
$installDirBicep = "$env:USERPROFILE\.azure\bin"

# Create the directory if it doesn't exist
if (-Not (Test-Path -Path $installDirBicep)) {
    New-Item -ItemType Directory -Path $installDirBicep
}

# Define the URL for the Bicep installer
$installerUrlBicep = "https://github.com/Azure/bicep/releases/latest/download/bicep-win-x64.exe"

# Define the path for the installer
$installerPathBicep = "$installDirBicep\bicep.exe"

# Download the installer
Invoke-WebRequest -Uri $installerUrlBicep -OutFile $installerPathBicep

# Install Bicep
#Start-Process -FilePath $installerPathBicep -ArgumentList "/S" -Wait
#az bicep install

# Clean up the installer file
# Remove-Item -Path $installerPathBicep

Write-Output "Bicep Extensions have been installed successfully in $installDirBicep"

# End of script
