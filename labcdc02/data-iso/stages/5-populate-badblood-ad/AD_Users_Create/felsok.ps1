    write-host "Creating Users on Domain" -ForegroundColor Green
    $NumOfUsers = 10..20|Get-random #this number is the random number of users to create on a domain.  Todo: Make process createusers.ps1 in a parallel loop
    $X=1
    Write-Progress -Activity "Random Stuff into A domain - Creating Users" -Status "Progress:" -PercentComplete ($i/$totalscripts*100)
    $I++
    .($basescriptPath + '\AD_Users_Create\CreateUsers.ps1')
    do{createuser
        Write-Progress -Activity "Random Stuff into A domain - Creating $NumOfUsers Users" -Status "Progress:" -PercentComplete ($x/$NumOfUsers*100)
    $x++
    }while($x -lt $NumOfUsers)