Install-WindowsFeature Web-Server

$zip = "C:\app.zip"
$out = "C:\temp"

Invoke-WebRequest -Uri "https://github.com/santoshrayalu/azure_case_study/archive/refs/heads/main.zip" -OutFile $zip

if (Test-Path $out) {
    Remove-Item $out -Recurse -Force
}

Expand-Archive $zip -DestinationPath $out -Force

# Correct folder
$folder = Get-ChildItem $out | Where-Object { $_.PSIsContainer } | Select-Object -First 1

# REMOVE default IIS page
Remove-Item "C:\inetpub\wwwroot\iisstart.htm" -Force -ErrorAction SilentlyContinue
Remove-Item "C:\inetpub\wwwroot\index.html" -Force -ErrorAction SilentlyContinue

# COPY correct content
Copy-Item "$($folder.FullName)\*" "C:\inetpub\wwwroot\" -Recurse -Force

# Restart IIS
iisreset
