# Define the client ID of the system assigned managed identity
$clientId = "fa348dc2-65a7-4ef6-a733-d81371f1a6e8"

# Login to Azure using the system assigned managed identity
Start-Process powershell -ArgumentList "-Command", "az login --identity --username $clientId"

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
Start-Process powershell -ArgumentList "-Command", "$outputs = az deployment group show --resource-group $resourceGroup --name $deploymentName --query properties.outputs"


# Write outputs to a file on the VM
$outputs | Out-File -FilePath "$CreateDirAzmOffer\parameters.json"
