# Define the client ID of the system assigned managed identity
$clientId = "fa348dc2-65a7-4ef6-a733-d81371f1a6e8"

# Login to Azure using the system assigned managed identity
Start-Process powershell -ArgumentList "-Command", "az login --identity --username $clientId" -Wait

# Define the root directory from where the Azure Marketplace offer will be deployed
$CreateDirAzmOffer = "C:\azmOffer"

# Create the directory if it doesn't exist
if (-Not (Test-Path -Path $CreateDirAzmOffer)) {
    New-Item -ItemType Directory -Path $CreateDirAzmOffer
}

# Variables
$resourceGroup = "spawn"
$deploymentName = "mainTemplate"

# Execute the command using Start-Process and capture the output
$outputsJson = Start-Process -FilePath "az" -ArgumentList "deployment", "group", "show", "--resource-group", $resourceGroup, "--name", $deploymentName, "--query", "properties.outputs" -NoNewWindow -Wait -PassThru | Out-String

# Convert the JSON output to a PowerShell object
$outputs = $outputsJson | ConvertFrom-Json

# Prepare the parameters file structure
$parameters = @{}
$parameters["$schema"] = "https://schema.management.azure.com/schemas/2019-04-01/deploymentTemplate.json#"
$parameters["contentVersion"] = "1.0.0.0"
$parameters["parameters"] = @{}

# Populate the parameters section based on the outputs
foreach ($output in $outputs.PSObject.Properties) {
    $parameters.parameters[$output.Name] = @{
        "value" = $output.Value
    }
}

# Write outputs to a file on the VM in Bicep parameters file format
$parameters | ConvertTo-Json -Depth 10 | Out-File -FilePath "$CreateDirAzmOffer\parameters.json"
