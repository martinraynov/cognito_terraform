resource "aws_cognito_user_pool_client" "application1" {
  name = "application1"

  user_pool_id = var.env.pool_id
}
