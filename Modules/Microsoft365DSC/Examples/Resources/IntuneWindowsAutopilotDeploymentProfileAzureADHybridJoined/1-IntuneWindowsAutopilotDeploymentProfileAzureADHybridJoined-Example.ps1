<#
This example is used to test new resources and showcase the usage of new resources being worked on.
It is not meant to use as a production baseline.
#>

Configuration Example
{
    param(
        [Parameter(Mandatory = $true)]
        [PSCredential]
        $Credscredential
    )
    Import-DscResource -ModuleName Microsoft365DSC

    node localhost
    {
        IntuneWindowsAutopilotDeploymentProfileAzureADHybridJoined 'Example'
        {
            Assignments                            = @();
            Credential                             = $Credscredential;
            Description                            = "";
            DeviceNameTemplate                     = "";
            DeviceType                             = "windowsPc";
            DisplayName                            = "hybrid";
            EnableWhiteGlove                       = $True;
            Ensure                                 = "Present";
            ExtractHardwareHash                    = $False;
            HybridAzureADJoinSkipConnectivityCheck = $True;
            Id                                     = "36b4d209-c9af-487f-8cf2-8397cefbc29a";
            Language                               = "os-default";
            OutOfBoxExperienceSettings             = MSFT_MicrosoftGraphoutOfBoxExperienceSettings{
                HideEULA = $True
                HideEscapeLink = $True
                HidePrivacySettings = $True
                DeviceUsageType = 'singleUser'
                SkipKeyboardSelectionPage = $True
                UserType = 'standard'
            };
        }
    }
}
