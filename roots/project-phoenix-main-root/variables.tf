variable "cluster_version" {
  type        = string
  description = "Version of the Kubernetes Cluster "
}

variable "subnets_ids" {
  type        = list(string)
  description = "Subnets IDs to launch EKS cluster and worker nodes"
}

variable "services_cidr" {
  type        = string
  description = "CIDR block for ClusterIP services of Kubernetes"
}

variable "vpc_id" {
  type        = string
  description = "VPC to launch EKS cluster and worker nodes"
}

variable "stage" {
  type = string
}


variable "project" {
  type = string
}

variable "workers_desired" {
  type = number
}

variable "workers_min" {
  type = number
}

variable "workers_max" {
  type = number
}

variable "workers_pricing_type" {
  type = string

}

variable "instance_types" {
  type = list(string)
}

variable "gitHubActionsAppCIrole" {
  type = string
  
}