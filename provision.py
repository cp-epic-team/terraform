import os
import subprocess

# Define Terraform configurations for AWS EKS and GCP GKE
terraform_aws_eks = """
provider "aws" {
  region = "us-west-2"
}

resource "aws_iam_role" "eks_role" {
  name = "eksClusterRole"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "eks.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "eks_AmazonEKSClusterPolicy" {
  role       = aws_iam_role.eks_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}

resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "subnet" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-west-2a"
}

resource "aws_eks_cluster" "k8s" {
  name     = "my-eks-cluster"
  role_arn = aws_iam_role.eks_role.arn

  vpc_config {
    subnet_ids = [aws_subnet.subnet.id]
  }
}
"""

terraform_gcp_gke = """
provider "google" {
  project = "my-gcp-project"
  region  = "us-central1"
}

resource "google_container_cluster" "k8s" {
  name     = "my-gke-cluster"
  location = "us-central1"

  network = "default"
  subnetwork = "default"
}
"""

# Write Terraform configurations to files
with open("aws_eks.tf", "w") as f:
    f.write(terraform_aws_eks)

with open("gcp_gke.tf", "w") as f:
    f.write(terraform_gcp_gke)

# Initialize and apply Terraform configurations
def run_terraform(directory):
    subprocess.run(["terraform", "init"], cwd=directory)
    subprocess.run(["terraform", "apply", "-auto-approve"], cwd=directory)

# Create directories for AWS and GCP Terraform configurations
os.makedirs("aws", exist_ok=True)
os.makedirs("gcp", exist_ok=True)

# Move Terraform files to respective directories
os.rename("aws_eks.tf", "aws/aws_eks.tf")
os.rename("gcp_gke.tf", "gcp/gcp_gke.tf")

# Run Terraform for AWS and GCP
run_terraform("aws")
run_terraform("gcp")