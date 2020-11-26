# global default location
$location='westeurope'

# wrapper to generate random 4 digit number 

function random {
   Write-Output $(Get-Random -Maximum 10000)
}