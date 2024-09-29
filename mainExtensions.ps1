# mainExtensions.ps1

winget install --id Git.Git -e --source winget
winget install --id Microsoft.AzureCLI -e --source winget -Wait
az bicep install

# Done installing core extensions
