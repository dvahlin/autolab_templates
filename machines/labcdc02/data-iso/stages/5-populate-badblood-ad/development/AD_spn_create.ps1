function Get-ScriptDirectory {
    Split-Path -Parent $PSCommandPath
}
$scriptPath = Get-ScriptDirectory
#Add-KdsRootKey –EffectiveTime ((get-date).addhours(-10))
$newPwd = ConvertTo-SecureString -AsPlainText 'Labbverksamheten2018' -Force 
#$Computer = $env:computername
$SPNvalue = get-content($scriptPath + '\spns.txt')|get-random
#If chance is against us
$SPNeq = Get-AdUser -Filter * | where-Object {$_.Name -like '*SA' -and $_.Enabled -eq $False} | Sort-Object{Get-Random} | Select -First 1
# Create random SPN accounts
$SPNaccount = Get-AdUser -Filter * | where-Object {$_.Name -like '*SA' -and $_.Enabled -eq 'True'} | Sort-Object{Get-Random} | Select -First 1
Set-ADUser -Identity "$SPNaccount" -ServicePrincipalNames @{Add=$SPNValue}
Set-ADAccountPassword -Identity "$SPNaccount" -Reset -NewPassword $newPwd