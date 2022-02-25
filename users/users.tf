resource "aws_cognito_user" "admin" {
  user_pool_id = var.env.pool_id
  username = "admin"
  attributes = {
    email = "admin@yopmail.com"
    email_verified = true
  }
}
