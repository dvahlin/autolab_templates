function CreateASrep{

function Get-ScriptDirectory {
    Split-Path -Parent $PSCommandPath
}
$scriptPath = Get-ScriptDirectory
$UserASrep = Get-ADUser -Filter * | get-random
Set-ADAccountControl "$UserASrep" -doesnotrequirepreauth $true

}
