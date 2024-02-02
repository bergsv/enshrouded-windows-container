# entrypoint.ps1

# Read the content of the enshrouded_server.json file
$ConfigPath = "enshrouded_server.json"
$ConfigContent = Get-Content -Raw -Path $ConfigPath | ConvertFrom-Json

# Update the values in the Config File
$ConfigContent.name = $env:name
$ConfigContent.password = $env:password
$ConfigContent.slotCount = $env:slots

# Save the modified Config File
$ConfigContent | ConvertTo-Json | Set-Content -Path $ConfigPath

# Start the Enshrouded Server
.\enshrouded_server.exe
