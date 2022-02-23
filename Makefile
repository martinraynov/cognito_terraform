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

### GLOBAL
.PHONY: clean
clean: ## Init the terraform project
	$(info $(M) Clean project)
	find -name ".terraform.lock.hcl" -delete
	find -type d -name ".terraform" -exec rm -r "{}" \;


### SIMPLE
.PHONY: simple_init
simple_init: ## Init the terraform project
	$(info $(M) Terraform init)
	cd simple && terraform init

.PHONY: simple_plan
simple_plan: ## Plan the terraform project
	$(info $(M) Terraform plan)
	cd simple && terraform plan

.PHONY: simple_destroy
simple_destroy: ## Destroy all terraform created objects
	$(info $(M) Terraform destroy)
	cd simple && terraform destroy

.PHONY: simple_apply
simple_apply: ## Apply only a cognito user_pool
	$(info $(M) Creating user pool : kisio_test_terraform)
	cd simple && terraform apply

### CLIENT
.PHONY: client_init
client_init: ## Init the terraform project
	$(info $(M) Terraform init)
	cd client && terraform init

.PHONY: client_plan
client_plan: ## Plan the terraform project
	$(info $(M) Terraform plan)
	cd client && terraform plan

.PHONY: client_destroy
client_destroy: ## Destroy all terraform created objects
	$(info $(M) Terraform destroy)
	cd client && terraform destroy

.PHONY: client_apply
client_apply: ## Apply a cognito user_pool with a client
	$(info $(M) Creating user pool : kisio_test_terraform)
	cd client && terraform apply

.DEFAULT_GOAL := help