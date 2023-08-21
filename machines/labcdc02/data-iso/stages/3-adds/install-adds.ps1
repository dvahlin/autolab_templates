Install-WindowsFeature -name AD-Domain-Services -IncludeManagementTools
Import-Module ADDSDeployment
Install-ADDSForest -CreateDnsDelegation:$false -DatabasePath "C:\Windows\NTDS" -DomainMode "Win2012R2" -DomainName "lab.local" -DomainNetbiosName "LAB" -ForestMode "Win2012R2" -InstallDns:$true -LogPath "C:\Windows\NTDS" -NoRebootOnCompletion:$false -SysvolPath "C:\Windows\SYSVOL" -SafeModeAdministratorPassword (convertto-securestring "Pass@word01" -asplaintext -force) -Force:$true
Set-DnsServerForwarder -IPAddress 8.8.8.8,8.8.4.4 -UseRootHint 1
