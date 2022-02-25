resource "aws_cognito_user_group" "admin" {
  name         = "admin-group"
  user_pool_id = aws_cognito_user_pool.full.id
  description  = "Managed by Terraform"
  precedence   = 42
  # role_arn     = aws_iam_role.group_role.arn
}
