M = $(shell printf "\033[34;1m▶\033[0m")

.PHONY: help
help: ## Prints this help message
	@grep -E '^[a-zA-Z_-]+:.?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

######################
### MAIN FUNCTIONS ###
######################
ifeq ($(@which terraform),"")
$(error $(M) Terraform not available)
endif

.PHONY: init
init: ## Init the terraform project
	$(info $(M) Terraform init)
	terraform init

.PHONY: plan
plan: ## Plan the terraform project
	$(info $(M) Terraform plan)
	terraform plan

.PHONY: destroy
destroy: ## Destroy all terraform created objects
	$(info $(M) Terraform destroy)
	terraform destroy

.PHONY: simple
simple: ## Apply a simple cognito user_pool
	$(info $(M) Creating user pool : kisio_test_terraform)
	terraform apply -target="aws_cognito_user_pool.pool1"

.PHONY: simple_bis
simple_bis: ## Apply a simple cognito user_pool
	$(info $(M) Creating user pool : kisio_test_terraform)
	terraform apply -target="aws_cognito_user_pool.pool2"

.DEFAULT_GOAL := help