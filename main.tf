resource "aws_cognito_user_pool" "pool1" {
  name = "test_terraform_pool1"
}

resource "aws_cognito_user_pool" "pool2" {
  name = "test_terraform_pool2"
}
