# TF_AKS_AKV
Just playing around with AKS and the AKV CSI driver along with logging into VMs via bastion using native AAD SSO

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
| <a name="input_akv_prefix"></a> [akv\_prefix](#input\_akv\_prefix) | Keeper for the akv random postfix. Update value to generate new names. | `string` | `"regen"` | no |
| <a name="input_location"></a> [location](#input\_location) | Location to use for the deployment. | `string` | `"eastus"` | no |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | Prefix to use for naming. | `string` | `"akvpoc"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_kube_config"></a> [kube\_config](#output\_kube\_config) | Raw Kube config file to use for access to the cluster. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
