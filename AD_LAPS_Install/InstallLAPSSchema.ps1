try {
    Import-Module LAPS -ErrorAction Stop
}
catch {
    Write-Host -ForegroundColor Red "ERROR: The LAPS PowerShell module is not available."
    throw "LAPS module not found. Cannot continue."
}

try {
    Update-LapsADSchema -ErrorAction Stop
    Write-Host -ForegroundColor Green "INFORMATION: Windows LAPS schema updated successfully."
}
catch {
    Write-Host -ForegroundColor Red "ERROR: Failed to update Windows LAPS schema. Error: $_"
    throw
}

try {
    $domainDN = (Get-ADDomain).DistinguishedName
    Set-LapsADComputerSelfPermission -Identity $domainDN -ErrorAction Stop
    Write-Host -ForegroundColor Green "INFORMATION: Windows LAPS computer self-permission set on $domainDN."
}
catch {
    Write-Host -ForegroundColor Red "ERROR: Failed to set LAPS computer self-permission. Error: $_"
    throw
}