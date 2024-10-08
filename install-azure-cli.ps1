# Define the directory where Azure CLI will be installed
$installDir = "C:\AzureCli"

# Create the directory if it doesn't exist
if (-Not (Test-Path -Path $installDir)) {
    New-Item -ItemType Directory -Path $installDir
}

# Define the URL for the Azure CLI installer
$installerUrl = "https://aka.ms/installazurecliwindowsx64"

# Define the path for the installer
$installerPath = "$installDir\AzureCLI.msi"

# Download the installer
Invoke-WebRequest -Uri $installerUrl -OutFile $installerPath

# Install Azure CLI
Start-Process -FilePath msiexec.exe -ArgumentList "/i $installerPath /quiet" -Wait

# Set Azure CLI configuration
Start-Process powershell -ArgumentList "-Command", "az config set bicep.use_binary_from_path=true"

# Clean up the installer file
# Remove-Item -Path $installerPath

Write-Output "Azure CLI has been installed successfully in $installDir"

# End of script
