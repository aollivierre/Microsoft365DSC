#################################################################################################################################
################################################# START VARIABLES ###############################################################
#################################################################################################################################

#First, load secrets and create a credential object:
# Assuming secrets.json is in the same directory as your script
$secretsPath = Join-Path -Path $PSScriptRoot -ChildPath "secrets.json"

# Load the secrets from the JSON file
$secrets = Get-Content -Path $secretsPath -Raw | ConvertFrom-Json

# Read configuration from the JSON file
# Assign values from JSON to variables

# Read configuration from the JSON file
$configPath = Join-Path -Path $PSScriptRoot -ChildPath "config.json"
$env:MYMODULE_CONFIG_PATH = $configPath

$config = Get-Content -Path $configPath -Raw | ConvertFrom-Json

#  Variables from JSON file
$tenantId = $secrets.TenantId
$clientId = $secrets.ClientId

# $certPath = Join-Path -Path $PSScriptRoot -ChildPath 'graphcert.pfx'


# Find any PFX file in the root directory of the script
$pfxFiles = Get-ChildItem -Path $PSScriptRoot -Filter *.pfx

if ($pfxFiles.Count -eq 0) {
    Write-Error "No PFX file found in the root directory."
    throw "No PFX file found"
}
elseif ($pfxFiles.Count -gt 1) {
    Write-Error "Multiple PFX files found in the root directory. Please ensure there is only one PFX file."
    throw "Multiple PFX files found"
}

# Use the first (and presumably only) PFX file found
$certPath = $pfxFiles[0].FullName

Write-Host "PFX file found: $certPath"

$CertPassword = $secrets.CertPassword



# Now populate the connection parameters with values from the secrets file
# $connectionParams = @{
#     clientId     = $secrets.clientId
#     tenantID     = $secrets.tenantID
#     # ClientSecret = $secrets.ClientSecret
#     Clientcert = $certPath
# }

# $TenantName = $secrets.TenantName
# $site_objectid = "your group object id"
# $siteObjectId = $secrets.SiteObjectId

# $document_drive_name = "Documents"
# $document_drive_name = "Documents"
# $documentDriveName = $secrets.DocumentDriveName



# Assign values from JSON to variables
# $PackageName = $config.PackageName
# $PackageUniqueGUID = $config.PackageUniqueGUID
# $Version = $config.Version
# $PackageExecutionContext = $config.PackageExecutionContext
# $RepetitionInterval = $config.RepetitionInterval
# $ScriptMode = $config.ScriptMode


function Initialize-Environment {
    param (
        [string]$WindowsModulePath = "EnhancedBoilerPlateAO\2.0.0\EnhancedBoilerPlateAO.psm1",
        [string]$LinuxModulePath = "/usr/src/code/Modules/EnhancedBoilerPlateAO/2.0.0/EnhancedBoilerPlateAO.psm1"
    )

    function Get-Platform {
        if ($PSVersionTable.PSVersion.Major -ge 7) {
            return $PSVersionTable.Platform
        }
        else {
            return [System.Environment]::OSVersion.Platform
        }
    }

    function Setup-GlobalPaths {
        if ($env:DOCKER_ENV -eq $true) {
            $global:scriptBasePath = $env:SCRIPT_BASE_PATH
            $global:modulesBasePath = $env:MODULES_BASE_PATH
        }
        else {
            $global:scriptBasePath = $PSScriptRoot
            # $global:modulesBasePath = "$PSScriptRoot\modules"
            $global:modulesBasePath = "c:\code\modules"
        }
    }

    function Setup-WindowsEnvironment {
        # Get the base paths from the global variables
        Setup-GlobalPaths

        # Construct the paths dynamically using the base paths
        $global:modulePath = Join-Path -Path $modulesBasePath -ChildPath $WindowsModulePath
        $global:AOscriptDirectory = Join-Path -Path $scriptBasePath -ChildPath "Win32Apps-DropBox"
        $global:directoryPath = Join-Path -Path $scriptBasePath -ChildPath "Win32Apps-DropBox"
        $global:Repo_Path = $scriptBasePath
        $global:Repo_winget = "$Repo_Path\Win32Apps-DropBox"


        # Import the module using the dynamically constructed path
        Import-Module -Name $global:modulePath -Verbose -Force:$true -Global:$true

        # Log the paths to verify
        Write-Host "Module Path: $global:modulePath"
        Write-Host "Repo Path: $global:Repo_Path"
        Write-Host "Repo Winget Path: $global:Repo_winget"
    }

    function Setup-LinuxEnvironment {
        # Get the base paths from the global variables
        Setup-GlobalPaths

        # Import the module using the Linux path
        Import-Module $LinuxModulePath -Verbose

        # Convert paths from Windows to Linux format
        # $global:AOscriptDirectory = Convert-WindowsPathToLinuxPath -WindowsPath "$PSscriptroot"
        # $global:directoryPath = Convert-WindowsPathToLinuxPath -WindowsPath "$PSscriptroot\Win32Apps-DropBox"
        # $global:Repo_Path = Convert-WindowsPathToLinuxPath -WindowsPath "$PSscriptroot"
        $global:IntuneWin32App = Convert-WindowsPathToLinuxPath -WindowsPath "C:\Code\IntuneWin32App\IntuneWin32App.psm1"

        Import-Module $global:IntuneWin32App -Verbose -Global


        $global:AOscriptDirectory = "$PSscriptroot"
        $global:directoryPath = "$PSscriptroot/Win32Apps-DropBox"
        $global:Repo_Path = "$PSscriptroot"
        $global:Repo_winget = "$global:Repo_Path/Win32Apps-DropBox"
    }

    $platform = Get-Platform
    if ($platform -eq 'Win32NT' -or $platform -eq [System.PlatformID]::Win32NT) {
        Setup-WindowsEnvironment
    }
    elseif ($platform -eq 'Unix' -or $platform -eq [System.PlatformID]::Unix) {
        Setup-LinuxEnvironment
    }
    else {
        throw "Unsupported operating system"
    }
}

# Call the function to initialize the environment
Initialize-Environment


# Example usage of global variables outside the function
Write-Host "Global variables set by Initialize-Environment:"
Write-Host "scriptBasePath: $scriptBasePath"
Write-Host "modulesBasePath: $modulesBasePath"
Write-Host "modulePath: $modulePath"
Write-Host "AOscriptDirectory: $AOscriptDirectory"
Write-Host "directoryPath: $directoryPath"
Write-Host "Repo_Path: $Repo_Path"
Write-Host "Repo_winget: $Repo_winget"








#################################################################################################################################
################################################# END VARIABLES #################################################################
#################################################################################################################################

###############################################################################################################################
############################################### START MODULE LOADING ##########################################################
###############################################################################################################################

<#
.SYNOPSIS
Dot-sources all PowerShell scripts in the 'private' folder relative to the script root.

.DESCRIPTION
This function finds all PowerShell (.ps1) scripts in a 'private' folder located in the script root directory and dot-sources them. It logs the process, including any errors encountered, with optional color coding.

.EXAMPLE
Dot-SourcePrivateScripts

Dot-sources all scripts in the 'private' folder and logs the process.

.NOTES
Ensure the Write-EnhancedLog function is defined before using this function for logging purposes.
#>



Write-Host "Starting to call Get-ModulesFolderPath..."

# Store the outcome in $ModulesFolderPath
try {
  
    $ModulesFolderPath = Get-ModulesFolderPath -WindowsPath "C:\code\modules" -UnixPath "/usr/src/code/modules"
    # $ModulesFolderPath = Get-ModulesFolderPath -WindowsPath "$PsScriptRoot" -UnixPath "/usr/src/code/modules"
    Write-Host "Modules folder path: $ModulesFolderPath"

}
catch {
    Write-Error $_.Exception.Message
}


Write-Host "Starting to call Get-ModulesScriptPathsAndVariables..."
# Retrieve script paths and related variables
# $DotSourcinginitializationInfo = Get-ModulesScriptPathsAndVariables -BaseDirectory "c:\" -ModulesFolderPath $ModulesFolderPath
# $DotSourcinginitializationInfo = Get-ModulesScriptPathsAndVariables -BaseDirectory $PSScriptRoot -ModulesFolderPath $ModulesFolderPath
# $DotSourcinginitializationInfo = Get-ModulesScriptPathsAndVariables -BaseDirectory $ModulesFolderPath

# $DotSourcinginitializationInfo
# $DotSourcinginitializationInfo | Format-List

Write-Host "Starting to call Import-LatestModulesLocalRepository..."
Import-LatestModulesLocalRepository -ModulesFolderPath $ModulesFolderPath -ScriptPath $PSScriptRoot


###############################################################################################################################
############################################### END MODULE LOADING ############################################################
###############################################################################################################################
try {
    Ensure-LoggingFunctionExists -LoggingFunctionName "Write-EnhancedLog"
    # Continue with the rest of the script here
    # exit
}
catch {
    Write-Host "Critical error: $_" -ForegroundColor Red
    exit
}

###############################################################################################################################
###############################################################################################################################
###############################################################################################################################

# Setup logging
Write-EnhancedLog -Message "Script Started" -Level "INFO" -ForegroundColor ([ConsoleColor]::Cyan)

################################################################################################################################
################################################################################################################################
################################################################################################################################

# Execute InstallAndImportModulesPSGallery function
InstallAndImportModulesPSGallery -moduleJsonPath "$PSScriptRoot/modules.json"

################################################################################################################################
################################################ END MODULE CHECKING ###########################################################
################################################################################################################################

    
################################################################################################################################
################################################ END LOGGING ###################################################################
################################################################################################################################

#  Define the variables to be used for the function
#  $PSADTdownloadParams = @{
#      GithubRepository     = "psappdeploytoolkit/psappdeploytoolkit"
#      FilenamePatternMatch = "PSAppDeployToolkit*.zip"
#      ZipExtractionPath    = Join-Path "$PSScriptRoot\private" "PSAppDeployToolkit"
#  }

#  Call the function with the variables
#  Download-PSAppDeployToolkit @PSADTdownloadParams

################################################################################################################################
################################################ END DOWNLOADING PSADT #########################################################
################################################################################################################################


##########################################################################################################################
############################################STARTING THE MAIN FUNCTION LOGIC HERE#########################################
##########################################################################################################################

################################################################################################################################
################################################ START Ensure-ScriptPathsExist #################################################
################################################################################################################################

################################################################################################################################
################################################ START GRAPH CONNECTING ########################################################
################################################################################################################################
$accessToken = Connect-GraphWithCert -tenantId $tenantId -clientId $clientId -certPath $certPath -certPassword $certPassword

Log-Params -Params @{accessToken = $accessToken }

Get-TenantDetails

################################################################################################################################
################################################ START M365 DSC CONNECTING ####################################################
################################################################################################################################

# Define the username from the secrets.psd1 file
# $SecretsFile = Join-Path -Path $PSScriptRoot -ChildPath "secrets.psd1"
# Write-EnhancedLog -Message "Reading credentials from $SecretsFile" -Level "INFO"
# $Secrets = Import-PowerShellDataFile -Path $SecretsFile
# $username = $Secrets.Username


$ImportCertificateIfNotExistparams = @{
    CertPath     = $certPath
    CertPassword = $certPassword
}

Import-CertificateIfNotExist @ImportCertificateIfNotExistparams

# Assume these variables are already defined somewhere else in the script
$certThumbprint = $Secrets.Thumbprint
# $clientId = <Your Client ID>

# Get the tenant details
$tenantDetails = Get-TenantDetails
if ($null -eq $tenantDetails) {
    Write-EnhancedLog -Message "Unable to proceed without tenant details" -Level "ERROR"
    exit
}


# Retrieve necessary details from the tenant details
$TenantDomain = $tenantDetails.TenantDomain

# Read the components from the PSD1 file
$ComponentsFile = Join-Path -Path $PSScriptRoot -ChildPath "Components.psd1"
Write-EnhancedLog -Message "Reading components from $ComponentsFile" -Level "INFO"
$Components = Import-PowerShellDataFile -Path $ComponentsFile

# Define the export paths for each product category
$ExportPaths = @{
    "AAD"     = "C:\Export\AAD"
    "EXO"     = "C:\Export\EXO"
    "Intune"  = "C:\Export\Intune"
    "O365"    = "C:\Export\O365"
    "OD"      = "C:\Export\OD"
    "Planner" = "C:\Export\Planner"
    "PP"      = "C:\Export\PP"
    "SC"      = "C:\Export\SC"
    "SPO"     = "C:\Export\SPO"
    "Teams"   = "C:\Export\Teams"
}

Write-EnhancedLog -Message "Ensuring export paths exist" -Level "INFO"
# Create directories if they do not exist
$ExportPaths.Values | ForEach-Object {
    if (-not (Test-Path -Path $_)) {
        Write-EnhancedLog -Message "Creating directory $_" -Level "INFO"
        New-Item -ItemType Directory -Path $_ -Force | Out-Null
    }
    else {
        Write-EnhancedLog -Message "Directory $_ already exists" -Level "INFO"
    }
}

# Function to export components
function Export-Components {
    param (
        [string]$Category,
        [array]$ComponentList,
        [string]$OutputPath,
        [string]$CertificateThumbprint,
        [string]$ApplicationId,
        [string]$TenantDomain
    )
    
    Write-EnhancedLog -Message "Changing directory to $OutputPath" -Level "INFO"
    Push-Location -Path $OutputPath
    try {

        # Export all components in the category together
        #When exporting all components, there is a good feature that it does not export empty ones and one populated ones
        Write-EnhancedLog -Message "Exporting all components in $Category to a single file" -Level "INFO"
        $AllComponentsFileName = "$Category-AllComponents.ps1"
   
        $splatAllComponentsParams = @{
            Components            = $ComponentList
            CertificateThumbprint = $CertificateThumbprint
            ApplicationId         = $ApplicationId
            TenantId              = $TenantDomain
            Path                  = $OutputPath
            FileName              = $AllComponentsFileName
        }
   
        Export-M365DSCConfiguration @splatAllComponentsParams
        Write-EnhancedLog -Message "Exported all components in $Category to $OutputPath\$AllComponentsFileName" -Level "INFO"

        # Export each component individually
        foreach ($Component in $ComponentList) {
            Write-EnhancedLog -Message "Exporting $Component to $OutputPath" -Level "INFO"
            $FileName = "$Component.ps1"

            $splatParams = @{
                Components            = @($Component)
                CertificateThumbprint = $CertificateThumbprint
                ApplicationId         = $ApplicationId
                TenantId              = $TenantDomain
                Path                  = $OutputPath
                FileName              = $FileName
            }

            Export-M365DSCConfiguration @splatParams
            Write-EnhancedLog -Message "Exported $Component to $OutputPath\$FileName" -Level "INFO"
        }

    }
    catch {
        Handle-Error -ErrorRecord $_
        Write-EnhancedLog -Message "Failed to export component $Component" -Level "ERROR"
    }
    finally {
        Write-EnhancedLog -Message "Reverting directory to previous location" -Level "INFO"
        Pop-Location
    }
}

# Export each category
$CategoriesToProcess = @(
    "AAD"
    #"EXO",
    # "Intune"
    #"O365",
    #"OD",
    #"Planner",
    #"PP",
    #"SC",
    #"SPO",
    # "Teams"
)

foreach ($Category in $CategoriesToProcess) {
    if ($ExportPaths.ContainsKey($Category)) {
        Write-EnhancedLog -Message "Processing category: $Category" -Level "INFO"
        $ComponentList = $Components[$Category]
        
        if ($ComponentList -is [System.Collections.ICollection]) {
            Write-EnhancedLog -Message "Components in $Category $($ComponentList -join ', ')" -Level "INFO"
        }
        else {
            Write-EnhancedLog -Message "Error: Components for $Category are not in the expected format" -Level "ERROR"
            continue
        }
        
        $splatExportComponents = @{
            Category              = $Category
            ComponentList         = $ComponentList
            OutputPath            = $ExportPaths[$Category]
            CertificateThumbprint = $certThumbprint
            ApplicationId         = $clientId
            TenantDomain          = $TenantDomain
        }

        Export-Components @splatExportComponents
    }
    else {
        Write-EnhancedLog -Message "Skipping invalid category: $Category" -Level "WARN"
    }
}
