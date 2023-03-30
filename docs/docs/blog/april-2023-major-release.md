# Microsoft365DSC – October 2022 Major Release (version 1.22.1005.1)

As defined by our [Breaking Changes Policy](https://microsoft365dsc.com/concepts/breaking-changes/), twice a year we allow for breaking changes to be deployed as part of a release. Our next major release, scheduled to go out on April 5th 2023, will include several breaking changes and will be labeled version 1.23.405.1. This article provides details on the breaking changes and other important updates that will be included as part of our April 2023 Major release.

## IntuneDeviceEnrollmentPlatformRestriction ([#2431](https://github.com/microsoft/Microsoft365DSC/pull/2431))
As part of the April 2023 major release, this resource is being re-written almost entirely to account for new properties. The recommendation is to stop using old instances of it and start fresh by using this new updated version. One option would be to use the **Export-M365DSCConfiguration** cmdlet and target only this resource. Then, replace the existing instances in your configurations with the newly extracted content.

## Primary Keys of Multiple Resources ([#2968](https://github.com/microsoft/Microsoft365DSC/pull/2968))
We have modified the logic of all the resources below to ensure we have a primary key defined. In most cases we have marked the Identity or DisplayName properties as now being mandatory. While we don't believe this change will have a major impact on most existing configuration since they probably alreadfy defined these properties, there is a small chance that customers omitted to include them. The recomendation in this case is to ensure you add the new required properties to your resources. Resources impacted are:

* AADAdministrativeUnit
* AADConditionalAccessPolicy
* AADEntitlementManagementAccessPackage
* AADEntitlementManagementAccessPackageAssignmentPolicy
* AADEntitlementManagementAccessPackageCatalog
* AADEntitlementManagementAccessPackageCatalogResource
* AADEntitlementManagementAccessPackageCatalogResource
* AADEntitlementManagementConnectedOrganization
* AADRoleSetting
* IntuneDeviceConfigurationPolicyAndroidDeviceAdministrator
* IntuneDeviceConfigurationPolicyAndroidDeviceOwner
* IntuneDeviceConfigurationPolicyAndroidOpenSourceProject
* IntuneDeviceConfigurationPolicyMacOS
* IntuneDeviceConfigurationPolicyiOS
* IntuneExploitProtectionPolicyWindows10SettingCatalog
* IntuneWifiConfigurationPolicyAndroidDeviceAdministrator
* IntuneWifiConfigurationPolicyAndroidEntrepriseDeviceOwner
* IntuneWifiConfigurationPolicyAndroidEntrepriseWorkProfile
* IntuneWifiConfigurationPolicyAndroidForWork
* IntuneWifiConfigurationPolicyAndroidOpenSourceProject
* IntuneWifiConfigurationPolicyIOS,
* IntuneWifiConfigurationPolicyMacOS
* IntuneWifiConfigurationPolicyWindows10
* IntuneWindowUpdateForBusinessRingUpdateProfileWindows10
* IntuneWindowsUpdateForBusinessRingUpdateProfileWindows10
* IntuneWindowsInformationProtectionPolicyWindows10MdmEnrolled
* IntuneWindowsUpdateForBusinessFeatureUpdateProfileWindows10

## Removed the Identity Parameters from EXOIRMConfiguration, EXOResourceConfiguraton & IntuneDeviceConfigurationDeliveryOptimizationPolicyWindows 10
The Identity parameter, which was the primary key for the resources listed, has been replaced by the IsSingleInstance parameter. This is because there could only ever be one instance of these resources on the tenants and in order to align with other tenant-wide resources, the IsSingleInstance parameter needs to be present. This parameter only ever accepts a value of 'Yes' and its sole purpose is to ensure there isn't more than one instance of the given resource per configuration file.

## IntuneAttackSurfaceReductionRulesPolicyWindows10ConfigManager ([#3003](https://github.com/microsoft/Microsoft365DSC/pull/3003))
As part of this release, we are changing the DisplayName parameter to be required. Current configurations should make sure to include this parameter to avoid any conflicts when upgrading.

## Removal of Deprecated Parameters ([#3040](https://github.com/microsoft/Microsoft365DSC/pull/3040))
We are removing parameters that have been deprecated from various resources as part of this major update. As a reminder, parameters that become deprecated on Microsoft 365 are being marked as deprecated in Microsoft365DSC until the next major release. In the past, using these parameters would have resulted in a warning letting the users know that they are using a deprecated parameter and that it would simply be ignored. Starting with this release, using these deprecated parameters will generate an error. It is recommended to scan existing configurations and remove deprecated parameters. The following resources have deprecated parameters that have been removed as part of this release, along with the parameters that have been removed:

* AADApplication
  * Oauth2RequirePostResponse
* AADConditionalAccessPolicy
  * IncludeDevices
  * ExcludeDevices
* AADUser
  * PreferredDataLocation
* EXOAntiPhishPolicy
  * EnableAntispoofEnforcement
  * TargetedDomainProtectionAction
* EXOHostedContentFilterPolicy
  * EndUserSpamNotificationCustomFromAddress
  * EndUserSpamNotificationCustomFromName
* EXOMalwareFilterPolicy
  * Action
  * CustomAlertText
  * EnableExternalSenderNotifications
  * EnableInternalSenderNotifications
* EXOOrganizationConfig
  * AllowPlusAddressInRecipients
* EXOSaveLinksPolicy
  * DoNotAllowClickThrough
  * DoNotTrackUserClicks
  * IsEnabled
* EXOSharedMailbox
  * Aliases
* EXOTransportRule
  * ExceptIfMessageContainsAllDataClassifications
  * IncidentReportOriginalMail
  * MessageContainsAllDataClassifications
* SCSensitivityLabel
  * Disabled
  * ApplyContentMarkingFooterFontName
  * ApplyContentMarkingHeaderFontName
  * ApplyWaterMarkingFontName
  * EncryptionAipTemplateScopes
* SPOTenantSettings
  * RequireAcceptingAccountMatchInvitedAccount
* TeamsMeetingPolicy
  * RecordingStorageMode

## AADGroup - Added SecurityEnabled and MailEnabled as Mandatory Parameters ([#3077](https://github.com/microsoft/Microsoft365DSC/pull/3077))
We've updated the AADGroup resource to enforce the MailEnabled and SecurityEnabled parameters as mandatory. Omitting these parameters was throwing an error since they were required by the Microsoft Graph API associated with it. To update existing configurations, simply make sure that every instances of the AADGroup resource includes both the MailEnabled and SecurityEnabled parameters.

## Export - Resource Instance Logical Naming ([#3087](https://github.com/microsoft/Microsoft365DSC/pull/3087))
In order to make it easier for folks to follow the execution process of the Start-DSCConfiguration cmdlet and to keep the exported configuration files cleaner, we've changed the extraction logic to provide meaningful names to the extracted components. In the past, every instance extracted used to be assigned a GUID as its instance name. Starting with this release, extracted resources will be named based on the following logic:

1. If the resource implements the **IsSingleInstance** property, the resource instance's will simply take the resource's name. E.g.,
 ```
  SPOTenantSettings 'SPOTenantSettings'
  {
      ...
  }
 ```

2.Otherwise, the resource will always be named following the "[ResourceName]-[PrimaryKey]" pattern. E.g.,
 ```
  TeamsMeetingPolicy 'TeamsMeetingPolicy-MyPolicy'
  {
      DisplayName = 'MyPolicy'
      ...
  }
  ```
  The primary key will always give priority to the following properties in order:
  * DisplayName
  * Identity
  * Id
  * Name
  This means that if a resource instance defines both DisplayName and Id, that the DisplayName value will be used to name the instance.

## Logging Improvements to Include the Instance Name ([#3091](https://github.com/microsoft/Microsoft365DSC/pull/3091))
Starting with this version of M365DSC, drift events logged in Event Viewer will include the Instance name as their source instead of just the full resource's name.
![image](https://raw.githubusercontent.com/microsoft/Microsoft365DSC/Dev/docs/docs/Images/April2023MR-EventViewer.png)
In addition to this, the M365DSCEvent XML content will now include an additional property for the ConfigurationDrift element that will be named **InstanceName** and will contain the resource's instance name. E.g.,

```
<M365DSCEvent>
    <ConfigurationDrift Source="MSFT_AADNamedLocationPolicy" InstanceName="[AADNamedLocationPolicy]HibouChou">
        <ParametersNotInDesiredState>
            <Param Name="IpRanges"><CurrentValue>192.226.137.107/12</CurrentValue><DesiredValue>192.226.137.106/12</DesiredValue></Param>
        </ParametersNotInDesiredState>
    </ConfigurationDrift>
    <DesiredValues>
        <Param Name ="OdataType">#microsoft.graph.ipNamedLocation</Param>
        <Param Name ="DisplayName">Nik's Laptop</Param>
        <Param Name ="IpRanges">192.226.137.106/12</Param>
        <Param Name ="IsTrusted">True</Param>
        <Param Name ="Ensure">Present</Param>
        <Param Name ="Credential">System.Management.Automation.PSCredential</Param>
        <Param Name ="Verbose">True</Param>
    </DesiredValues>
</M365DSCEvent>
```