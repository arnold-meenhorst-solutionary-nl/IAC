# https://github.com/Azure/azure-powershell/blob/master/src/Sql/Sql/help/New-AzSqlDatabase.md

$location='westeurope'
$resourcegroup = 'rg-pg-sandbox-1'
get-date
New-AzSqlServer -ResourceGroupName $resourcegroup -Location "westeurope" -ServerName "sql-rg-pg-sandbox-1" -ServerVersion "12.0" -SqlAdministratorCredentials (Get-Credential)
get-date
New-AzSqlDatabase -ResourceGroupName $resourcegroup -ServerName "sql-rg-pg-sandbox-1" -DatabaseName "sql-rg-pg-sandbox-1" -Edition "GeneralPurpose" -Vcore 2 -ComputeGeneration "Gen5" -ComputeModel Serverless
get-date