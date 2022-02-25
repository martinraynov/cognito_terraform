
resource "aws_cognito_user_pool_ui_customization" "navitia" {
  client_id = aws_cognito_user_pool_client.application1.id

  css        = ".label-customizable {font-weight: 400;}"
  image_file = filebase64("navitia-blue@3x.png")

  # Refer to the aws_cognito_user_pool_domain resource's
  # user_pool_id attribute to ensure it is in an 'Active' state
  user_pool_id = aws_cognito_user_pool_domain.main.user_pool_id
}
