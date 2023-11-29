@description('Optional. The location to deploy resources to.')
param location string = resourceGroup().location

@description('Required. The name of the load test to create.')
param loadTestName string

@description('Required. The name of the Key Vault to create.')
param keyVaultName string

resource loadTest 'Microsoft.LoadTestService/loadTests@2022-12-01' = {
  name: loadTestName
  location: location
  properties: {
    description: 'The description of the load test.'
  }
  identity: {
    type: 'SystemAssigned'
  }
}

resource keyVault 'Microsoft.KeyVault/vaults@2022-07-01' = {
  name: keyVaultName
  location: location
  properties: {
    sku: {
      family: 'A'
      name: 'standard'
    }
    tenantId: tenant().tenantId
    enablePurgeProtection: true // Required by batch account
    softDeleteRetentionInDays: 7
    enabledForTemplateDeployment: true
    enabledForDiskEncryption: true
    enabledForDeployment: true
    enableRbacAuthorization: true
    accessPolicies: []
  }

  resource key 'keys@2022-07-01' = {
    name: 'keyEncryptionKey'
    properties: {
      kty: 'RSA'
    }
  }
}

@description('The resource ID of the created Key Vault.')
output keyVaultResourceId string = keyVault.id

@description('The name of the created Key Vault encryption key.')
output keyVaultKeyName string = keyVault::key.name

@description('The URL of the created Key Vault.')
output keyVaultKeyUrl string = keyVault::key.properties.keyUriWithVersion

@description('The name of the created load test.')
output loadTestName string = loadTest.name