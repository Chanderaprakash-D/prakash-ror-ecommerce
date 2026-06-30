# Ruby on Rails E-Commerce Application on AWS using Terraform

## Project Overview

This project demonstrates a production-ready Ruby on Rails E-Commerce
application deployed on **AWS** using **Terraform**, **Docker**,
**Amazon ECS (EC2 Launch Type)**, **Amazon RDS**, **CodePipeline**,
**CodeBuild**, **CloudWatch**, and **Route 53**.

The infrastructure is fully provisioned using **Terraform** and the
application deployment is automated through **AWS CI/CD**.

------------------------------------------------------------------------

# Architecture

``` text
GitHub
   │
   ▼
CodePipeline
   │
   ▼
CodeBuild
   │
   ▼
Docker Image
   │
   ▼
Amazon ECR
   │
   ▼
Amazon ECS (EC2)
   │
   ▼
Application Load Balancer
   │
   ▼
Route53 + ACM
   │
   ▼
https://shop.prakashweb.online
   │
   ▼
Ruby on Rails
   │
   ▼
Amazon RDS
```

------------------------------------------------------------------------

# AWS Services Used

-   Terraform
-   VPC
-   Public & Private Subnets
-   Internet Gateway
-   NAT Gateway
-   Security Groups
-   ECS (EC2 Launch Type)
-   Docker
-   Amazon ECR
-   Amazon RDS (MySQL)
-   Application Load Balancer
-   Route53
-   ACM
-   CodePipeline
-   CodeBuild
-   CloudWatch
-   IAM
-   Auto Scaling Group

------------------------------------------------------------------------

# CI/CD Workflow

``` text
GitHub
   │
   ▼
CodePipeline
   │
   ▼
CodeBuild
   │
   ▼
Docker Build
   │
   ▼
Push Image to ECR
   │
   ▼
Generate imagedefinitions.json
   │
   ▼
ECS Deploy
   │
   ▼
Rolling Deployment
```

------------------------------------------------------------------------

# CloudWatch Monitoring

CloudWatch Agent runs **inside the Docker container** and pushes:

-   Rails Production Logs
-   Puma Logs
-   Application Error Logs

Each log is stored in a separate CloudWatch Log Stream.

------------------------------------------------------------------------

# Auto Scaling

-   Auto Scaling Group maintains ECS EC2 instances.
-   ECS Service can be configured to scale tasks based on CPU
    utilization.
-   Reduces infrastructure cost during low traffic.
-   Improves availability during high traffic.

------------------------------------------------------------------------

# Screenshots

Create a folder named **screenshots** in the repository.

``` text
screenshots/
├── 01-vpc.png
├── 02-subnets.png
├── 03-rds.png
├── 04-ecr.png
├── 05-ecs-cluster.png
├── 06-task-definition.png
├── 07-ecs-service.png
├── 08-target-group.png
├── 09-alb.png
├── 10-route53.png
├── 11-acm.png
├── 12-codebuild-success.png
├── 13-codepipeline-success.png
├── 14-cloudwatch-logs.png
├── 15-application-homepage.png
```

Example:

## ECS Service

![ECS Service](screenshots/07-ecs-service.png)

## CodePipeline

![CodePipeline](screenshots/13-codepipeline-success.png)

## CloudWatch Logs

![CloudWatch](screenshots/14-cloudwatch-logs.png)

## Application

![Application](screenshots/15-application-homepage.png)

------------------------------------------------------------------------

# Project Structure

``` text
terraform/
├── provider.tf
├── variables.tf
├── vpc.tf
├── alb.tf
├── ecs.tf
├── ecr.tf
├── iam.tf
├── rds.tf
├── outputs.tf

cloudwatch/
├── amazon-cloudwatch-agent.json

Dockerfile
buildspec.yml
start.sh
README.md
```

------------------------------------------------------------------------

# Learning Outcomes

-   Infrastructure as Code using Terraform
-   AWS Networking
-   Docker & ECS
-   CI/CD using CodePipeline & CodeBuild
-   CloudWatch Agent
-   Amazon RDS
-   Route53 & ACM
-   Application Load Balancer
-   IAM Best Practices

------------------------------------------------------------------------

# Author

**Chanderaprakash D**

GitHub: https://github.com/Chanderaprakash-D
