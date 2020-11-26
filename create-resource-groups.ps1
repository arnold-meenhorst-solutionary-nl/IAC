$location='westeurope'

New-AzResourceGroup -Location $location -Name sub-pg-connectivity
New-AzResourceGroup -Location $location -Name rg-pg-connectivity
New-AzResourceGroup -Location $location -Name rg-pg-privdns
New-AzResourceGroup -Location $location -Name rg-pg-appgw
New-AzResourceGroup -Location $location -Name rg-pg-exprout

New-AzResourceGroup -Location $location -Name sub-pg-identity
New-AzResourceGroup -Location $location -Name rg-pg-identity-hub
New-AzResourceGroup -Location $location -Name rg-pg-identity-dc

New-AzResourceGroup -Location $location -Name sub-pg-ia-data-acc
New-AzResourceGroup -Location $location -Name rg-pg-ia-data-network-acc

New-AzResourceGroup -Location $location -Name sub-pg-ia-data-prd
New-AzResourceGroup -Location $location -Name rg-pg-ia-data-network-prd


New-AzResourceGroup -Location $location -Name sub-pg-ia-lz-prd
New-AzResourceGroup -Location $location -Name rg-pg-ia-lz-network-prd
New-AzResourceGroup -Location $location -Name rg-pg-ia-lz-general-prd 
New-AzResourceGroup -Location $location -Name rg-pg-ia-lz-workload-1-prd 
New-AzResourceGroup -Location $location -Name rg-pg-ia-lz-workload-2-prd 
New-AzResourceGroup -Location $location -Name rg-pg-ia-lz-workload-3-prd 
New-AzResourceGroup -Location $location -Name rg-pg-ia-lz-workload-4-prd 

New-AzResourceGroup -Location $location -Name sub-pg-sandbox
New-AzResourceGroup -Location $location -Name rg-pg-sandbox-1 
New-AzResourceGroup -Location $location -Name rg-pg-sandbox-2 
New-AzResourceGroup -Location $location -Name rg-pg-sandbox-3
New-AzResourceGroup -Location $location -Name rg-pg-sandbox-4
 