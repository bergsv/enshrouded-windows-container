######## INSTALL ########

# Set the base image
FROM mcr.microsoft.com/windows/server:ltsc2022

# Set alternative shell
SHELL ["powershell"]

# Set environment variables
ENV POWERSHELL_TELEMETRY_OPTOUT 1
ENV HOME "c:\steamcmd"

# Create system user
RUN New-LocalUser -Name "steamcmd" -NoPassword -AccountNeverExpires -UserMayNotChangePassword | Set-LocalUser -PasswordNeverExpires $true

# Switch to user
USER steamcmd

# Create SteamCMD directory
RUN New-Item -ItemType Directory "c:\steamcmd"

# Set SteamCMD working directory
WORKDIR $HOME

# Download and unpack SteamCMD archive
RUN Invoke-WebRequest http://media.steampowered.com/installer/steamcmd.zip -O c:\steamcmd\steamcmd.zip; \
    Expand-Archive c:\steamcmd\steamcmd.zip -DestinationPath c:\steamcmd; \
    Remove-Item c:\steamcmd\steamcmd.zip

# Update SteamCMD
RUN c:\steamcmd\steamcmd.exe +quit; exit 0

# Install Enshrouded Server
RUN c:\steamcmd\steamcmd.exe +login anonymous +app_update 2278520 +quit; exit 0

# Change to Enshrouded Server Directory
WORKDIR "c:\steamcmd\steamapps\common\EnshroudedServer"

COPY enshrouded_server.json .

# Create entrypoint script
COPY entrypoint.ps1 .

# Set the entrypoint
ENTRYPOINT .\entrypoint.ps1