#$Credential = Get-Credential
#Connect-AzAccount -Credential $Credential -Tenant '1d63562e-af76-4885-bfa5-31c2c0e9e180'

# Level 1
New-AzManagementGroup -GroupId 'mg-pg'

# Level 2
$parentGroup = Get-AzManagementGroup -GroupId mg-pg
New-AzManagementGroup -GroupId 'mg-pg-platform' -ParentId $parentGroup.id
New-AzManagementGroup -GroupId 'mg-pg-landingzones' -ParentId $parentGroup.id
New-AzManagementGroup -GroupId 'mg-pg-sandbox' -ParentId $parentGroup.id

# Level 3
$parentGroup = Get-AzManagementGroup -GroupId mg-pg-platform
New-AzManagementGroup -GroupId 'mg-pg-management' -ParentId $parentGroup.id
New-AzManagementGroup -GroupId 'mg-pg-connectivity' -ParentId $parentGroup.id
New-AzManagementGroup -GroupId 'mg-pg-identity' -ParentId $parentGroup.id

$parentGroup = Get-AzManagementGroup -GroupId mg-pg-landingzones
New-AzManagementGroup -GroupId 'mg-pg-ia' -ParentId $parentGroup.id
New-AzManagementGroup -GroupId 'mg-pg-delegated' -ParentId $parentGroup.id

# level 4 landingzones
$parentGroup = Get-AzManagementGroup -GroupId mg-pg-ia
New-AzManagementGroup -GroupId 'mg-pg-ia-data-devtst' -ParentId $parentGroup.id
New-AzManagementGroup -GroupId 'mg-pg-ia-data-accprd' -ParentId $parentGroup.id
New-AzManagementGroup -GroupId 'mg-pg-ia-devtst' -ParentId $parentGroup.id
New-AzManagementGroup -GroupId 'mg-pg-ia-accprd' -ParentId $parentGroup.id
  
$parentGroup = Get-AzManagementGroup -GroupId mg-pg-sandbox
New-AzManagementGroup -GroupId 'mg-pg-sandbox-1' -ParentId $parentGroup.id
      