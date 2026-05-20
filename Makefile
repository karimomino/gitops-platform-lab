# Override if tofu is not on PATH, e.g. TOFU_CMD_PATH=/usr/local/bin/tofu
TOFU_CMD_PATH		?=	tofu

TOFU_DIR			?=	infra/cluster
TOFU_VAR_FILE		?=	variables.tfvars
.DEFAULT_GOAL		= help

.PHONY: init plan apply destroy create-cluster help


help:
	@echo "Available targets:"
	@echo "  init            Initialize OpenTofu (download providers)"
	@echo "  plan            Plan cluster changes"
	@echo "  apply           Apply cluster changes (creates/updates cluster)"
	@echo "  create-cluster  Create cluster and verify it's running"
	@echo "  destroy         Tear down the cluster and remove state"

create-cluster: plan apply
	kubectl get nodes
	docker ps --filter "label=io.x-k8s.kind.cluster"

destroy:
	$(TOFU_CMD_PATH) -chdir=$(TOFU_DIR) destroy -var-file=$(TOFU_VAR_FILE) -auto-approve
	rm -f $(TOFU_DIR)/tfplan

init:
	$(TOFU_CMD_PATH) -chdir=$(TOFU_DIR) init

plan:
	$(TOFU_CMD_PATH) -chdir=$(TOFU_DIR) plan -var-file=$(TOFU_VAR_FILE) -out=tfplan

apply:
	$(TOFU_CMD_PATH) -chdir=$(TOFU_DIR) apply tfplan