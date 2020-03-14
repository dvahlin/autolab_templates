do {
    Start-Sleep 1
    New-ADUser -SAMAccountName "test" -GivenName "Test" -Surname "User" -Name "Test User" -DisplayName "Test User" -Enabled 0 -AccountPassword (ConvertTo-SecureString "Pass@word01" -AsPlainText -Force)
} until($?)

New-ADUser -SAMAccountName "user1" -GivenName "User" -Surname "1" -Name "User 1" -DisplayName "User 1" -Description "LAB User 1" -Enabled 1 -PasswordNeverExpires 1 -AccountPassword (ConvertTo-SecureString "Pass@word01" -AsPlainText -Force)
New-ADUser -SAMAccountName "user2" -GivenName "User" -Surname "2" -Name "User 2" -DisplayName "User 2" -Description "LAB User 2" -Enabled 1 -PasswordNeverExpires 1 -AccountPassword (ConvertTo-SecureString "Pass@word01" -AsPlainText -Force)
