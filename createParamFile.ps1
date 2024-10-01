# Define the root directory from where the Azure Marketplace offer will be deployed
$CreateDirAzmOffer = "C:\azmOffer"

# Create the directory if it doesn't exist
if (-Not (Test-Path -Path $CreateDirAzmOffer)) {
    New-Item -ItemType Directory -Path $CreateDirAzmOffer
}

#Define Variables to be written to the parameter file
param (
    [string]$vmName,
    [string]$region,
    [string]$appResourceGroup
    )
$json = @{
        '$schema' ='https://schema.management.azure.com/schemas/2019-04-01/deploymentParameters.json#'
            contentVersion = '1.0.0.0'
            paramaters = @{
                vmName = @{
                    value = $vmName
                }
                region = @{
                    value = $region
                }
                appResourceGroup = @{
                    value = $appResourceGroup
                }
            }
        }
    
$json | ConvertTo-Json -Depth 3 | Out-File -FilePath "$CreateDirAzmOffer\azuredeploy.parameters.json"
    