resource "aws_cognito_user" "admin" {
  user_pool_id = aws_cognito_user_pool.full.id
  username = "admin"
  attributes = {
    logo = "logo.png"
    email = "admin@yopmail.com"
    email_verified = true
  }
}