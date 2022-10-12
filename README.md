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
| <a name="requirement_random"></a> [random](#requirement\_random) | 3.4.3 |
| <a name="requirement_tls"></a> [tls](#requirement\_tls) | 4.0.3 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azuread"></a> [azuread](#provider\_azuread) | 2.28.1 |
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 3.24.0 |
| <a name="provider_random"></a> [random](#provider\_random) | 3.4.3 |
| <a name="provider_tls"></a> [tls](#provider\_tls) | 4.0.3 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azuread_application.this](https://registry.terraform.io/providers/hashicorp/azuread/2.28.1/docs/resources/application) | resource |
| [azuread_service_principal.this](https://registry.terraform.io/providers/hashicorp/azuread/2.28.1/docs/resources/service_principal) | resource |
| [azurerm_bastion_host.that](https://registry.terraform.io/providers/hashicorp/azurerm/3.24.0/docs/resources/bastion_host) | resource |
| [azurerm_key_vault.this](https://registry.terraform.io/providers/hashicorp/azurerm/3.24.0/docs/resources/key_vault) | resource |
| [azurerm_key_vault_access_policy.that](https://registry.terraform.io/providers/hashicorp/azurerm/3.24.0/docs/resources/key_vault_access_policy) | resource |
| [azurerm_key_vault_access_policy.this](https://registry.terraform.io/providers/hashicorp/azurerm/3.24.0/docs/resources/key_vault_access_policy) | resource |
| [azurerm_key_vault_secret.this](https://registry.terraform.io/providers/hashicorp/azurerm/3.24.0/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.vm_ssh_key](https://registry.terraform.io/providers/hashicorp/azurerm/3.24.0/docs/resources/key_vault_secret) | resource |
| [azurerm_kubernetes_cluster.this](https://registry.terraform.io/providers/hashicorp/azurerm/3.24.0/docs/resources/kubernetes_cluster) | resource |
| [azurerm_linux_virtual_machine.this](https://registry.terraform.io/providers/hashicorp/azurerm/3.24.0/docs/resources/linux_virtual_machine) | resource |
| [azurerm_network_interface.this](https://registry.terraform.io/providers/hashicorp/azurerm/3.24.0/docs/resources/network_interface) | resource |
| [azurerm_network_security_group.this](https://registry.terraform.io/providers/hashicorp/azurerm/3.24.0/docs/resources/network_security_group) | resource |
| [azurerm_public_ip.that](https://registry.terraform.io/providers/hashicorp/azurerm/3.24.0/docs/resources/public_ip) | resource |
| [azurerm_public_ip.this](https://registry.terraform.io/providers/hashicorp/azurerm/3.24.0/docs/resources/public_ip) | resource |
| [azurerm_resource_group.this](https://registry.terraform.io/providers/hashicorp/azurerm/3.24.0/docs/resources/resource_group) | resource |
| [azurerm_role_assignment.assign-vm-role](https://registry.terraform.io/providers/hashicorp/azurerm/3.24.0/docs/resources/role_assignment) | resource |
| [azurerm_subnet.bastion](https://registry.terraform.io/providers/hashicorp/azurerm/3.24.0/docs/resources/subnet) | resource |
| [azurerm_subnet.this](https://registry.terraform.io/providers/hashicorp/azurerm/3.24.0/docs/resources/subnet) | resource |
| [azurerm_subnet_network_security_group_association.this](https://registry.terraform.io/providers/hashicorp/azurerm/3.24.0/docs/resources/subnet_network_security_group_association) | resource |
| [azurerm_virtual_machine_extension.aad_ssh_login](https://registry.terraform.io/providers/hashicorp/azurerm/3.24.0/docs/resources/virtual_machine_extension) | resource |
| [azurerm_virtual_network.this](https://registry.terraform.io/providers/hashicorp/azurerm/3.24.0/docs/resources/virtual_network) | resource |
| [random_integer.akvname](https://registry.terraform.io/providers/hashicorp/random/3.4.3/docs/resources/integer) | resource |
| [tls_private_key.ssh_key](https://registry.terraform.io/providers/hashicorp/tls/4.0.3/docs/resources/private_key) | resource |
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
| <a name="input_admin_group_object_ids"></a> [admin\_group\_object\_ids](#input\_admin\_group\_object\_ids) | The group(s) that should be given AKS Admin Role on the cluster. | `list(any)` | `null` | no |
| <a name="input_admin_key_permissions"></a> [admin\_key\_permissions](#input\_admin\_key\_permissions) | Admin Level Key Vault Permissions for Keys. | `list(any)` | <pre>[<br>  "Get",<br>  "List",<br>  "Delete",<br>  "Purge",<br>  "Update",<br>  "Create",<br>  "Import",<br>  "Recover",<br>  "Backup",<br>  "Restore",<br>  "GetRotationPolicy",<br>  "SetRotationPolicy",<br>  "Rotate",<br>  "Encrypt",<br>  "Decrypt",<br>  "UnwrapKey",<br>  "WrapKey",<br>  "Verify",<br>  "Sign",<br>  "Release"<br>]</pre> | no |
| <a name="input_admin_secret_permissions"></a> [admin\_secret\_permissions](#input\_admin\_secret\_permissions) | Admin Level Key Vault Permissions for Secrets. | `list(any)` | <pre>[<br>  "Backup",<br>  "Delete",<br>  "Get",<br>  "List",<br>  "Purge",<br>  "Recover",<br>  "Restore",<br>  "Set"<br>]</pre> | no |
| <a name="input_admin_storage_permissions"></a> [admin\_storage\_permissions](#input\_admin\_storage\_permissions) | Admin Level Key Vault Permissions for Storage. | `list(any)` | <pre>[<br>  "Get",<br>  "List",<br>  "Set",<br>  "Delete",<br>  "Purge"<br>]</pre> | no |
| <a name="input_aks_admin_disabled"></a> [aks\_admin\_disabled](#input\_aks\_admin\_disabled) | Disables AKS local admin account if set to true. | `bool` | `false` | no |
| <a name="input_akv_prefix"></a> [akv\_prefix](#input\_akv\_prefix) | Keeper for the akv random postfix. Update value to generate new names. | `string` | `"regen"` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Environment value to use for tagging. | `string` | `"dev"` | no |
| <a name="input_location"></a> [location](#input\_location) | Location to use for the deployment. | `string` | `"eastus"` | no |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | Prefix to use for naming. | `string` | `"akvpoc"` | no |
| <a name="input_private_aks_cluster"></a> [private\_aks\_cluster](#input\_private\_aks\_cluster) | Disables AKS API Server's public IP if set to true. | `bool` | `false` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_bastion_connect_command_line"></a> [bastion\_connect\_command\_line](#output\_bastion\_connect\_command\_line) | Command line to connect to the VM via the Bastion using AAD SSO. |
| <a name="output_kube_config"></a> [kube\_config](#output\_kube\_config) | Raw Kube config file to use for access to the cluster. |
| <a name="output_private_key_retrieval_command_line"></a> [private\_key\_retrieval\_command\_line](#output\_private\_key\_retrieval\_command\_line) | Command line to retrieve private key. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
