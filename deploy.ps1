param (
    [Parameter(mandatory=$true)]
    [string] $SubscriptionId,
    [Parameter(mandatory=$true)]
    [string] $StorageAccountName, 
    [Parameter(mandatory=$true)]
    [string] $ResourceGroupName,
    [Parameter(mandatory=$true)]
    [string] $MachineName,

    [string] $pathWhereMachineScriptIs = ".",
    [string] $machineScriptFileName = "machine.ps1"
)

# make sure we remember where we are
$currentPath = Convert-Path .

# go to the machine script folder and get the absolute path
Set-Location $pathWhereMachineScriptIs
$fullPathWhereMachineScriptIs = Convert-Path .

# log into Azure
Login-AzAccount

# select subscript
Select-AzSubscription -SubscriptionId $SubscriptionId

# get storage account
$storageAccount = Get-AzStorageAccount -ResourceGroupName $ResourceGroupName -Name $StorageAccountName 

# get context for blob upload
$storageContext = $storageAccount.Context

# perform blob upload
if(-not(Get-AzStorageContainer -Name "script" -Context $storageContext -ErrorAction SilentlyContinue)) {
    New-AzStorageContainer -Name "script" -Context $storageContext
}

# upload script
Set-AzStorageBlobContent -Context $storageContext -File ($fullPathWhereMachineScriptIs + "\" + $machineScriptFileName) -Container "script" -Blob "machine.ps1" -BlobType Block -Force

# run script
Set-AzVMCustomScriptExtension -StorageAccountName $StorageAccountName -ContainerName "script" -FileName "machine.ps1" -StorageAccountKey ((Get-AzStorageAccountKey -ResourceGroupName $ResourceGroupName -Name $StorageAccountName)[0].Value) -Name "customScript" -VMName $MachineName -ResourceGroupName $ResourceGroupName -Location (Get-AzResourceGroup -Name $ResourceGroupName).Location

# let's go back to where we were
Set-Location $currentPath