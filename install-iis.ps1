Install-WindowsFeature Web-Server

$zip = "C:\app.zip"
$out = "C:\temp"

Invoke-WebRequest -Uri "https://github.com/santoshrayalu/azure_case_study/archive/refs/heads/main.zip" -OutFile $zip

if (Test-Path $out) {
    Remove-Item $out -Recurse -Force
}

Expand-Archive $zip -DestinationPath $out -Force

# Find correct extracted folder dynamically
$folder = Get-ChildItem $out | Where-Object { $_.PSIsContainer } | Select-Object -First 1

# DELETE default IIS page (IMPORTANT FIX)
Remove-Item "C:\inetpub\wwwroot\iisstart.htm" -Force -ErrorAction SilentlyContinue

# COPY your site
Copy-Item "$($folder.FullName)\*" "C:\inetpub\wwwroot" -Recurse -Force
