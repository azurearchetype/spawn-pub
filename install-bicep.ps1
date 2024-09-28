# Define the directory where Bicep will be installed
$installDir2 = "C:\Bicep"

# Create the directory if it doesn't exist
if (-Not (Test-Path -Path $installDir2)) {
    New-Item -ItemType Directory -Path $installDir2
}

# Define the URL for the Azure CLI installer
$installerUrl2 = "https://github.com/Azure/bicep/releases/latest/download/bicep-win-x64.exe"

# Define the path for the installer
$installerPath2 = "$installDir2\bicep-win-x64.exe"

# Download the installer
Invoke-WebRequest -Uri $installerUrl2 -OutFile $installerPath2

# Install Azure CLI
Start-Process -FilePath msiexec.exe -ArgumentList "/i $installerPath2 /quiet" -Wait

# Clean up the installer file
# Remove-Item -Path $installerPath

Write-Output "Bicep Extensions have been installed successfully in $installDir2"


# create local directory
# New-Item -path "C:\Bicep" -ItemType Directory
