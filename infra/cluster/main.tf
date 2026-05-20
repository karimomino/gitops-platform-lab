variable "cluster_name" {
  description = "The name of the cluster"
  type        = string
}

variable "kubeconfig_path" {
  description = "The path for the kubeconfig file"
  type        = string
}

resource "kind_cluster" "gitops" {
    name = var.cluster_name
    kubeconfig_path = pathexpand(var.kubeconfig_path)
    wait_for_ready = true

    kind_config {
        kind        = "Cluster"
        api_version = "kind.x-k8s.io/v1alpha4"

        node {
            role = "control-plane"
            
            kubeadm_config_patches = [
                "kind: InitConfiguration\nnodeRegistration:\n  kubeletExtraArgs:\n    node-labels: \"ingress-ready=true\"\n"
            ]

            extra_port_mappings {
                container_port = 80
                host_port      = 80
            }

            extra_port_mappings {
                container_port = 443
                host_port      = 443
            }
        }

        node {
            role = "worker"
        }

        node {
            role = "worker"
        }
    }
}

output "cluster_name" {
  value = kind_cluster.gitops.name
  description = "The name of the cluster."
}

output "name" {
  value = kind_cluster.gitops.kubeconfig_path
  description = "The path for the kubeconfig file."
}