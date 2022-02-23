M = $(shell printf "\033[34;1m▶\033[0m")
PROJECTS := "simple|client"

.PHONY: help
help: ## Prints this help message
	@grep -E '^[a-zA-Z_-]+:.?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

######################
### MAIN FUNCTIONS ###
######################
ifeq ($(@which terraform),"")
$(error $(M) Terraform not available)
endif

.PHONY: checkvars
checkvars: 
ifndef COGNITO_PROJECT
	$(error $(M) COGNITO_PROJECT isn't defined)
else ifneq ($(findstring $(COGNITO_PROJECT),$(PROJECTS)),$(COGNITO_PROJECT))
	$(error $(M) COGNITO_PROJECT isn't one of the available ones ($(PROJECTS)))
endif

.PHONY: clean
clean: ## Clean the terraform project
	$(info $(M) Clean project)
	@find -name ".terraform.lock.hcl" -delete
	@find -type d -name ".terraform" -exec rm -r "{}" \;

.PHONY: init
init: ## Init the terraform project
	@$(MAKE) checkvars

	$(info $(M) Terraform init : $(COGNITO_PROJECT))
	cd $(COGNITO_PROJECT) && terraform init

.PHONY: plan
plan: ## Plan the terraform simple project
	@$(MAKE) checkvars

	$(info $(M) Terraform plan : $(COGNITO_PROJECT))
	cd $(COGNITO_PROJECT) && terraform plan

.PHONY: destroy
destroy: ## Destroy all terraform created objects
	@$(MAKE) checkvars

	$(info $(M) Terraform destroy : $(COGNITO_PROJECT))
	cd $(COGNITO_PROJECT) && terraform destroy

.PHONY: simple_apply
simple_apply: ## Apply only a cognito user_pool
	@$(MAKE) checkvars

	$(info $(M) Creating cloud objects from folder : $(COGNITO_PROJECT))
	cd $(COGNITO_PROJECT) && terraform apply

.DEFAULT_GOAL := help