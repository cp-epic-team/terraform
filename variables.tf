variable "aws_region" {
  description = "AWS region to deploy resources"
  default     = "us-east-1"
}

variable "app_name" {
  description = "Name of the application"
  default     = "app-name"
}

variable "app_count" {
  description = "Number of instances to launch"
  default     = 1
}

variable "container_cpu" {
  description = "CPU units for the container"
  default     = "256"
}

variable "container_memory" {
  description = "Memory for the container"
  default     = "512"
}