Install-WindowsFeature Web-Server

$zip = "C:\app.zip"
$out = "C:\temp"

Invoke-WebRequest -Uri "https://github.com/santoshrayalu/azure_case_study/archive/refs/heads/main.zip" -OutFile $zip

if (Test-Path $out) {
    Remove-Item $out -Recurse -Force
}

Expand-Archive $zip -DestinationPath $out -Force

Copy-Item C:\temp\azure_case_study-main\* C:\inetpub\wwwroot -Recurse -Force
