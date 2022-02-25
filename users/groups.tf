resource "aws_cognito_user_group" "admin" {
  name         = "admin-group"
  user_pool_id = var.env.pool_id
  description  = "Managed by Terraform"
  precedence   = 42
  # role_arn     = aws_iam_role.group_role.arn
}
