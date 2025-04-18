a modification was done on the terraform provisioning python script to include;
An IAM role (eksClusterRole)

A trust policy so EKS can assume the role

Attaches the AmazonEKSClusterPolicy so EKS can function properly
