create-cluster:
	kind create cluster --config infra/cluster/kind-config.yaml
	kubectl get nodes
	docker ps