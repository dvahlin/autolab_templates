#$Computer = $env:computername
#New-ADServiceAccount -Name "Service01" -ServicePrincipalNames "MSSQLSVC/$Computer" -DNSHostName "Service01.lab.local" -Enabled $True 
#get-wmiobject win32_service -comp $Computer #| Group Startname -NoElement | Sort Count
#Get-ADServiceAccount -Filter "HostComputers -eq 'OU=Units,DC=lab,DC=local'"
#Get-WmiObject win32_service | Format-Table name, startname, startmode
#Get-ADServiceAccount -Filter "HostComputers -le 'OU=Units,DC=lab,DC=local'"
#setspn -a MSSQLSvc/sql1.lab.local lab.local\SQLSVC


# Source / credit:
# https://social.technet.microsoft.com/wiki/contents/articles/18996.active-directory-powershell-script-to-list-all-spns-used.aspx

## Manually test SPN accounts  runas.exe /u:lab.local\*****SA notepad.exe 

cls
$search = New-Object DirectoryServices.DirectorySearcher([ADSI]"")
$search.filter = "(servicePrincipalName=*)"

## You can use this to filter for OU's:
## $results = $search.Findall() | ?{ $_.path -like '*OU=whatever,DC=whatever,DC=whatever*' }
$results = $search.Findall()

foreach( $result in $results ) {
	$userEntry = $result.GetDirectoryEntry()
	Write-host "Object Name = " $userEntry.name -backgroundcolor "yellow" -foregroundcolor "black"
	Write-host "DN      =      "  $userEntry.distinguishedName
	Write-host "Object Cat. = "  $userEntry.objectCategory
	Write-host "servicePrincipalNames"

	$i=1
	foreach( $SPN in $userEntry.servicePrincipalName ) {
		Write-host "SPN(" $i ")   =      " $SPN
		$i+=1
	}
	Write-host ""
}