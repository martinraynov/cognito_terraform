resource "aws_cognito_resource_server" "resource" {
  identifier = "navitia-base"
  name       = "Navitia Base"

  scope {
    scope_name        = "group_membership.read"
    scope_description = "Read groups"
  }

  user_pool_id = aws_cognito_user_pool.full.id
}
