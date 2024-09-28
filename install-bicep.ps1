# Define the directory where Bicep will be installed
$installDirBicep = "C:\Bicep"

# Create the directory if it doesn't exist
if (-Not (Test-Path -Path $installDirBicep)) {
    New-Item -ItemType Directory -Path $installDirBicep
}

# Define the URL for the Azure CLI installer
$installerUrlBicep = "https://github.com/Azure/bicep/releases/latest/download/bicep-win-x64.exe"

# Define the path for the installer
$installerPathBicep = "$installDirBicep\bicep-win-x64.exe"

# Download the installer
Invoke-WebRequest -Uri $installerUrlBicep -OutFile $installerPathBicep

# Install Azure CLI
Start-Process -FilePath msiexec.exe -ArgumentList "/i $installerPathBicep /quiet" -Wait

# Clean up the installer file
# Remove-Item -Path $installerPath

Write-Output "Bicep Extensions have been installed successfully in $installDirBicep"


# create local directory
# New-Item -path "C:\Bicep" -ItemType Directory
