# TF_AKS_AKV
Just playing around with AKS and the AKV CSI driver. As a bonus, you can uncomment the VM and Bastion related code and also to play around with logging into VMs via Azure Bastion using AAD SSO.

If you aren't deploying from Linux or WSL, comment out the contents of create_env_var_script.tf.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >=1.2.7 |
| <a name="requirement_azuread"></a> [azuread](#requirement\_azuread) | 2.28.1 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | 3.24.0 |
| <a name="requirement_null"></a> [null](#requirement\_null) | 3.1.1 |
| <a name="requirement_random"></a> [random](#requirement\_random) | 3.4.3 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azuread"></a> [azuread](#provider\_azuread) | 2.28.1 |
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 3.24.0 |
| <a name="provider_null"></a> [null](#provider\_null) | 3.1.1 |
| <a name="provider_random"></a> [random](#provider\_random) | 3.4.3 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azuread_application.this](https://registry.terraform.io/providers/hashicorp/azuread/2.28.1/docs/resources/application) | resource |
| [azuread_service_principal.this](https://registry.terraform.io/providers/hashicorp/azuread/2.28.1/docs/resources/service_principal) | resource |
| [azurerm_key_vault.this](https://registry.terraform.io/providers/hashicorp/azurerm/3.24.0/docs/resources/key_vault) | resource |
| [azurerm_key_vault_access_policy.that](https://registry.terraform.io/providers/hashicorp/azurerm/3.24.0/docs/resources/key_vault_access_policy) | resource |
| [azurerm_key_vault_access_policy.this](https://registry.terraform.io/providers/hashicorp/azurerm/3.24.0/docs/resources/key_vault_access_policy) | resource |
| [azurerm_key_vault_secret.this](https://registry.terraform.io/providers/hashicorp/azurerm/3.24.0/docs/resources/key_vault_secret) | resource |
| [azurerm_kubernetes_cluster.this](https://registry.terraform.io/providers/hashicorp/azurerm/3.24.0/docs/resources/kubernetes_cluster) | resource |
| [azurerm_network_security_group.this](https://registry.terraform.io/providers/hashicorp/azurerm/3.24.0/docs/resources/network_security_group) | resource |
| [azurerm_resource_group.this](https://registry.terraform.io/providers/hashicorp/azurerm/3.24.0/docs/resources/resource_group) | resource |
| [azurerm_subnet.this](https://registry.terraform.io/providers/hashicorp/azurerm/3.24.0/docs/resources/subnet) | resource |
| [azurerm_subnet_network_security_group_association.this](https://registry.terraform.io/providers/hashicorp/azurerm/3.24.0/docs/resources/subnet_network_security_group_association) | resource |
| [azurerm_virtual_network.this](https://registry.terraform.io/providers/hashicorp/azurerm/3.24.0/docs/resources/virtual_network) | resource |
| [null_resource.output_file](https://registry.terraform.io/providers/hashicorp/null/3.1.1/docs/resources/resource) | resource |
| [random_integer.akvname](https://registry.terraform.io/providers/hashicorp/random/3.4.3/docs/resources/integer) | resource |
| [azuread_client_config.current](https://registry.terraform.io/providers/hashicorp/azuread/2.28.1/docs/data-sources/client_config) | data source |
| [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/3.24.0/docs/data-sources/client_config) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aad_certificate_permissions"></a> [aad\_certificate\_permissions](#input\_aad\_certificate\_permissions) | AAD Level Key Vault Permissions for Certificate. | `list(any)` | <pre>[<br>  "Get",<br>  "List",<br>  "Update",<br>  "Create",<br>  "Import"<br>]</pre> | no |
| <a name="input_aad_key_permissions"></a> [aad\_key\_permissions](#input\_aad\_key\_permissions) | AAD Level Key Vault Permissions for Keys. | `list(any)` | <pre>[<br>  "Get",<br>  "List"<br>]</pre> | no |
| <a name="input_aad_secret_permissions"></a> [aad\_secret\_permissions](#input\_aad\_secret\_permissions) | AAD Level Key Vault Permissions for Secrets. | `list(any)` | <pre>[<br>  "Get",<br>  "List",<br>  "Set"<br>]</pre> | no |
| <a name="input_aad_storage_permissions"></a> [aad\_storage\_permissions](#input\_aad\_storage\_permissions) | AAD Level Key Vault Permissions for Storage. | `list(any)` | <pre>[<br>  "Get",<br>  "List",<br>  "Set"<br>]</pre> | no |
| <a name="input_admin_certificate_permissions"></a> [admin\_certificate\_permissions](#input\_admin\_certificate\_permissions) | Admin Level Key Vault Permissions for Certificate. | `list(any)` | <pre>[<br>  "Get",<br>  "List",<br>  "Update",<br>  "Create",<br>  "Import",<br>  "Delete",<br>  "Recover",<br>  "Backup",<br>  "Restore",<br>  "ManageContacts",<br>  "ManageIssuers",<br>  "GetIssuers",<br>  "ListIssuers",<br>  "SetIssuers",<br>  "DeleteIssuers",<br>  "Purge"<br>]</pre> | no |
| <a name="input_admin_key_permissions"></a> [admin\_key\_permissions](#input\_admin\_key\_permissions) | Admin Level Key Vault Permissions for Keys. | `list(any)` | <pre>[<br>  "Get",<br>  "List",<br>  "Delete",<br>  "Purge",<br>  "Update",<br>  "Create",<br>  "Import",<br>  "Recover",<br>  "Backup",<br>  "Restore",<br>  "GetRotationPolicy",<br>  "SetRotationPolicy",<br>  "Rotate",<br>  "Encrypt",<br>  "Decrypt",<br>  "UnwrapKey",<br>  "WrapKey",<br>  "Verify",<br>  "Sign",<br>  "Release"<br>]</pre> | no |
| <a name="input_admin_secret_permissions"></a> [admin\_secret\_permissions](#input\_admin\_secret\_permissions) | Admin Level Key Vault Permissions for Secrets. | `list(any)` | <pre>[<br>  "Backup",<br>  "Delete",<br>  "Get",<br>  "List",<br>  "Purge",<br>  "Recover",<br>  "Restore",<br>  "Set"<br>]</pre> | no |
| <a name="input_admin_storage_permissions"></a> [admin\_storage\_permissions](#input\_admin\_storage\_permissions) | Admin Level Key Vault Permissions for Storage. | `list(any)` | <pre>[<br>  "Get",<br>  "List",<br>  "Set",<br>  "Delete",<br>  "Purge"<br>]</pre> | no |
| <a name="input_akv_prefix"></a> [akv\_prefix](#input\_akv\_prefix) | Keeper for the akv random postfix. Update value to generate new names. | `string` | `"regen"` | no |
| <a name="input_location"></a> [location](#input\_location) | Location to use for the deployment. | `string` | `"eastus"` | no |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | Prefix to use for naming. | `string` | `"akvpoc"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_kube_config"></a> [kube\_config](#output\_kube\_config) | Raw Kube config file to use for access to the cluster. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
