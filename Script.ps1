Set-ExecutionPolicy -ExecutionPolicy Unrestricted -Force -Scope CurrentUser

New-Item -ItemType Directory -Force -Path C:\RmsCloudtestImageRequirements
if (-not (Test-Path "C:\Program Files\Microsoft\Web Platform Installer\WebpiCmd-x64.exe")) {
    Invoke-WebRequest "https://go.microsoft.com/fwlink/?LinkId=287166" -OutFile "C:\RmsCloudtestImageRequirements\WebPlatformInstaller_x64_en-US.msi";
    Start-Process msiexec.exe -Wait -ArgumentList "/i C:\RmsCloudtestImageRequirements\WebPlatformInstaller_x64_en-US.msi /quiet /qn /norestart"
}

Start-Process "C:\Program Files\Microsoft\Web Platform Installer\WebpiCmd-x64.exe" -ArgumentList '/Install', '/AcceptEula', '/SuppressReboot', '/Products:MicrosoftAzure-ServiceFabric-CoreSDK' -NoNewWindow -Wait

Remove-Item –path "C:\RmsCloudtestImageRequirements" –recurse


if (-not (Test-Path "C:\Program Files\Azure Cosmos DB Emulator\CosmosDB.Emulator.exe")) {
    Invoke-WebRequest "https://aka.ms/cosmosdb-emulator" -OutFile "C:\RmsCloudtestImageRequirements\azure-cosmosdb-emulator.msi";
    Start-Process msiexec.exe -Wait -ArgumentList "/i C:\RmsCloudtestImageRequirements\azure-cosmosdb-emulator.msi /quiet /qn /norestart"
}

if (-not (Test-Path "C:\Program Files\Azure Cosmos DB Emulator\CosmosDB.Emulator.exe")) {
    throw "Cosmos Emulator installation failed"
}
