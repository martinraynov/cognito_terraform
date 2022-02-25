output "user_pool_id" {
  value = aws_cognito_user_pool.full.id
  description = "The id of the generated pool."
}

output "client_id" {
  value = aws_cognito_user_pool_client.application1.id
  description = "The id of the generated client."
}

output "client_secret" {
  value = aws_cognito_user_pool_client.application1.client_secret
  description = "The secret of the generated client."
  sensitive = true
}