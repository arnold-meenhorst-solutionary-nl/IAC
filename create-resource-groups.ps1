New-AzResourceGroup -Location westeurope -Name rg-pg-management
New-AzResourceGroup -Location westeurope -Name rg-pg-deploy
New-AzResourceGroup -Location westeurope -Name rg-pg-security
New-AzResourceGroup -Location westeurope -Name rg-pg-connectivity
New-AzResourceGroup -Location westeurope -Name rg-pg-privdns
New-AzResourceGroup -Location westeurope -Name rg-pg-appgw
New-AzResourceGroup -Location westeurope -Name rg-pg-exprout
New-AzResourceGroup -Location westeurope -Name rg-pg-identity-hub
New-AzResourceGroup -Location westeurope -Name rg-pg-identity-dc

New-AzResourceGroup -Location westeurope -Name rg-pg-ia-lz-network-prd # beter ook connectivity noemen
New-AzResourceGroup -Location westeurope -Name rg-pg-ia-lz-general-prd 
New-AzResourceGroup -Location westeurope -Name rg-pg-ia-lz-workload-1-prd 
New-AzResourceGroup -Location westeurope -Name rg-pg-ia-lz-workload-2-prd 

