# Define the client ID of the system assigned managed identity
$clientId = "fa348dc2-65a7-4ef6-a733-d81371f1a6e8"

# Define the full path to the Azure CLI
$azPath = "C:\Program Files\Microsoft SDKs\Azure\CLI2\wbin\az.cmd"

# Login to Azure using the system assigned managed identity
$arguments = @("-Command", "& '$azPath' login --identity --username '$clientId'")
Start-Process -FilePath "powershell" -ArgumentList $arguments -Wait 

# Define the root directory from where the Azure Marketplace offer templates will be deployed
$CreateDirAzmOffer = "C:\azmOffer"

# Create the directory if it doesn't exist
if (-Not (Test-Path -Path $CreateDirAzmOffer)) {
    New-Item -ItemType Directory -Path $CreateDirAzmOffer
}

# Variables
$resourceGroup = "spawn"
$deploymentName = "mainTemplate"

# Execute the command and capture output and error
$outputsJson = & "$azPath" deployment group show --resource-group $resourceGroup --name $deploymentName --query properties.outputs -o json 2> "$CreateDirAzmOffer\error.txt"

# Check for error output
if (Test-Path "$CreateDirAzmOffer\error.txt") {
    $errorOutput = Get-Content "$CreateDirAzmOffer\error.txt" -Raw
    if ($errorOutput) {
        Write-Error "Error encountered: $errorOutput"
        exit 1
    }
}

# Convert the JSON output to a PowerShell object
try {
    $outputs = $outputsJson | ConvertFrom-Json
} catch {
    Write-Error "Failed to convert output to JSON. Output was: $outputsJson"
    exit 1
}

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
