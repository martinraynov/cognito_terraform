resource "aws_cognito_user_pool_client" "application1" {
  name = "application1"
  user_pool_id = aws_cognito_user_pool.full.id

  generate_secret = true
  prevent_user_existence_errors = "ENABLED"

  supported_identity_providers = [ "COGNITO" ]
  allowed_oauth_flows = [
    "code"
  ]
  allowed_oauth_scopes = [
    "profile",
    "email",
    "openid"
  ]

  callback_urls = [
    "https://php.local.io/aws-cognito/cognito-application-1.php"
  ]

  logout_urls = [
    "https://php.local.io/aws-cognito/logout-cognito-application-1.php"
  ]
  token_validity_units {
    access_token = "minutes"
    id_token = "minutes"
    refresh_token = "days"
  }

  access_token_validity = 10
  id_token_validity = 10
  refresh_token_validity = 10

  explicit_auth_flows = [
    # Default
    "ALLOW_REFRESH_TOKEN_AUTH",
    "ALLOW_CUSTOM_AUTH",
    "ALLOW_USER_SRP_AUTH", 
    # Additional
    "ALLOW_ADMIN_USER_PASSWORD_AUTH",
    "ALLOW_USER_PASSWORD_AUTH"
  ]

  read_attributes = [
    "custom:logo"
  ]

  write_attributes = [
    "custom:logo"
  ]
}