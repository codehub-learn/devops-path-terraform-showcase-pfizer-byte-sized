## Before we start test that we have the mandatory executables available
EXECUTABLES = git terraform

.ONESHELL:

K := $(foreach exec,$(EXECUTABLES), \
$(if $(shell which $(exec)),some string,$(error "No $(exec) in PATH, consider apt-get install $(exec)")))
ifndef TARGET
	TF_TARGET =
else
	TF_TARGET = -target $(TARGET)
endif
.PHONY: plan
TERRAFORM ?= terraform
TF_VERSION = $(shell $(TERRAFORM) --version | head -1)
ACCOUNT ?= athtech
ENV_TYPE ?= dev
VPC_NAME ?= demovpc
TARGET_PATH = accounts/$(ACCOUNT)/$(ENV_TYPE)/$(VPC_NAME)

check_vars:
ifndef AWS_PROFILE
    $(info "AWS_PROFILE is not set")
endif
	$(info "Using $(TF_VERSION)")
	$(info "Target_command: $(TF_TARGET)")
	$(info "Account: $(ACCOUNT)")
	$(info "Env Type: $(ENV_TYPE)")
	$(info "VPC Name: $(VPC_NAME)")


init:
	@echo "initialize remote state file"
	mkdir -p $(TARGET_PATH)
	cd $(TARGET_PATH) 
	rm -rf .terraform/modules/ 
	$(TERRAFORM) init -reconfigure

fmt:
	@echo "Formating files"
	cd $(TARGET_PATH)
	$(TERRAFORM) fmt -recursive

validate: fmt init
	@echo "running terraform validate"
	cd $(TARGET_PATH) 
	$(TERRAFORM) validate

plan: validate
	@echo "running terraform plan"
	cd $(TARGET_PATH) 
	$(TERRAFORM) plan $(TF_TARGET)

apply: validate
	@echo "running terraform apply"
	cd $(TARGET_PATH) 
	$(TERRAFORM) apply -auto-approve $(TF_TARGET)

plan-destroy: validate
	@echo "running terraform plan -destroy"
	cd $(TARGET_PATH) 
	$(TERRAFORM) plan -destroy $(TF_TARGET)

destroy: init
	@echo "running terraform destroy"
	cd $(TARGET_PATH) 
	$(TERRAFORM) destroy $(TF_TARGET)

connect:
	@echo "running terraform to bastion dns"
	cd $(TARGET_PATH)
	$(TERRAFORM) output bastion_public_dns

ssh_key:
	@echo #"running terraform to print ssh key"
	cd $(TARGET_PATH)
	$(TERRAFORM) output admin_ssh_key | grep -v EOT | tee ssh_key >/dev/null
	chmod 600 ssh_key
	mv ssh_key ~/.ssh/$(ACCOUNT)-$(ENV_TYPE)-$(VPC_NAME)-key
