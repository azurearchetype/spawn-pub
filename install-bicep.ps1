# Define the directory where Bicep will be installed
$installDirBicep = "C:\Program Files\Microsoft SDKs\Azure\CLI2\wbin"

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

# Set Azure CLI to USe the Bicep binary from the system PATH
az config set bicep.use_binary_from_path=true

# Add the directory to the PATH environment variable
# $env:Path += ";$installDirBicep"
# [System.Environment]::SetEnvironmentVariable("PATH", $env:Path, [System.EnvironmentVariableTarget]::Machine)

Write-Output "Directory added to PATH: $installDirBicep"
Write-Output "Bicep Extensions have been installed successfully in $installDirBicep"

# End of script
