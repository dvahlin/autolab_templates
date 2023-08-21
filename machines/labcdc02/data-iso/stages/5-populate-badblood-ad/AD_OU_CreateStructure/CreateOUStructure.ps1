New-ADOrganizationalUnit -Name "Units" -ProtectedFromAccidentalDeletion 0
New-ADOrganizationalUnit -Name "Labbverksamheten" -Path "OU=Units,DC=lab,DC=local" -ProtectedFromAccidentalDeletion 0

$location = "Stockholm"
New-ADOrganizationalUnit -Name $location -Path "OU=Labbverksamheten,OU=Units,DC=lab,DC=local" -ProtectedFromAccidentalDeletion 0
New-ADOrganizationalUnit -Name "Users" -Path "OU=$location,OU=Labbverksamheten,OU=Units,DC=lab,DC=local" -ProtectedFromAccidentalDeletion 0
New-ADOrganizationalUnit -Name "Groups" -Path "OU=$location,OU=Labbverksamheten,OU=Units,DC=lab,DC=local" -ProtectedFromAccidentalDeletion 0
New-ADOrganizationalUnit -Name "Computers" -Path "OU=$location,OU=Labbverksamheten,OU=Units,DC=lab,DC=local" -ProtectedFromAccidentalDeletion 0
New-ADOrganizationalUnit -Name "Servers" -Path "OU=$location,OU=Labbverksamheten,OU=Units,DC=lab,DC=local" -ProtectedFromAccidentalDeletion 0

$location = "Göteborg"
New-ADOrganizationalUnit -Name $location -Path "OU=Labbverksamheten,OU=Units,DC=lab,DC=local" -ProtectedFromAccidentalDeletion 0
New-ADOrganizationalUnit -Name "Users" -Path "OU=$location,OU=Labbverksamheten,OU=Units,DC=lab,DC=local" -ProtectedFromAccidentalDeletion 0
New-ADOrganizationalUnit -Name "Groups" -Path "OU=$location,OU=Labbverksamheten,OU=Units,DC=lab,DC=local" -ProtectedFromAccidentalDeletion 0
New-ADOrganizationalUnit -Name "Computers" -Path "OU=$location,OU=Labbverksamheten,OU=Units,DC=lab,DC=local" -ProtectedFromAccidentalDeletion 0
New-ADOrganizationalUnit -Name "Servers" -Path "OU=$location,OU=Labbverksamheten,OU=Units,DC=lab,DC=local" -ProtectedFromAccidentalDeletion 0

$location = "Malmö"
New-ADOrganizationalUnit -Name $location -Path "OU=Labbverksamheten,OU=Units,DC=lab,DC=local" -ProtectedFromAccidentalDeletion 0
New-ADOrganizationalUnit -Name "Users" -Path "OU=$location,OU=Labbverksamheten,OU=Units,DC=lab,DC=local" -ProtectedFromAccidentalDeletion 0
New-ADOrganizationalUnit -Name "Groups" -Path "OU=$location,OU=Labbverksamheten,OU=Units,DC=lab,DC=local" -ProtectedFromAccidentalDeletion 0
New-ADOrganizationalUnit -Name "Computers" -Path "OU=$location,OU=Labbverksamheten,OU=Units,DC=lab,DC=local" -ProtectedFromAccidentalDeletion 0
New-ADOrganizationalUnit -Name "Servers" -Path "OU=$location,OU=Labbverksamheten,OU=Units,DC=lab,DC=local" -ProtectedFromAccidentalDeletion 0