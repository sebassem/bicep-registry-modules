# Synapse Workspaces Keys `[Microsoft.Synapse/workspaces/keys]`

This module deploys a Synapse Workspaces Key.

## Navigation

- [Resource Types](#Resource-Types)
- [Parameters](#Parameters)
- [Outputs](#Outputs)
- [Cross-referenced modules](#Cross-referenced-modules)
- [Data Collection](#Data-Collection)

## Resource Types

| Resource Type | API Version |
| :-- | :-- |
| `Microsoft.Synapse/workspaces/keys` | [2021-06-01](https://learn.microsoft.com/en-us/azure/templates/Microsoft.Synapse/2021-06-01/workspaces/keys) |

## Parameters

**Required parameters**

| Parameter | Type | Description |
| :-- | :-- | :-- |
| [`isActiveCMK`](#parameter-isactivecmk) | bool | Used to activate the workspace after a customer managed key is provided. |
| [`keyVaultResourceId`](#parameter-keyvaultresourceid) | string | The resource ID of a key vault to reference a customer managed key for encryption from. |
| [`name`](#parameter-name) | string | Encryption key name. |

**Conditional parameters**

| Parameter | Type | Description |
| :-- | :-- | :-- |
| [`workspaceName`](#parameter-workspacename) | string | The name of the parent Synapse Workspace. Required if the template is used in a standalone deployment. |

### Parameter: `isActiveCMK`

Used to activate the workspace after a customer managed key is provided.

- Required: Yes
- Type: bool

### Parameter: `keyVaultResourceId`

The resource ID of a key vault to reference a customer managed key for encryption from.

- Required: Yes
- Type: string

### Parameter: `name`

Encryption key name.

- Required: Yes
- Type: string

### Parameter: `workspaceName`

The name of the parent Synapse Workspace. Required if the template is used in a standalone deployment.

- Required: Yes
- Type: string


## Outputs

| Output | Type | Description |
| :-- | :-- | :-- |
| `name` | string | The name of the deployed key. |
| `resourceGroupName` | string | The resource group of the deployed key. |
| `resourceId` | string | The resource ID of the deployed key. |

## Cross-referenced modules

_None_

## Data Collection

The software may collect information about you and your use of the software and send it to Microsoft. Microsoft may use this information to provide services and improve our products and services. You may turn off the telemetry as described in the [repository](https://aka.ms/avm/telemetry). There are also some features in the software that may enable you and Microsoft to collect data from users of your applications. If you use these features, you must comply with applicable law, including providing appropriate notices to users of your applications together with a copy of Microsoft’s privacy statement. Our privacy statement is located at <https://go.microsoft.com/fwlink/?LinkID=824704>. You can learn more about data collection and use in the help documentation and our privacy statement. Your use of the software operates as your consent to these practices.
