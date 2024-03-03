Param($vmResourceId)

Connect-AzAccount -Identity

Select-AzSubscription -SubscriptionId $($vmResourceId.Split("/")[2])

$details = Get-AzVM -ResourceId $vmResourceId | Select-Object Location, Zones

if ($null -ne $details.Zones) {
    $physicalZone = ((((Invoke-AzRestMethod -Uri "https://management.azure.com/subscriptions/$($vmResourceId.Split("/")[2])/locations?api-version=2022-12-01").Content | ConvertFrom-Json).value | Where-Object name -eq $details.Location).availabilityZoneMappings | Where-Object logicalZone -eq $details.Zones).physicalZone
}
else {
    $physicalZone = "No Zone Assigned"
}

Update-AzTag -ResourceId $vmResourceId -Tag @{PhysicalZone = $physicalZone } -Operation Merge