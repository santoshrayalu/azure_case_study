# Install IIS
Install-WindowsFeature Web-Server,Web-CGI

# Create temp folder
New-Item -ItemType Directory -Force -Path C:\temp

# -----------------------------
# INSTALL PHP
# -----------------------------

# Download PHP
Invoke-WebRequest `
  -Uri "https://windows.php.net/downloads/releases/php-8.2.28-nts-Win32-vs16-x64.zip" `
  -OutFile "C:\temp\php.zip"

# Extract PHP
Expand-Archive "C:\temp\php.zip" -DestinationPath "C:\PHP" -Force

# Configure php.ini
Copy-Item "C:\PHP\php.ini-production" "C:\PHP\php.ini"

# -----------------------------
# CONFIGURE IIS FOR PHP
# -----------------------------

Import-Module WebAdministration

# Add FastCGI
New-WebHandler `
  -Name "PHP-FastCGI" `
  -Path "*.php" `
  -Verb "*" `
  -Modules "FastCgiModule" `
  -ScriptProcessor "C:\PHP\php-cgi.exe" `
  -ResourceType Either

# Add index.php as default document
Add-WebConfigurationProperty `
  -pspath 'MACHINE/WEBROOT/APPHOST' `
  -filter "system.webServer/defaultDocument/files" `
  -name "." `
  -value @{value='index.php'}

# -----------------------------
# DEPLOY WEBSITE
# -----------------------------

Invoke-WebRequest `
  -Uri "https://github.com/santoshrayalu/azure_case_study/archive/refs/heads/main.zip" `
  -OutFile "C:\temp\site.zip"

Expand-Archive `
  "C:\temp\site.zip" `
  -DestinationPath "C:\temp\site" `
  -Force

# Get extracted folder
$folder = Get-ChildItem "C:\temp\site" |
Where-Object {$_.PSIsContainer} |
Select-Object -First 1

# Clean IIS root
Remove-Item "C:\inetpub\wwwroot\*" -Recurse -Force -ErrorAction SilentlyContinue

# Copy app
Copy-Item "$($folder.FullName)\*" "C:\inetpub\wwwroot" -Recurse -Force

# Restart IIS
iisreset
