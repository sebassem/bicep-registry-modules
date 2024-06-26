metadata name = 'Network Manager Security Admin Configurations'
metadata description = '''This module deploys an Network Manager Security Admin Configuration.
A security admin configuration contains a set of rule collections. Each rule collection contains one or more security admin rules.'''
metadata owner = 'Azure/module-maintainers'

@sys.description('Conditional. The name of the parent network manager. Required if the template is used in a standalone deployment.')
param networkManagerName string

@maxLength(64)
@sys.description('Required. The name of the security admin configuration.')
param name string

@maxLength(500)
@sys.description('Optional. A description of the security admin configuration.')
param description string = ''

@allowed([
  'None'
  'All'
  'AllowRulesOnly'
])
@sys.description('Required. Enum list of network intent policy based services.')
param applyOnNetworkIntentPolicyBasedServices array = [ 'None' ]

@sys.description('Optional. A security admin configuration contains a set of rule collections that are applied to network groups. Each rule collection contains one or more security admin rules.')
param ruleCollections array = []

resource networkManager 'Microsoft.Network/networkManagers@2023-04-01' existing = {
  name: networkManagerName
}

resource securityAdminConfigurations 'Microsoft.Network/networkManagers/securityAdminConfigurations@2023-04-01' = {
  name: name
  parent: networkManager
  properties: {
    description: description
    applyOnNetworkIntentPolicyBasedServices: applyOnNetworkIntentPolicyBasedServices
  }
}

module securityAdminConfigurations_ruleCollections 'rule-collection/main.bicep' = [for (ruleCollection, index) in ruleCollections: {
  name: '${uniqueString(deployment().name)}-SecurityAdminConfigurations-RuleCollections-${index}'
  params: {
    networkManagerName: networkManager.name
    securityAdminConfigurationName: securityAdminConfigurations.name
    name: ruleCollection.name
    appliesToGroups: ruleCollection.appliesToGroups
    rules: contains(ruleCollection, 'rules') ? ruleCollection.rules : []
  }
}]

@sys.description('The name of the deployed security admin configuration.')
output name string = securityAdminConfigurations.name

@sys.description('The resource ID of the deployed security admin configuration.')
output resourceId string = securityAdminConfigurations.id

@sys.description('The resource group the security admin configuration was deployed into.')
output resourceGroupName string = resourceGroup().name
