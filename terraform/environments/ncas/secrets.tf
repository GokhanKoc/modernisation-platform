# Get modernisation account id from ssm parameter
data "aws_ssm_parameter" "modernisation_platform_account_id" {
  name = "modernisation_platform_account_id"
}

# Get secret by arn for environment management
data "aws_secretsmanager_secret" "environment_management" {
  provider = aws.modernisation-platform
  name     = "environment_management"
}

# Get latest secret value with ID from above. This secret stores account IDs for the Modernisation Platform sub-accounts
data "aws_secretsmanager_secret_version" "environment_management" {
  provider  = aws.modernisation-platform
  secret_id = data.aws_secretsmanager_secret.environment_management.id
}

resource "aws_secretsmanager_secret" "ncas_tactical_products_db_secrets" {
  name = "tactical-products-db-secrets"
}

resource "aws_secretsmanager_secret_version" "ncas_tactical_products_db_secrets_version" {
  secret_id     = aws_secretsmanager_secret.ncas_tactical_products_db_secrets.id
  secret_string = "{}"  # Empty JSON object as the secret value
}