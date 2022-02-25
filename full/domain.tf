resource "aws_cognito_user_pool_domain" "main" {
  domain = aws_cognito_user_pool.full.name
  user_pool_id = aws_cognito_user_pool.full.id
}
