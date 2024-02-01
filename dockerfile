# Use the Windows Server Core image
FROM mcr.microsoft.com/windows/servercore:ltsc2022

# Set the working directory
WORKDIR C:\\Enshrouded

# Copy the Enshrouded 
COPY update_ensh_ds.txt C:\\Enshrouded\\update_ensh_ds.txt

# Download, Extract steamcmd and Update Enshrouded Data Files
ADD https://steamcdn-a.akamaihd.net/client/installer/steamcmd.zip .
RUN powershell -Command Expand-Archive -Path steamcmd.zip -DestinationPath .

# Start Enshrouded 
CMD ["C:\\Enshrouded\\steamcmd.exe", "+runscript", "update_ensh_ds.txt", "&", "C:\\Enshrouded\\steamapps\\common\\EnshroudedServer\\EnshroudedServer.exe"]
