# import standard variables
invoke-expression -Command C:\Users\Administrator\Documents\GitHub\IAC\ENV.ps1

# Connect-AzAccount

#
# create subscription RG
#
$rg = 'sub-pg-sandbox' 
New-AzResourceGroup -Location $location -Name $rg

# Create Log Analytics Workspace
New-AzOperationalInsightsWorkspace -Location $location -Name "log-pg-sandbox" -Sku Standard -ResourceGroupName $rg

#
# create network RG
#
$rg = 'rg-pg-sandbox-network'
New-AzResourceGroup -Location $location -Name $rg 

    # create vnet
    New-AzVirtualNetwork -Name vnet-pg-sandbox -ResourceGroupName $rg -Location $location -AddressPrefix "10.81.0.0/16"
    # get vnet for future reference
    $vnet_pg_sandbox = Get-AzVirtualNetwork -Name 'vnet-pg-sandbox' -ResourceGroupName 'rg-pg-sandbox-network'
    $vnet_pg_sandbox|Set-AzVirtualNetwork
#
# create rg-pg-sandbox-1 RG - SQL Server Serverless 
#
$rg='rg-pg-sandbox-1'  
New-AzResourceGroup -Location $location -Name $rg 

    # add subnet for resource group
    $nsg = New-AzNetworkSecurityGroup -ResourceGroupName $rg -Location $location -Name "nsg-pg-sandbox-1" 
    Add-AzVirtualNetworkSubnetConfig -Name "snet-pg-sandbox-1" -VirtualNetwork $vnet_pg_sandbox -AddressPrefix "10.81.1.0/24" -NetworkSecurityGroup $nsg
    #Add-AzVirtualNetworkSubnetConfig -Name "snet-pg-sandbox-1" -VirtualNetwork $vnet_pg_sandbox -AddressPrefix "10.81.1.0/24" 
    # activate
    $vnet_pg_sandbox|Set-AzVirtualNetwork

    # get random number
    $r=random

    # create sql server instance (admin un/pw sqlsandbox1/Pa$$w0rdPa$$w0rd)
    New-AzSqlServer -ResourceGroupName $rg -Location $location -ServerName "sql-$rg-$r" -ServerVersion "12.0" -SqlAdministratorCredentials (Get-Credential)
    # create sql server database
    New-AzSqlDatabase -ResourceGroupName $rg -ServerName "sql-$rg-$r" -DatabaseName "db-$rg-$(random)" -Edition "GeneralPurpose" -Vcore 2 -ComputeGeneration "Gen5" -ComputeModel Serverless

#
# create rg-pg-sandbox-2 RG - SQL Server Elastic Pool
#
$rg='rg-pg-sandbox-2'  
New-AzResourceGroup -Location $location -Name $rg 

    # add subnet for resource group
    $nsg = New-AzNetworkSecurityGroup -ResourceGroupName $rg -Location $location -Name "nsg-pg-sandbox-2" 
    Add-AzVirtualNetworkSubnetConfig -Name "snet-pg-sandbox-2" -VirtualNetwork $vnet_pg_sandbox -AddressPrefix "10.81.2.0/24" -NetworkSecurityGroup $nsg
    #Add-AzVirtualNetworkSubnetConfig -Name "snet-pg-sandbox-2" -VirtualNetwork $vnet_pg_sandbox -AddressPrefix "10.81.2.0/24"
    # activate
    $vnet_pg_sandbox|Set-AzVirtualNetwork

    # get random number
    $r=random

    # create sql server instance (admin un/pw sqlsandbox2/Pa$$w0rdPa$$w0rd)
    New-AzSqlServer -ResourceGroupName $rg -Location $location -ServerName "sql-$rg-$r" -ServerVersion "12.0" -SqlAdministratorCredentials (Get-Credential)
    # create sql server elastic pool
    New-AzSqlElasticPool -ElasticPoolName "sqlp-sandbox-2" -ResourceGroupName $rg -ServerName "sql-$rg-$r" 
    #New-AzSqlElasticPool -ElasticPoolName "sqlp-sandbox-2" -ResourceGroupName $rg -ServerName "sql-$rg-$r" -Edition "Standard" -Dtu 10 -DatabaseDtuMin 2 -DatabaseDtuMax 10

    # Declare an array to store db names:
    $databasename = @("DB1", "DB2", "DB3", "DB4", "DB5", "DB6")
    # Loop to create automatic multiple database as per requirement:
    For ($i=0; $i -lt $databasename.Length; $i++) 
        {
        $resourcegroupname = $rg 
        $location = $location        
        $servername = "sql-$rg-$r"

        # check if database exists
        $azuresqldb= Get-AzSqlDatabase -ResourceGroupName $resourcegroupname -ServerName $servername -DatabaseName $databasename[$i] -ErrorAction SilentlyContinue
           
        if ( -not $azuresqldb )
            {
               "Creating Azure SQL Database " + $databasename[$i] + " in Server Name sql-rg-pg-sandbox-2-5874"
                New-AzSqlDatabase -ResourceGroupName $resourcegroupname -ServerName $servername -DatabaseName $databasename[$i] -ElasticPoolName "sqlp-sandbox-2"
            }
            else
            {
                "Azure SQL Database already exists " + $databasename[$i] 
            }
        }

#
# create rg-pg-sandbox-3 RG - SQL Server - Single database
#
$rg='rg-pg-sandbox-3'  
New-AzResourceGroup -Location $location -Name $rg 

    # add subnet for resource group
    $nsg = New-AzNetworkSecurityGroup -ResourceGroupName $rg -Location $location -Name "nsg-pg-sandbox-3" 
    Add-AzVirtualNetworkSubnetConfig -Name "snet-pg-sandbox-3" -VirtualNetwork $vnet_pg_sandbox -AddressPrefix "10.81.3.0/24" -NetworkSecurityGroup $nsg
    # activate
    $vnet_pg_sandbox|Set-AzVirtualNetwork

    # get random number
    $r=random

    # create sql server instance (admin un/pw sqlsandbox3/Pa$$w0rdPa$$w0rd)
    New-AzSqlServer -ResourceGroupName $rg -Location $location -ServerName "sql-$rg-$r" -ServerVersion "12.0" -SqlAdministratorCredentials (Get-Credential)

    New-AzSqlDatabase -ResourceGroupName $rg -ServerName "sql-$rg-$r" -DatabaseName "db-$rg-$(random)" -Edition "GeneralPurpose" -Vcore 2 -ComputeGeneration "Gen5" 

#
# create rg-pg-sandbox-4 RG - SQL Server  
#
$rg='rg-pg-sandbox-4'  
New-AzResourceGroup -Location $location -Name $rg 

    # add subnet for resource group
    $nsg = New-AzNetworkSecurityGroup -ResourceGroupName $rg -Location $location -Name "nsg-pg-sandbox-4" 
    Add-AzVirtualNetworkSubnetConfig -Name "snet-pg-sandbox-4" -VirtualNetwork $vnet_pg_sandbox -AddressPrefix "10.81.4.0/24" -NetworkSecurityGroup $nsg
    # activate
    $vnet_pg_sandbox|Set-AzVirtualNetwork

    # get random number
    $r=random

    #Set the managed instance name for the new managed instance
$instanceName = "sql-$rg-$r"
# Set the admin login and password for your managed instance
$miAdminSqlLogin = "SqlAdmin"
$miAdminSqlPassword = "ChangeYourAdminPassword1"
# Set the managed instance service tier, compute level, and license mode
$edition = "General Purpose"
$vCores = 8
$maxStorage = 256
$computeGeneration = "Gen5"
$license = "LicenseIncluded" #"BasePrice" or LicenseIncluded if you have don't have SQL Server licence that can be used for AHB discount

# Create credentials
$secpassword = ConvertTo-SecureString $miAdminSqlPassword -AsPlainText -Force
$credential = New-Object System.Management.Automation.PSCredential ($miAdminSqlLogin, $secpassword)

$subnet = Get-AzVirtualNetworkSubnetConfig -Name snet-pg-sandbox-4 -VirtualNetwork $vnet_pg_sandbox
$miSubnetConfigId = $subnet.Id

$NSnetworkModels = "Microsoft.Azure.Commands.Network.Models"
$NScollections = "System.Collections.Generic"

# Create a delegation
$subnet.Delegations = New-Object "$NScollections.List``1[$NSnetworkModels.PSDelegation]"
$delegationName = "dgManagedInstance" + (Get-Random -Maximum 1000)
$delegation = New-AzDelegation -Name $delegationName -ServiceName "Microsoft.Sql/managedInstances"
$subnet.Delegations.Add($delegation)

$routeTableMiManagementService = New-AzRouteTable `
                      -Name 'myRouteTableMiManagementService' `
                      -ResourceGroupName $rg `
                      -location $location
Set-AzVirtualNetworkSubnetConfig -Name snet-pg-sandbox-4 -VirtualNetwork $vnet_pg_sandbox -AddressPrefix "10.81.4.0/24" -RouteTableId 'myRouteTableMiManagementService' -NetworkSecurityGroupId <String>]




# Create managed instance
New-AzSqlInstance -Name $instanceName `
                      -ResourceGroupName $rg -Location $location -SubnetId $miSubnetConfigId `
                      -AdministratorCredential $credential `
                      -StorageSizeInGB $maxStorage -VCore $vCores -Edition $edition `
                      -ComputeGeneration $computeGeneration -LicenseType $license


<#

Remove-AzResourceGroup -Name sub-pg-sandbox -force
Remove-AzResourceGroup -Name rg-pg-sandbox-network -force
Remove-AzResourceGroup -Name rg-pg-sandbox-1 -force
Remove-AzResourceGroup -Name rg-pg-sandbox-2 -force
Remove-AzResourceGroup -Name rg-pg-sandbox-3 -force
Remove-AzResourceGroup -Name rg-pg-sandbox-4 -force

#>
