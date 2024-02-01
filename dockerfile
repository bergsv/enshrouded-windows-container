# Use the Windows Server Core image
FROM mcr.microsoft.com/windows/servercore:ltsc2022

# Set the working directory
WORKDIR C:\Enshrouded

# Download and extract steamcmd.zip
ADD https://steamcdn-a.akamaihd.net/client/installer/steamcmd.zip .

RUN powershell -Command Expand-Archive -Path steamcmd.zip -DestinationPath .

# Set the entry point for the container
CMD ["cmd.exe", "/C", "cd Enshrouded && steamcmd.exe +login anonymous +app_update 2278520 +quit && start enshrouded_server.exe"]
