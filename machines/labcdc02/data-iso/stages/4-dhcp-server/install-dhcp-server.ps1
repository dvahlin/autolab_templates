Add-WindowsFeature -IncludeManagementTools dhcp

do {
    Start-Sleep 1
    Add-DhcpServerInDC
} until($?)

Add-DhcpServerSecurityGroup
Restart-Service dhcpserver

Add-DhcpServerv4Scope -Name "SE Stockholm" -StartRange 192.0.2.100 -EndRange 192.0.2.199 -SubnetMask 255.255.255.0
Set-DhcpServerv4OptionValue -OptionId 3 -value 192.0.2.1
Set-DhcpServerv4OptionValue -OptionId 6 -value 192.0.2.11

Set-ItemProperty -Path registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\ServerManager\Roles\12 -Name ConfigurationState -Value 2
