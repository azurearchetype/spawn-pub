# Define parameters with default values
param (
    [string]$VMName = "vmspawn01",
    [string]$ResourceGroupName = "spawn",
    [string]$ScriptPath = "C:\\Packages\\Plugins\\Microsoft.Compute.CustomScriptExtension\\1.10.18\\Downloads\\0\\createParamFile.ps1"
)

# Execute the script on the VM
Invoke-AzVMRunCommand -ResourceGroupName $ResourceGroupName -VMName $VMName -CommandId 'RunPowerShellScript' -ScriptPath $ScriptPath
