# import standard variables
invoke-expression -Command .\ENV.ps1

# create subscription resource group
New-AzResourceGroup -Location $location -Name sub-pg-management

# create resource groups
New-AzResourceGroup -Location $location -Name rg-pg-management


New-AzResourceGroup -Location $location -Name rg-pg-deploy


New-AzResourceGroup -Location $location -Name rg-pg-security

