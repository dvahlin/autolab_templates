<#
    .Synopsis
       Generates users, groups, OUs, computers in an active directory domain.  Then places ACLs on random OUs
    .DESCRIPTION
       This tool is for research purposes and training only.  Intended only for personal use.  This adds a large number of objects into a domain, and should never be  run in production.
    .EXAMPLE
       There are currently no parameters for the tool.  Simply run the ps1 as a DA and it begins. Follow the prompts and type 'badblood' when appropriate and the tool runs.
    .OUTPUTS
       [String]
    .NOTES
       Written by David Rowe, Blog secframe.com/blog
       Twitter : @davidprowe
       I take no responsibility for any issues caused by this script.  I am not responsible if this gets run in a production domain.  
    .FUNCTIONALITY
       Adds a ton of stuff into a domain.  Adds Users, Groups, OUs, Computers, and a vast amount of ACLs in a domain.
    .LINK
       http://www.secframe.com/badblood
   
    #>

function Get-ScriptDirectory {
    Split-Path -Parent $PSCommandPath
}
$basescriptPath = Get-ScriptDirectory
$totalscripts = 9

$i = 0
cls
#write-host "Welcome to BadBlood"
#Write-Host  'Press any key to continue...';
#write-host "`n"
#$null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown');
#write-host "The first tool that absolutely mucks up your TEST domain"
#write-host "This tool is never meant for production and can totally screw up your domain"
#Write-Host  'Press any key to continue...';
#write-host "`n"
#$null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown');
#Write-Host  'Press any key to continue...';
#write-host "You are responsible for how you use this tool. It is intended for personal use only"
#write-host "This is not intended for commercial use"
#write-host "`n"
#$null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown');
#write-host "`n"
#$badblood = Read-Host -Prompt "Type `'data`' to deploy some randomness into a domain"
#$badblood.tolower()
#if($badblood -ne 'data'){exit}
#if($badblood -eq 'data'){

    Write-Progress -Activity "Random Stuff into A domain" -Status "Progress:" -PercentComplete ($i/$totalscripts*100)


    .($basescriptPath + '\AD_LAPS_Install\InstallLAPSSchema.ps1')
    Write-Progress -Activity "Random Stuff into A domain: Install LAPS" -Status "Progress:" -PercentComplete ($i/$totalscripts*100)
    $I++
    .($basescriptPath + '\AD_OU_CreateStructure\CreateOUStructure.ps1')
    Write-Progress -Activity "Random Stuff into A domain - Creating OUs" -Status "Progress:" -PercentComplete ($i/$totalscripts*100)
    $I++
    
    write-host "Creating Users on Domain" -ForegroundColor Green
    $NumOfUsers = 300..500|Get-random #this number is the random number of users to create on a domain.  Todo: Make process createusers.ps1 in a parallel loop
    $X=1
    Write-Progress -Activity "Random Stuff into A domain - Creating Users" -Status "Progress:" -PercentComplete ($i/$totalscripts*100)
    $I++
    .($basescriptPath + '\AD_Users_Create\CreateUsers.ps1')
    do{createuser
        Write-Progress -Activity "Random Stuff into A domain - Creating $NumOfUsers Users" -Status "Progress:" -PercentComplete ($x/$NumOfUsers*100)
    $x++
    }while($x -lt $NumOfUsers)
    
    write-host "Creating Groups on Domain" -ForegroundColor Green
    $NumOfGroups = 100..200|Get-random 
    $X=1
    Write-Progress -Activity "Random Stuff into A domain - Creating $NumOfGroups Groups" -Status "Progress:" -PercentComplete ($i/$totalscripts*100)
    $I++
    .($basescriptPath + '\AD_Groups_Create\CreateGroups.ps1')
    
    do{
        Creategroup
        Write-Progress -Activity "Random Stuff into A domain - Creating $NumOfGroups Groups" -Status "Progress:" -PercentComplete ($x/$NumOfGroups*100)
    
    $x++
    }while($x -lt $NumOfGroups)
    
    write-host "Creating Computers on Domain" -ForegroundColor Green
    $NumOfComps = 5..40|Get-random 
    $X=1
    Write-Progress -Activity "Random Stuff into A domain - Creating Computers" -Status "Progress:" -PercentComplete ($i/$totalscripts*100)
    .($basescriptPath + '\AD_Computers_Create\CreateComputers.ps1')
    $I++
    do{
        Write-Progress -Activity "Random Stuff into A domain - Creating $NumOfComps computers" -Status "Progress:" -PercentComplete ($x/$NumOfComps*100)
        createcomputer
    $x++
    }while($x -lt $NumOfComps)

    $I++
    write-host "Creating Permissions on Domain" -ForegroundColor Green
    .($basescriptPath + '\AD_Permissions_Randomizer\GenerateRandomPermissions.ps1')
    Write-Progress -Activity "Random Stuff into A domain - Creating OUs" -Status "Progress:" -PercentComplete ($i/$totalscripts*100)
    
    $I++
    write-host "Nesting objects into groups on Domain" -ForegroundColor Green
    .($basescriptPath + '\AD_Groups_Create\AddRandomToGroups.ps1')
    Write-Progress -Activity "Random Stuff into A domain - Adding Stuff to Stuff and Things" -Status "Progress:" -PercentComplete ($i/$totalscripts*100)
#}
    write-host "Creating SPN Accounts" -ForegroundColor Green
    $NumOfSPN = 5..10|Get-random 
    $X=1
    $I++
    Write-Progress -Activity "Random Stuff into A domain - Creating SPN Accounts" -Status "Progress:" -PercentComplete ($i/$totalscripts*100)
    .($basescriptPath + '\AD_SPN_Create\createspn.ps1')
        do{
        Write-Progress -Activity "Random Stuff into A domain - Creating $NumOfSPN SPN Accounts" -Status "Progress:" -PercentComplete ($x/$NumOfSPN*100)
        CreateSPN
    $x++
    }while($x -lt $NumOfSPN)

        write-host "Maybe Creating AS-REP Accounts" -ForegroundColor Green
    $NumOfASrep = 0..5|Get-random 
    $X=1
    $I++
    Write-Progress -Activity "Random Stuff into A domain - Maybe Creating AS-REP Accounts" -Status "Progress:" -PercentComplete ($i/$totalscripts*100)
    .($basescriptPath + '\AD_ASrep_Create\AD_asrep_create.ps1')
        do{
        Write-Progress -Activity "Random Stuff into A domain - Creating $NumOfASrep AS-REP Accounts" -Status "Progress:" -PercentComplete ($x/$NumOfASrep*100)
        CreateASrep
    $x++
    }while($x -lt $NumOfASrep)
