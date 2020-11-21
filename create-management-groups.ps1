# Level 1
New-AzManagementGroup -GroupName 'mg-pg'

  # Level 2
  $parentGroup = Get-AzManagementGroup -GroupName mg-pg
  New-AzManagementGroup -GroupName 'mg-pg-platform' -ParentId $parentGroup.id
  New-AzManagementGroup -GroupName 'mg-pg-landingzones' -ParentId $parentGroup.id
  New-AzManagementGroup -GroupName 'mg-pg-sandbox' -ParentId $parentGroup.id

    # Level 3
    $parentGroup = Get-AzManagementGroup -GroupName mg-pg-platform
    New-AzManagementGroup -GroupName 'mg-pg-management' -ParentId $parentGroup.id
    New-AzManagementGroup -GroupName 'mg-pg-connectivity' -ParentId $parentGroup.id
    New-AzManagementGroup -GroupName 'mg-pg-identity' -ParentId $parentGroup.id

    $parentGroup = Get-AzManagementGroup -GroupName mg-pg-landingzones
    New-AzManagementGroup -GroupName 'mg-pg-ia' -ParentId $parentGroup.id
    New-AzManagementGroup -GroupName 'mg-pg-delegated' -ParentId $parentGroup.id

      # level 4 landingzones
      $parentGroup = Get-AzManagementGroup -GroupName mg-pg-ia
      New-AzManagementGroup -GroupName 'mg-pg-ia-data-devtst' -ParentId $parentGroup.id
      New-AzManagementGroup -GroupName 'mg-pg-ia-data-accprd' -ParentId $parentGroup.id
      New-AzManagementGroup -GroupName 'mg-pg-ia-devtst' -ParentId $parentGroup.id
      New-AzManagementGroup -GroupName 'mg-pg-ia-accprd' -ParentId $parentGroup.id
  
      $parentGroup = Get-AzManagementGroup -GroupName mg-pg-sandbox
      New-AzManagementGroup -GroupName 'mg-pg-sandbox-1' -ParentId $parentGroup.id
