$wmi = Get-WmiObject win32_networkadapterconfiguration -filter "ipenabled = 'true'"
$wmi.EnableStatic("192.0.2.11", "255.255.255.0")
$wmi.SetGateways("192.0.2.1", 1)
$wmi.SetDNSServerSearchOrder("192.0.2.11")
