targetScope = 'managementGroup'
metadata name = ' PIM Role Assignments (Management Group scope)'
metadata description = 'This module deploys a PIM Role Assignment at a Management Group scope using minimal parameters.'

// ========== //
// Parameters //
// ========== //

@description('Optional. The location to deploy resources to.')
param resourceLocation string = deployment().location

@description('Optional. A short identifier for the kind of deployment. Should be kept short to not run into resource-name length-constraints.')
param serviceShort string = 'pimmgmin'

// ============== //
// Test Execution //
// ============== //

module testDeployment '../../../main.bicep' = {
  name: '${uniqueString(deployment().name)}-test-${serviceShort}'
  params: {
    principalId: ''
    roleDefinitionIdOrName: 'Resource Policy Contributor'
    requestType: 'AdminAssign'
    location: resourceLocation
    scheduleInfo: {
      expiration: {
        duration: 'P1H'
        type: 'AfterDuration'
      }
    }
  }
}
