# Define the directory where Azure CLI will be installed
$installDir = "C:\Bicep"

# Create the directory if it doesn't exist
if (-Not (Test-Path -Path $installDir)) {
    New-Item -ItemType Directory -Path $installDir
}

# Define the URL for the Azure CLI installer
$installerUrl = "https://github.com/Azure/bicep/releases/latest/download/bicep-win-x64.exe"

# Define the path for the installer
$installerPath = "$installDir\bicep-win-x64.exe"

# Download the installer
Invoke-WebRequest -Uri $installerUrl -OutFile $installerPath

# Install Azure CLI
Start-Process -FilePath msiexec.exe -ArgumentList "/i $installerPath /quiet" -Wait

# Clean up the installer file
# Remove-Item -Path $installerPath

Write-Output "Bicep Extensions have been installed successfully in $installDir"


# create local directory
# New-Item -path "C:\Bicep" -ItemType Directory
