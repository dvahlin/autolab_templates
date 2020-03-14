#
#GET ALL AFFILIATE CODES FROM ALL OUS in production
function Get-ScriptDirectory {
    Split-Path -Parent $PSCommandPath
}
$scriptPath = Get-ScriptDirectory

$TopLevelOUs = @('Stockholm', 'Sundsvall','Karlstad')
    
$StockholmSubOUs = @('HR', 'Ekonomi', 'IT', 'Kommunikation') 
    #loop before the ou name by making T#-OBJECT name as the OU
$StockholmobjectOUs = @('Accounts', 'Konsulter', 'Utveckling') 
#########################
#$skipSubOUs = @('Deprovision', 'Quarantine', 'Groups')
#########################
#$tierOUs = @('Sundsvall', 'Karlstad')
$SundsvallobjectOUS = @('Accounts', 'Konsulter')
$KarlstadobjectOUS = @('Accounts', 'Utveckling')

#Consodated list of all 3 letter codes which IAM uses. 
$3LetterCodeCSV = $scriptPath + '\3lettercodes.csv'


Set-Location c:
$dn = (Get-ADDomain).distinguishedname
#=============================================
#ROUND:1
#Create Top Level OUS
#=============================================
Write-host "Creating Tiered OU Structure" -ForegroundColor Green
$topOUCount = $TopLevelOUs.count
$x = 1
foreach ($name in $TopLevelOUs) {
    Write-Progress -Activity "Deploying OU Structure" -Status "Top Level OU Status:" -PercentComplete ($x/$topOUCount*100)
    New-ADOrganizationalUnit -Name $Name -ProtectedFromAccidentalDeletion 0
    $fulldn = "OU=" + $name + "," + $dn 
    #$toplevelouinfo = Get-ADOrganizationalUnit $fulldn
    #=====================================================================================
    #ROUND:2
    #Create First level Down Sub OUs in Privileged Access, and Provisioned Users
    #=====================================================================================
    if ($name -eq $TopLevelOUs[0]) {

        foreach ($Stockholmsubou in $StockholmSubOUs) {
            New-ADOrganizationalUnit -Name $Stockholmsubou -Path $fulldn -ProtectedFromAccidentalDeletion 0
            $Stockholmsubfulldn = "OU=" + $Stockholmsubou + "," + $fulldn
                    
            if ($Stockholmsubou -eq "Utveckling") {                          
            }     
                                 
            else {
                foreach ($StockholmobjectOU in $StockholmobjectOUs) {
                    #add name together
                    if ($Stockholmsubou -eq 'Tier 0'){$StockholmOUPrefix = "T0-"}
                    elseif ($Stockholmsubou -eq 'Tier 1'){$StockholmOUPrefix = "T1-"}
                    elseif ($Stockholmsubou -eq 'Tier 2'){$StockholmOUPrefix = "T2-"}
                    $Stockholmobjectoucombo = $StockholmOUPrefix + $Stockholmobjectou

                    New-ADOrganizationalUnit -Name $Stockholmobjectoucombo -Path $Stockholmsubfulldn -ProtectedFromAccidentalDeletion 0
                }
            }
        }
    }
    elseif ($skipSubOUs -contains $name) {
        #this skips the creation of the sub containers
    }
    elseif (($name -eq 'Tier 1') -or ($name -eq 'Tier 2')) {
        $fulldn = "OU=" + $name + "," + $dn 
        $csvlist = @()
        $csvlist = import-csv $3LetterCodeCSV

        foreach ($ou in $csvlist) {
            New-ADOrganizationalUnit -Name ($ou.name) -Path $fulldn -Description ($ou.description) -ProtectedFromAccidentalDeletion 0
            $csvdn = "OU=" + $ou.name + "," + $fulldn 
            
            foreach ($ObjectSubOU in $ObjectSubOUs) {
                New-ADOrganizationalUnit -Name $ObjectSubOU -Path $csvdn -ProtectedFromAccidentalDeletion 0
                $Objectfulldn = "OU=" + $ObjectSubOU + "," + $csvdn
            }
        }
    }

    elseif (($name -eq 'People')) {
        $fulldn = "OU=" + $name + "," + $dn 
        $csvlist = @()
        $csvlist = import-csv $3LetterCodeCSV
        


        foreach ($ou in $csvlist) {
            New-ADOrganizationalUnit -Name ($ou.name) -Path $fulldn -Description ($ou.description) -ProtectedFromAccidentalDeletion 0
            $csvdn = "OU=" + $ou.name + "," + $fulldn 
            
        }
       #Create Two Sub OUs in People OU required for IDM provisioning 
        New-ADOrganizationalUnit -Name 'Deprovisioned' -Path $fulldn -Description 'User account that have been deprovisioned by the IDM System' -ProtectedFromAccidentalDeletion 0
        New-ADOrganizationalUnit -Name 'Unassociated' -Path $fulldn -Description 'User Object that do have have any department affliation' -ProtectedFromAccidentalDeletion 0
   }
    
    else {}
    $x++
}
    





