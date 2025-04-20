output "roles" {
  description = "A collection of EKS-related IAM roles"
  value = {
    cluster_role               = aws_iam_role.cluster_role.arn
    worker_node_role           = aws_iam_role.worker_node_role.arn
  }
}


