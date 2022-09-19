# https://github.com/farag2/Sophia-Script-for-Windows/blob/master/sophia_script_versions.json
$Parameters = @{
    Uri = "https://raw.githubusercontent.com/farag2/Sophia-Script-for-Windows/master/sophia_script_versions.json"
}
$LatestRelease = (Invoke-RestMethod @Parameters).Sophia_Script_Windows_10_PowerShell_5_1

Write-Verbose -Message "Sophia.Script.for.Windows.10.v$LatestRelease.zip" -Verbose

New-Item -Path "Sophia Script for Windows 10 v$LatestRelease\bin" -ItemType Directory -Force

$Parameters = @{
    Path  = @("Scripts\PolicyFileEditor")
    Destination     = "Sophia Script for Windows 10 v$LatestRelease\bin"
    Recurse         = $true
    Force = $true
}
Copy-Item @Parameters

Get-ChildItem -Path "Sophia Script\Sophia Script for Windows 10" -Force | Copy-Item -Destination "Sophia Script for Windows 10 v$LatestRelease" -Recurse -Force

$Parameters = @{
    Path   = "Sophia Script for Windows 10 v$LatestRelease"
    DestinationPath  = "Sophia.Script.for.Windows.10.v$LatestRelease.zip"
    CompressionLevel = "Fastest"
    Force  = $true
}
Compress-Archive @Parameters

# Calculate hash
Get-Item -Path "Sophia.Script.for.Windows.10.v$LatestRelease.zip" -Force | ForEach-Object -Process {
    "$($_.Name)  $((Get-FileHash -LiteralPath $_.FullName -Algorithm SHA256).Hash)"
} | Add-Content -Path SHA256SUM -Encoding utf8 -Force
