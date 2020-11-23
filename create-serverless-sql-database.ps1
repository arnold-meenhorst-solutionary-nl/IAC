# https://github.com/Azure/azure-powershell/blob/master/src/Sql/Sql/help/New-AzSqlDatabase.md

New-AzSqlServer -ResourceGroupName "rg-pg-ia-lz-workload-1-prd" -Location "westeurope" -ServerName "rg-pg-ia-lz-workload-1-prd" -ServerVersion "12.0" -SqlAdministratorCredentials (Get-Credential)
New-AzSqlDatabase -ResourceGroupName "rg-pg-ia-lz-workload-1-prd" -ServerName "rg-pg-ia-lz-workload-1-prd" -DatabaseName "Database04" -Edition "GeneralPurpose" -Vcore 2 -ComputeGeneration "Gen5" -ComputeModel Serverless
