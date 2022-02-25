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
