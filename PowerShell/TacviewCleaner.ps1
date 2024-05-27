$standard_limit = (Get-Date).AddDays(-7)

$path1 = "G:\My Drive\Tacviews\TS1"
$path2 = "G:\My Drive\Tacviews\TS2"
$path3 = "G:\My Drive\Tacviews\TS3"

$path4 = "C:\Users\DCSGameStaff\Documents\Tacview\Tactical_Realism_1"
$path5 = "C:\Users\DCSGameStaff\Documents\Tacview\Tactical_Realism_2"


# Delete files older than the $limit.
Get-ChildItem -Path $path1 -Recurse -Force | Where-Object { !$_.PSIsContainer -and $_.CreationTime -lt $standard_limit } | Remove-Item -Force
Get-ChildItem -Path $path2 -Recurse -Force | Where-Object { !$_.PSIsContainer -and $_.CreationTime -lt $standard_limit } | Remove-Item -Force
Get-ChildItem -Path $path3 -Recurse -Force | Where-Object { !$_.PSIsContainer -and $_.CreationTime -lt $standard_limit } | Remove-Item -Force
Get-ChildItem -Path $path4 -Recurse -Force | Where-Object { !$_.PSIsContainer -and $_.CreationTime -lt $standard_limit } | Remove-Item -Force
Get-ChildItem -Path $path5 -Recurse -Force | Where-Object { !$_.PSIsContainer -and $_.CreationTime -lt $standard_limit } | Remove-Item -Force


$operation_limit = (Get-Date).AddDays(-30)
$path6 = "C:\Users\DCSGameStaff\Documents\Tacview\Operation_Server"

# Delete files older than the $limit.
Get-ChildItem -Path $path6 -Recurse -Force | Where-Object { !$_.PSIsContainer -and $_.CreationTime -lt $operation_limit } | Remove-Item -Force