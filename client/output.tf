output "user_pool_id" {
  value = var.env.pool_id
  description = "The id of the used pool."
}

output "client_id_1" {
  value = aws_cognito_user_pool_client.application1.id
  description = "The id of the generated client."
}

output "client_secret_1" {
  value = aws_cognito_user_pool_client.application1.client_secret
  description = "The secret of the generated client."
  sensitive = true
}

output "client_id_2" {
  value = aws_cognito_user_pool_client.application2.id
  description = "The id of the generated client."
}

output "client_secret_2" {
  value = aws_cognito_user_pool_client.application2.client_secret
  description = "The secret of the generated client."
  sensitive = true
}