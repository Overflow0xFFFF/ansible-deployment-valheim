PROJECT_ROOT := $(shell git rev-parse --show-toplevel)

#//////////////////////////////////////////////////////////////////////////////
# TASKS
#//////////////////////////////////////////////////////////////////////////////

.PHONY: galaxy-update
galaxy-update: ## Retrieve roles and collections from Ansible Galaxy.
	@echo "--- Downloading roles"
	@ansible-galaxy install -p thirdparty -r requirements.yml
	@echo "--- Downloading collections"
	@ansible-galaxy collection install -p thirdparty -r requirements.yml

.PHONY: init
init: galaxy-update ## Initialize servers with a base configuration.
	@echo "--- Initializing infrastructure"
	@ansible-playbook --diff playbooks/init.yml

.PHONY: backup
backup: ## Take a backup of a running deployment.
	@echo "--- Backing up deployment"
	@ansible-playbook --diff playbooks/backup.yml

.PHONY: deploy
deploy: galaxy-update ## Deploy service to hosts.
	@echo "--- Deploying deploy.yml"
	@ansible-playbook --diff playbooks/deploy.yml

.PHONY: dry-run
dry-run: galaxy-update ## Dry-run a deployment.
	@echo "--- Dry-running deploy.yml"
	@ansible-playbook --diff --check playbooks/deploy.yml

.PHONY: help
help: ## Show this help message
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "; printf "\nUsage:\n\n"}; {printf "  %-15s %s\n", $$1, $$2}'
	@echo

.DEFAULT_GOAL := help

