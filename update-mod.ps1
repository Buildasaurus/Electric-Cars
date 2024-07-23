# Define paths
$sourceDirectory = "C:\GithubRepositories\Electric-Cars\electric-cars_0.0.0"
$zipFilePath = "C:\Users\jonat\AppData\Roaming\Factorio\mods\electric-cars_0.0.0.zip"
$factorioUrlPath = "C:\Users\jonat\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Steam\Factorio.url"

# Function to create or overwrite the zip file with the top-level folder
function Zip-DirectoryWithFolder {
    param (
        [string]$sourceDir,
        [string]$zipPath
    )

    # Ensure the source directory exists
    if (-Not (Test-Path $sourceDir)) {
        Write-Error "Source directory does not exist: $sourceDir"
        return
    }

    # Extract folder name from the source directory path
    $folderName = [System.IO.Path]::GetFileName($sourceDir)

    # Create a temporary folder to hold the folder structure for zipping
    $tempDir = [System.IO.Path]::GetTempPath()
    $tempDir = Join-Path -Path $tempDir -ChildPath "zipContent"

    if (Test-Path $tempDir) {
        Remove-Item -Path $tempDir -Recurse -Force
    }

    New-Item -Path $tempDir -ItemType Directory | Out-Null

    # Create the folder inside the temporary directory
    $folderInTemp = Join-Path -Path $tempDir -ChildPath $folderName
    New-Item -Path $folderInTemp -ItemType Directory | Out-Null

    # Copy all contents of the source directory into the folder in the temporary directory
    Copy-Item -Path "$sourceDir\*" -Destination $folderInTemp -Recurse

    # Create the ZIP file from the temporary folder
    Compress-Archive -Path "$tempDir\*" -DestinationPath $zipPath -Force

    # Clean up the temporary folder
    Remove-Item -Path $tempDir -Recurse -Force
}

# Create or overwrite the zip file
Zip-DirectoryWithFolder -sourceDir $sourceDirectory -zipPath $zipFilePath

# Launch the Factorio URL
if (Test-Path $factorioUrlPath) {
    Start-Process $factorioUrlPath
} else {
    Write-Error "Factorio URL file does not exist: $factorioUrlPath"
}
