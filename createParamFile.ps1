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

# Construct the command string
$command = "az deployment group show --resource-group $resourceGroup --name $deploymentName --query properties.outputs"

# Execute the command using Invoke-Expression and capture the output
$outputsJson = Invoke-Expression $command

# Convert the JSON output to a PowerShell object
$outputs = $outputsJson | ConvertFrom-Json

# Prepare the parameters file structure
$parameters = @{
    "$schema" = "https://schema.management.azure.com/schemas/2019-04-01/deploymentTemplate.json#"
    "contentVersion" = "1.0.0.0"
    "parameters" = @{}
}

# Populate the parameters section based on the outputs
foreach ($output in $outputs.PSObject.Properties) {
    $parameters.parameters[$output.Name] = @{
        "value" = $output.Value
    }
}

# Write outputs to a file on the VM in Bicep parameters file format
$parameters | ConvertTo-Json -Depth 10 | Out-File -FilePath "$CreateDirAzmOffer\parameters.json"
