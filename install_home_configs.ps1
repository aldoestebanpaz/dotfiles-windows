Write-Host "Copying files for the home directory..."
# Copy-item never delete extra files or folders in destination, but with -Force it will overwrite if file already exists
Copy-Item -Path ./home/** -Destination $home -Recurse -Verbose -ErrorAction SilentlyContinue
