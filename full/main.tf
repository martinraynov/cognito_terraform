resource "aws_cognito_user_pool" "full" {
  name = "test-terraform-full"
  alias_attributes         = ["email"]
  auto_verified_attributes = ["email"]

  account_recovery_setting {
    recovery_mechanism {
      name     = "verified_email"
      priority = 1
    }
  }

  username_configuration {
    case_sensitive = false
  }

  tags = {
    Owner       = "mraynov"
    Environment = "dev"
    Terraform   = true
  }

  admin_create_user_config {
    allow_admin_create_user_only = true
    # invite_message_template {
    #   email_message = "Hello !!!! Username: {username} Password: {####}"
    #   email_subject = "Subject of the email"
    # }
  }

  # email_configuration {
  #   email_sending_account = "COGNITO_DEFAULT"
  #   from_email_address = "martin@yopmail.com"
  #   reply_to_email_address = "noreply@yopmail.com"
  # }

  password_policy {
    minimum_length    = 10
    require_lowercase = true
    require_numbers   = true
    require_symbols   = true
    require_uppercase = true
  }

  schema {
    name                     = "logo"
    attribute_data_type      = "String"
    developer_only_attribute = false
    mutable                  = false  # false for "sub"
    required                 = false # true for "sub"
    string_attribute_constraints {   # if it is a string
      min_length = 0                 # 10 for "birthdate"
      max_length = 2048              # 10 for "birthdate"
    }
  }

}

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

resource "aws_cognito_user_pool_domain" "main" {
  domain = aws_cognito_user_pool.full.name
  user_pool_id = aws_cognito_user_pool.full.id
}

resource "aws_cognito_resource_server" "resource" {
  identifier = "navitia-base"
  name       = "Navitia Base"

  scope {
    scope_name        = "group_membership.read"
    scope_description = "Read groups"
  }

  user_pool_id = aws_cognito_user_pool.full.id
}

resource "aws_cognito_user_pool_ui_customization" "navitia" {
  client_id = aws_cognito_user_pool_client.application1.id

  css        = ".label-customizable {font-weight: 400;}"
  image_file = filebase64("navitia-blue@3x.png")

  # Refer to the aws_cognito_user_pool_domain resource's
  # user_pool_id attribute to ensure it is in an 'Active' state
  user_pool_id = aws_cognito_user_pool_domain.main.user_pool_id
}

resource "aws_cognito_user_group" "admin" {
  name         = "admin-group"
  user_pool_id = aws_cognito_user_pool.full.id
  description  = "Managed by Terraform"
  precedence   = 42
  # role_arn     = aws_iam_role.group_role.arn
}

resource "aws_cognito_user" "admin" {
  user_pool_id = aws_cognito_user_pool.full.id
  username = "admin"
  attributes = {
    logo = "logo.png"
    email = "admin@yopmail.com"
    email_verified = true
  }
}