resource "aws_cognito_user_pool_client" "application2" {
  name = "application2"

  user_pool_id = var.env.pool_id
}
