# EKS Cluster Creation
resource "aws_eks_cluster" "eks_cluster" {
  name     = "${var.project}-cluster"  
  role_arn = var.roles.cluster_role
  version  = var.eks_version 

  vpc_config {
    subnet_ids = concat(
      values(var.private_subnets)[*].id,
    )
  }

  tags = {
    Name = "${var.project}-cluster"
  }
}

resource "aws_eks_node_group" "Node_group" {
  cluster_name    = aws_eks_cluster.eks_cluster.name  
  node_group_name = "eks_node_group"  
  node_role_arn   = var.roles.worker_node_role
  subnet_ids      = values(var.private_subnets)[*].id 

  scaling_config {
    desired_size = var.desired_size 
    max_size     = var.max_size      
    min_size     = var.min_size      
  }

  update_config {
    max_unavailable = var.max_unavailable 
  }

  ami_type        = var.ami_type  
  instance_types  = var.instance_type  
  capacity_type   = var.capacity_type

  tags = {
    Name = "${var.project}-cluster"
  }
}