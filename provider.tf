terraform {
  required_version = ">=1.2.7"
  backend "remote" {
    # The name of your Terraform Cloud organization.
    organization = "Rod-training"
    # The name of the Terraform Cloud workspace to store Terraform state files in.
    workspaces {
      name = "tf_akv_aks_demo"
    }
  }

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.24.0"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "2.28.1"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.4.3"
    }
    /* null = {
      source  = "hashicorp/null"
      version = "3.1.1"
    } */
    tls = {
      source  = "hashicorp/tls"
      version = "4.0.3"
    }
  }
}

provider "tls" {}
provider "random" {}
provider "azuread" {}
provider "azurerm" {
  features {}
}
# null was formerly used as part of create_env_var_script.tf
# Which has been deprecated since the move to TF Cloud
/* provider "null" {} */