
# Define the root directory from where the Azure Marketplace offer will be deployed
$CreateDirAzmOffer = "C:\azmOffer"

# Create the directory if it doesn't exist
if (-Not (Test-Path -Path $CreateDirAzmOffer)) {
    New-Item -ItemType Directory -Path $CreateDirAzmOffer
}

# Variables
$resourceGroup = "spawn"
$deploymentName = "mainTemplate"

# Retrieve the outputs
$outputs = az deployment group show --resource-group $resourceGroup --name $deploymentName --query properties.outputs

# Write outputs to a file on the VM
$outputs | Out-File -FilePath "$CreateDirAzmOffer\parameters.json"
