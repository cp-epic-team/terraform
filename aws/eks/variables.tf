variable "project" {
  description = "The name of project"
  type = string
}

variable "eks_version" {
  description = "This is the version of the eks cluster"
}

variable "roles" {
  description = "Map containing IAM role ARNs"
  type = object({
    worker_node_role = string
  })
}

variable "private_subnets" {
  description = "Map of private subnets to launch EKS worker nodes"
  type = map(object({
    id = string
  }))
}

variable "desired_size" {
  description = "Desired number of worker nodes"
  type        = number
}

variable "max_size" {
  description = "Maximum number of worker nodes"
  type        = number
}

variable "min_size" {
  description = "Minimum number of worker nodes"
  type        = number
}

variable "max_unavailable" {
  description = "Maximum number of nodes that can be unavailable during update"
  type        = number
  default     = 1
}

variable "ami_type" {
  description = "AMI type for the worker nodes (e.g. AL2_x86_64, AL2_ARM_64)"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type(s) for the worker nodes"
  type        = list(string)
}

variable "capacity_type" {
  description = "Capacity type (ON_DEMAND or SPOT)"
  type        = string
}
