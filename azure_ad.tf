# Create AAD Application for Workload Identity
resource "azuread_application" "this" {
  display_name = "ThisApp"
  owners       = [data.azuread_client_config.current.object_id]
}

# Create service principal associated with AAD Application
resource "azuread_service_principal" "this" {
  application_id               = azuread_application.this.application_id
  app_role_assignment_required = false
  owners                       = [data.azuread_client_config.current.object_id]

  feature_tags {
    enterprise = true
    gallery    = true
  }
}