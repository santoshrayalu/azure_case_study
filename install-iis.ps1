Install-WindowsFeature Web-Server

$zip = "C:\app.zip"
$out = "C:\temp"

Invoke-WebRequest -Uri "https://github.com/santoshrayalu/azure_case_study/archive/refs/heads/main.zip" -OutFile $zip

if (Test-Path $out) {
    Remove-Item $out -Recurse -Force
}

Expand-Archive $zip -DestinationPath $out -Force

# Find correct extracted folder dynamically
$folder = Get-ChildItem "C:\temp" | Where-Object { $_.PSIsContainer -eq $true } | Select-Object -First 1

Copy-Item "$($folder.FullName)\*" "C:\inetpub\wwwroot" -Recurse -Force
