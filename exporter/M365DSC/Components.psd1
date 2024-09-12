@{
    # AAD components
    AAD = @(
        # "AADActivityBasedTimeoutPolicy",
        # "AADAdministrativeUnit",
        # "AADApplication",
        # "AADAttributeSet",
        # "AADAuthenticationContextClassReference",
        # "AADAuthenticationFlowPolicy",
        "AADAuthenticationMethodPolicy",
        "AADAuthenticationMethodPolicyAuthenticator",
        "AADAuthenticationMethodPolicyEmail",
        "AADAuthenticationMethodPolicyFido2",
        "AADAuthenticationMethodPolicySms",
        "AADAuthenticationMethodPolicySoftware",
        "AADAuthenticationMethodPolicyTemporary",
        "AADAuthenticationMethodPolicyVoice",
        "AADAuthenticationMethodPolicyX509",
        "AADAuthenticationStrengthPolicy",
        "AADAuthorizationPolicy",
        "AADConditionalAccessPolicy",
        # "AADCrossTenantAccessPolicy",
        # "AADCrossTenantAccessPolicyConfigurationDefault",
        # "AADCrossTenantAccessPolicyConfigurationPartner",
        # "AADEntitlementManagementAccessPackage",
        # "AADEntitlementManagementAccessPackageAssignmentPolicy",
        # "AADEntitlementManagementAccessPackageCatalog",
        # "AADEntitlementManagementAccessPackageCatalogResource",
        # "AADEntitlementManagementConnectedOrganization",
        # "AADEntitlementManagementRoleAssignment",
        # "AADExternalIdentityPolicy",
        "AADGroup",
        # "AADGroupLifecyclePolicy",
        # "AADGroupsNamingPolicy",
        # "AADGroupsSettings",
        # "AADNamedLocationPolicy",
        # "AADRoleDefinition",
        # "AADRoleEligibilityScheduleRequest",
        # "AADRoleSetting",
        # "AADSecurityDefaults",
        # "AADServicePrincipal",
        # "AADSocialIdentityProvider",
        "AADTenantDetails"
        # "AADTokenLifetimePolicy",
        "AADUser"
    )
    # EXO components
    EXO = @(
        "EXOAcceptedDomain",
        "EXOActiveSyncDeviceAccessRule",
        "EXOAddressBookPolicy",
        "EXOAddressList",
        "EXOAntiPhishPolicy",
        "EXOAntiPhishRule",
        "EXOApplicationAccessPolicy",
        "EXOAtpPolicyForO365",
        "EXOAuthenticationPolicy",
        "EXOAuthenticationPolicyAssignment",
        "EXOAvailabilityAddressSpace",
        "EXOAvailabilityConfig",
        "EXOCalendarProcessing",
        "EXOCASMailboxPlan",
        "EXOCASMailboxSettings",
        "EXOClientAccessRule",
        "EXODataClassification",
        "EXODataEncryptionPolicy",
        "EXODistributionGroup",
        "EXODkimSigningConfig",
        "EXOEmailAddressPolicy",
        "EXOGlobalAddressList",
        "EXOGroupSettings",
        "EXOHostedConnectionFilterPolicy",
        "EXOHostedContentFilterPolicy",
        "EXOHostedContentFilterRule",
        "EXOHostedOutboundSpamFilterPolicy",
        "EXOHostedOutboundSpamFilterRule",
        "EXOInboundConnector",
        "EXOIntraOrganizationConnector",
        "EXOIRMConfiguration",
        "EXOJournalRule",
        "EXOMailboxAutoReplyConfiguration",
        "EXOMailboxCalendarFolder",
        "EXOMailboxPermission",
        "EXOMailboxPlan",
        "EXOMailboxSettings",
        "EXOMailContact",
        "EXOMailTips",
        "EXOMalwareFilterPolicy",
        "EXOMalwareFilterRule",
        "EXOManagementRole",
        "EXOManagementRoleAssignment",
        "EXOManagementRoleEntry",
        "EXOMessageClassification",
        "EXOMobileDeviceMailboxPolicy",
        "EXOOfflineAddressBook",
        "EXOOMEConfiguration",
        "EXOOnPremisesOrganization",
        "EXOOrganizationConfig",
        "EXOOrganizationRelationship",
        "EXOOutboundConnector",
        "EXOOwaMailboxPolicy",
        "EXOPartnerApplication",
        "EXOPerimeterConfiguration",
        "EXOPlace",
        "EXOPolicyTipConfig",
        "EXOQuarantinePolicy",
        "EXORecipientPermission",
        "EXORemoteDomain",
        "EXOReportSubmissionPolicy",
        "EXOReportSubmissionRule",
        "EXOResourceConfiguration",
        "EXORoleAssignmentPolicy",
        "EXORoleGroup",
        "EXOSafeAttachmentPolicy",
        "EXOSafeAttachmentRule",
        "EXOSafeLinksPolicy",
        "EXOSafeLinksRule",
        "EXOSharedMailbox",
        "EXOSharingPolicy",
        "EXOTransportConfig",
        "EXOTransportRule"
    )
    # Intune components
    Intune = @(
        "IntuneAccountProtectionLocalAdministratorPasswordSolutionPolicy",
        "IntuneAccountProtectionLocalUserGroupMembershipPolicy",
        "IntuneAccountProtectionPolicy",
        "IntuneAntivirusPolicyWindows10SettingCatalog",
        "IntuneAppConfigurationDevicePolicy",
        "IntuneAppConfigurationPolicy",
        "IntuneApplicationControlPolicyWindows10",
        "IntuneAppProtectionPolicyAndroid",
        "IntuneAppProtectionPolicyiOS",
        "IntuneASRRulesPolicyWindows10",
        "IntuneAttackSurfaceReductionRulesPolicyWindows10ConfigManager",
        "IntuneDeviceAndAppManagementAssignmentFilter",
        "IntuneDeviceCategory",
        "IntuneDeviceCleanupRule",
        "IntuneDeviceCompliancePolicyAndroid",
        "IntuneDeviceCompliancePolicyAndroidDeviceOwner",
        "IntuneDeviceCompliancePolicyAndroidWorkProfile",
        "IntuneDeviceCompliancePolicyiOs",
        "IntuneDeviceCompliancePolicyMacOS",
        "IntuneDeviceCompliancePolicyWindows10",
        "IntuneDeviceConfigurationAdministrativeTemplatePolicyWindows10",
        "IntuneDeviceConfigurationCustomPolicyWindows10",
        "IntuneDeviceConfigurationDefenderForEndpointOnboardingPolicyWindows10",
        "IntuneDeviceConfigurationDeliveryOptimizationPolicyWindows10",
        "IntuneDeviceConfigurationDomainJoinPolicyWindows10",
        "IntuneDeviceConfigurationEmailProfilePolicyWindows10",
        "IntuneDeviceConfigurationEndpointProtectionPolicyWindows10",
        "IntuneDeviceConfigurationFirmwareInterfacePolicyWindows10",
        "IntuneDeviceConfigurationHealthMonitoringConfigurationPolicyWindows10",
        "IntuneDeviceConfigurationIdentityProtectionPolicyWindows10",
        "IntuneDeviceConfigurationImportedPfxCertificatePolicyWindows10",
        "IntuneDeviceConfigurationKioskPolicyWindows10",
        "IntuneDeviceConfigurationNetworkBoundaryPolicyWindows10",
        "IntuneDeviceConfigurationPkcsCertificatePolicyWindows10",
        "IntuneDeviceConfigurationPlatformScriptMacOS",
        "IntuneDeviceConfigurationPlatformScriptWindows",
        "IntuneDeviceConfigurationPolicyAndroidDeviceAdministrator",
        "IntuneDeviceConfigurationPolicyAndroidDeviceOwner",
        "IntuneDeviceConfigurationPolicyAndroidOpenSourceProject",
        "IntuneDeviceConfigurationPolicyAndroidWorkProfile",
        "IntuneDeviceConfigurationPolicyiOS",
        "IntuneDeviceConfigurationPolicyMacOS",
        "IntuneDeviceConfigurationPolicyWindows10",
        "IntuneDeviceConfigurationSCEPCertificatePolicyWindows10",
        "IntuneDeviceConfigurationSecureAssessmentPolicyWindows10",
        "IntuneDeviceConfigurationSharedMultiDevicePolicyWindows10",
        "IntuneDeviceConfigurationTrustedCertificatePolicyWindows10",
        "IntuneDeviceConfigurationVpnPolicyWindows10",
        "IntuneDeviceConfigurationWindowsTeamPolicyWindows10",
        "IntuneDeviceConfigurationWiredNetworkPolicyWindows10",
        "IntuneDeviceEnrollmentLimitRestriction",
        "IntuneDeviceEnrollmentPlatformRestriction",
        "IntuneDeviceEnrollmentStatusPageWindows10",
        "IntuneDeviceRemediation",
        "IntuneDiskEncryptionMacOS",
        "IntuneEndpointDetectionAndResponsePolicyWindows10",
        "IntuneExploitProtectionPolicyWindows10SettingCatalog",
        "IntunePolicySets",
        "IntuneRoleAssignment",
        "IntuneRoleDefinition",
        "IntuneSettingCatalogASRRulesPolicyWindows10",
        "IntuneSettingCatalogCustomPolicyWindows10",
        "IntuneWifiConfigurationPolicyAndroidDeviceAdministrator",
        "IntuneWifiConfigurationPolicyAndroidEnterpriseDeviceOwner",
        "IntuneWifiConfigurationPolicyAndroidEnterpriseWorkProfile",
        "IntuneWifiConfigurationPolicyAndroidForWork",
        "IntuneWifiConfigurationPolicyAndroidOpenSourceProject",
        "IntuneWifiConfigurationPolicyIOS",
        "IntuneWifiConfigurationPolicyMacOS",
        "IntuneWifiConfigurationPolicyWindows10",
        "IntuneWindowsAutopilotDeploymentProfileAzureADHybridJoined",
        "IntuneWindowsAutopilotDeploymentProfileAzureADJoined",
        "IntuneWindowsInformationProtectionPolicyWindows10MdmEnrolled",
        "IntuneWindowsUpdateForBusinessDriverUpdateProfileWindows10",
        "IntuneWindowsUpdateForBusinessFeatureUpdateProfileWindows10",
        "IntuneWindowsUpdateForBusinessRingUpdateProfileWindows10"
    )
    # O365 components
    O365 = @(
        "O365AdminAuditLogConfig",
        "O365Group",
        "O365OrgCustomizationSetting",
        "O365OrgSettings",
        "O365SearchAndIntelligenceConfigurations"
    )
    # OD components
    OD = @(
        "ODSettings"
    )
    # Planner components
    Planner = @(
        "PlannerBucket",
        "PlannerPlan",
        "PlannerTask"
    )
    # PP components
    PP = @(
        "PPPowerAppsEnvironment",
        "PPTenantIsolationSettings",
        "PPTenantSettings"
    )
    # SC components
    SC = @(
        "SCAuditConfigurationPolicy",
        "SCAutoSensitivityLabelPolicy",
        "SCAutoSensitivityLabelRule",
        "SCCaseHoldPolicy",
        "SCCaseHoldRule",
        "SCComplianceCase",
        "SCComplianceSearch",
        "SCComplianceSearchAction",
        "SCComplianceTag",
        "SCDeviceConditionalAccessPolicy",
        "SCDeviceConfigurationPolicy",
        "SCDLPCompliancePolicy",
        "SCDLPComplianceRule",
        "SCFilePlanPropertyAuthority",
        "SCFilePlanPropertyCategory",
        "SCFilePlanPropertyCitation",
        "SCFilePlanPropertyDepartment",
        "SCFilePlanPropertyReferenceId",
        "SCFilePlanPropertySubCategory",
        "SCLabelPolicy",
        "SCProtectionAlert",
        "SCRetentionCompliancePolicy",
        "SCRetentionComplianceRule",
        "SCRetentionEventType",
        "SCRoleGroup",
        "SCRoleGroupMember",
        "SCSecurityFilter",
        "SCSensitivityLabel",
        "SCSupervisoryReviewPolicy",
        "SCSupervisoryReviewRule"
    )
    # SPO components
    SPO = @(
        "SPOAccessControlSettings",
        "SPOApp",
        "SPOBrowserIdleSignout",
        "SPOHomeSite",
        "SPOHubSite",
        "SPOOrgAssetsLibrary",
        "SPOPropertyBag",
        "SPOSearchManagedProperty",
        "SPOSearchResultSource",
        "SPOSharingSettings",
        "SPOSite",
        "SPOSiteAuditSettings",
        "SPOSiteDesign",
        "SPOSiteDesignRights",
        "SPOSiteGroup",
        "SPOSiteScript",
        "SPOStorageEntity",
        "SPOTenantCdnEnabled",
        "SPOTenantCdnPolicy",
        "SPOTenantSettings",
        "SPOTheme",
        "SPOUserProfileProperty"
    )
    # Teams components
    Teams = @(
        # "TeamsAppPermissionPolicy",
        # "TeamsAppSetupPolicy",
        # "TeamsAudioConferencingPolicy",
        # "TeamsCallHoldPolicy",
        # "TeamsCallingPolicy",
        # "TeamsCallParkPolicy",
        # "TeamsCallQueue",
        # "TeamsChannel",
        # "TeamsChannelsPolicy",
        # "TeamsChannelTab",
        # "TeamsClientConfiguration",
        # "TeamsComplianceRecordingPolicy",
        # "TeamsCortanaPolicy",
        # "TeamsDialInConferencingTenantSettings",
        # "TeamsEmergencyCallingPolicy",
        # "TeamsEmergencyCallRoutingPolicy",
        # "TeamsEnhancedEncryptionPolicy",
        # "TeamsEventsPolicy",
        # "TeamsFederationConfiguration",
        # "TeamsFeedbackPolicy",
        # "TeamsFilesPolicy",
        # "TeamsGroupPolicyAssignment",
        # "TeamsGuestCallingConfiguration",
        # "TeamsGuestMeetingConfiguration",
        # "TeamsGuestMessagingConfiguration",
        # "TeamsIPPhonePolicy",
        # "TeamsMeetingBroadcastConfiguration",
        # "TeamsMeetingBroadcastPolicy",
        # "TeamsMeetingConfiguration",
        # "TeamsMeetingPolicy",
        # "TeamsMessagingPolicy",
        # "TeamsMobilityPolicy",
        # "TeamsNetworkRoamingPolicy",
        # "TeamsOnlineVoicemailPolicy",
        # "TeamsOnlineVoicemailUserSettings",
        # "TeamsOnlineVoiceUser",
        # "TeamsOrgWideAppSettings",
        # "TeamsPstnUsage",
        # "TeamsShiftsPolicy",
        # "TeamsTeam",
        # "TeamsTemplatesPolicy",
        # "TeamsTenantDialPlan",
        # "TeamsTenantNetworkRegion",
        # "TeamsTenantNetworkSite",
        # "TeamsTenantNetworkSubnet",
        # "TeamsTenantTrustedIPAddress",
        # "TeamsTranslationRule",
        # "TeamsUnassignedNumberTreatment",
        # "TeamsUpdateManagementPolicy",
        # "TeamsUpgradeConfiguration",
        # "TeamsUpgradePolicy",
        # "TeamsUser",
        # "TeamsUserCallingSettings",
        # "TeamsUserPolicyAssignment",
        # "TeamsVdiPolicy",
        # "TeamsVoiceRoute",
        # "TeamsVoiceRoutingPolicy",
        # "TeamsWorkloadPolicy"
    )
}