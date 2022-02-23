resource "aws_cognito_user_pool" "client" {
  name = "test_terraform_client"
}

resource "aws_cognito_user_pool_client" "application1" {
  name = "application1"

  user_pool_id = aws_cognito_user_pool.client.id
}
