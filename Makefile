KIND				=	kind #incase kind is not in the path, and you want to define your own path to kind
CLUSTER_NAME		=	gitops
KIND_CONFIG_PATH	=	infra/cluster/kind-config.yaml

create-cluster:
	$(KIND) create cluster --name $(CLUSTER_NAME) --config $(KIND_CONFIG_PATH)
	kubectl get nodes
	docker ps

delete-cluster:
	$(KIND) delete cluster --name $(CLUSTER_NAME)