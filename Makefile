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

.PHONY: simple
simple: ## Creates a simple cognito user_pool
	$(info $(M) Creating user pool : ${USER_POOL})

.DEFAULT_GOAL := help