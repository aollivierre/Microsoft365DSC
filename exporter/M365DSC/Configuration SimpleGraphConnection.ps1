Configuration SimpleGraphConnection
{
    # Import-DscResource -ModuleName 'PSDesiredStateConfiguration'

    Node localhost
    {
        Script ConnectToGraph {
            GetScript = {
                return @{
                    Result = "Connect-MgGraph"
                }
            }
            SetScript = {
                # Specify the full path to the Microsoft.Graph.Authentication module
                $modulePath = 'C:\Users\Administrator\Documents\WindowsPowerShell\Modules\Microsoft.Graph.Authentication'
                Import-Module -Name $modulePath
                
                # Connect to Microsoft Graph
                Connect-MgGraph
            }
            TestScript = {
                return $false
            }
        }
    }
}

# Compile the Configuration
SimpleGraphConnection -OutputPath "$PSScriptRoot\SimpleGraphConnection"

# Apply the Configuration
Start-DscConfiguration -Path "$PSScriptRoot\SimpleGraphConnection" -Wait -Verbose -Force
