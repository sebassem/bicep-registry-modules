metadata name = 'Using RBAC conditions.'
metadata description = 'This instance deploys the module with RBAC conditions for the role assignments.'

targetScope = 'managementGroup'

@description('Optional. The location to deploy resources to.')
param resourceLocation string = deployment().location

// This parameter needs to be updated with the billing account and the enrollment account of your enviornment.
@description('Optional. The subscription billing scope.')
param subscriptionBillingScope string = 'providers/Microsoft.Billing/billingAccounts/7690848/enrollmentAccounts/350580'

@description('Optional. A token to inject into the name of each resource.')
param namePrefix string = '#_namePrefix_#'

@description('Optional. A short identifier for the kind of deployment. Should be kept short to not run into resource-name length-constraints.')
param serviceShort string = 'ssamin'

@description('Optional. A short guid for the subscription name.')
param subscriptionGuid string = toLower(substring(newGuid(), 0, 3))

module testDeployment '../../../main.bicep' = {
  name: '${uniqueString(deployment().name, resourceLocation)}-test-${serviceShort}-${subscriptionGuid}'
  params: {
    subscriptionAliasEnabled: true
    subscriptionBillingScope: subscriptionBillingScope
    subscriptionAliasName: 'dep-sub-blzv-tests-${namePrefix}-${serviceShort}-${subscriptionGuid}'
    subscriptionDisplayName: 'dep-sub-blzv-tests-${namePrefix}-${serviceShort}-${subscriptionGuid}'
    subscriptionTags: {
      namePrefix: namePrefix
      serviceShort: serviceShort
    }
    subscriptionWorkload: 'Production'
    subscriptionManagementGroupAssociationEnabled: true
    subscriptionManagementGroupId: 'bicep-lz-vending-automation-child'
    resourceProviders: {}
    roleAssignmentEnabled: true
    roleAssignments: [
      {
        principalId: '896b1162-be44-4b28-888a-d01acc1b4271'
        //Network contributor role
        definition: '/providers/Microsoft.Authorization/roleDefinitions/4d97b98b-1d4f-4787-a291-c67834d212e7'
        relativeScope: ''
        roleAssignmentCondition: {
          roleConditionType: {
            principleTypesToAssign: [
              'Group'
            ]
            rolesToAssign: [
              '4d97b98b-1d4f-4787-a291-c67834d212e7'
            ]
            templateName: 'constrainRolesAndPrincipalTypes'
          }
        }
      }
    ]
  }
}

output createdSubId string = testDeployment.outputs.subscriptionId
output namePrefix string = namePrefix
output serviceShort string = serviceShort
output resourceLocation string = resourceLocation
