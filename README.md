Terraform v.1

AWS ECS Fargate Deployment Infrastructure (by Bonaventure Iwunor)

This Terraform project, created and maintained by Bonaventure Iwunor, provisions a scalable and production-ready containerized application infrastructure on Amazon Web Services (AWS) using ECS Fargate, ECR, ALB, and CloudWatch, all configured under a custom Virtual Private Cloud (VPC).

	Author: Bonaventure Iwunor
Expertise: Cloud Engineer, Legal Advisor, Full-Stack Developer
Project Scope: Automate secure, scalable ECS deployments with high availability and observability.

Overview

This project deploys a complete AWS infrastructure for a containerized Node.js (or any Docker-based) app, using the following services:
	•	Elastic Container Registry (ECR) – to store Docker images.
	•	Elastic Container Service (ECS) – to orchestrate Fargate containers.
	•	Application Load Balancer (ALB) – for HTTP access to containers.
	•	IAM Roles & Policies – for task execution and permissions.
	•	VPC, Subnets, and Route Tables – for isolated networking.
	•	CloudWatch Logs – to monitor and trace logs.
	•	Security Groups – to control network access.

Architecture

The Terraform configuration (main.tf) automates the following resources:

                         Internet
                            |
                      [ Application Load Balancer ]
                       /                            \
             [Public Subnet 1]                [Public Subnet 2]
                 |                                 |
       [ ECS Task + Service ]             [ ECS Task + Service ]
                 \                                /
                    [ ECS Cluster + Fargate ]
                          |
                      [ ECR Repo ]
                          |
                    [ Docker Image ]

Key Components

main.tf

Defines all the AWS infrastructure components.
	•	Provider: AWS configured with a variable region (var.aws_region)
	•	ECR: Container image registry
	•	ECS Cluster: Logical group for services
	•	Task Definition: Fargate-compatible task config (CPU, memory, image, logs, env)
	•	Service: Ensures specified number of container instances
	•	ALB & Target Group: Distributes traffic to ECS tasks
	•	IAM Role: Task execution permissions
	•	VPC, Subnets, Route Tables, IGW: Fully functional networking
	•	CloudWatch Log Group: Central logging
	•	Security Group: Allows TCP traffic on port 5000
	•	Outputs: ALB DNS and ECR URL

variables.tf

Parameterizes the deployment:

Variable	Description	Default
aws_region	AWS region to deploy	us-east-1
app_name	Name prefix for all resources	app-name
app_count	Number of ECS tasks to run	1
container_cpu	CPU units for ECS task (256 = 0.25 vCPU)	256
container_memory	Memory in MiB	512

How to Use

✅ Prerequisites
	•	Terraform v1.0+
	•	AWS CLI configured
	•	AWS account with access to ECS, EC2, IAM, ECR, CloudWatch, and VPC services

⚙️ Deployment Steps
	1.	Clone the repository

git clone https://github.com/YOUR_GITHUB/ecs-fargate-infra.git
cd ecs-fargate-infra


	2.	Initialize Terraform

terraform init


	3.	Customize variables (optional)
Create a terraform.tfvars file to override defaults:

aws_region     = "us-east-1"
app_name       = "bonaventure-app"
app_count      = 2
container_cpu  = "512"
container_memory = "1024"


	4.	Run Terraform Plan

terraform plan


	5.	Apply to provision infrastructure

terraform apply


	6.	Get Load Balancer DNS

terraform output alb_dns_name


	7.	Deploy your Docker image to ECR
(Tag, push your image using AWS CLI and Docker)

aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin <ecr-url>
docker tag my-app:latest <ecr-url>:latest
docker push <ecr-url>:latest

Outputs
	•	ecr_repository_url – The URL to push your Docker image.
	•	alb_dns_name – Access your app via this DNS name.

Security Considerations
	•	All traffic is allowed via port 5000. Restrict this in production via aws_security_group.
	•	Only Fargate services use IAM roles with AmazonECSTaskExecutionRolePolicy.
	•	Uses public subnets; for internal/private use, adapt networking accordingly.

Author & License

Author: Bonaventure Iwunor
GitHub: biwunor
LinkedIn: linkedin.com/in/bonaventureiwunor
Domain: bonaventure.org.ng

License: MIT License

	For business partnerships, engineering consulting, or cloud-native deployment inquiries, reach out through the contact page on my site or via GitHub.


Version v.2... loading...
