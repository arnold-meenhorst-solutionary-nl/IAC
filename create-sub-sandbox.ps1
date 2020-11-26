# import standard variables
invoke-expression -Command .\ENV.ps1

Connect-AzAccount

$random=$(Get-Random -Maximum 10000)
 

#
# create subscription RG
#
$rg = 'sub-pg-sandbox' 
New-AzResourceGroup -Location $location -Name $rg

#
# create network RG
#
$rg = 'rg-pg-sandbox-network'
New-AzResourceGroup -Location $location -Name $rg 

    # create vnet
    $nsg = New-AzNetworkSecurityGroup -ResourceGroupName $rg -Location $location -Name "nsg-pg-sandbox" 
    $snet = New-AzVirtualNetworkSubnetConfig -Name snet-pg-sandbox -AddressPrefix "10.81.1.0/24" -NetworkSecurityGroup $nsg
    New-AzVirtualNetwork -Name vnet-pg-identity -ResourceGroupName $rg -Location $location -AddressPrefix "10.81.0.0/16" -Subnet $snet

#
# create rg-pg-sandbox-1 RG - SQL Server Serverless 
#
$rg='rg-pg-sandbox-1'  
New-AzResourceGroup -Location $location -Name $rg 

    # create sql server instance
    New-AzSqlServer -ResourceGroupName $rg -Location $location -ServerName "sql-$rg-$random" -ServerVersion "12.0" -SqlAdministratorCredentials (Get-Credential)
    # create sql server database
    New-AzSqlDatabase -ResourceGroupName $rg -ServerName "sql-$rg" -DatabaseName "db-$rg-$random" -Edition "GeneralPurpose" -Vcore 2 -ComputeGeneration "Gen5" -ComputeModel Serverless

#
# create rg-pg-sandbox-2 RG - SQL Server Single
#
$rg='rg-pg-sandbox-2'  
New-AzResourceGroup -Location $location -Name $rg 

#
# create rg-pg-sandbox-3 RG - SQL Server  
#
$rg='rg-pg-sandbox-3'  
New-AzResourceGroup -Location $location -Name $rg 

#
# create rg-pg-sandbox-4 RG - SQL Server  
#
$rg='rg-pg-sandbox-4'  
New-AzResourceGroup -Location $location -Name $rg 


<#

Remove-AzResourceGroup -Name sub-pg-sandbox -force
Remove-AzResourceGroup -Name rg-pg-sandbox-network -force
Remove-AzResourceGroup -Name rg-pg-sandbox-1 -force
Remove-AzResourceGroup -Name rg-pg-sandbox-2 -force
Remove-AzResourceGroup -Name rg-pg-sandbox-3 -force
Remove-AzResourceGroup -Name rg-pg-sandbox-4 -force

#>
