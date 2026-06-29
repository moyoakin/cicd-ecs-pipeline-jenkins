# 🚀 End-to-End CI/CD Pipeline on AWS using Jenkins, Docker, Terraform & ECS

## 📌 Project Overview

This project demonstrates the implementation of a complete end-to-end CI/CD pipeline on AWS using Infrastructure as Code (Terraform), Docker containerization, Jenkins automation, Amazon Elastic Container Registry (ECR), and Amazon Elastic Container Service (ECS).

The solution automates the deployment lifecycle by provisioning AWS infrastructure, building Docker images, pushing them to Amazon ECR, and deploying the latest application version to Amazon ECS through a Jenkins pipeline.

This project was built as part of my hands-on DevOps learning journey to demonstrate practical cloud engineering skills, CI/CD automation, and Infrastructure as Code best practices.

---

# 🏗️ Solution Architecture

```text
                    GitHub Repository
                           │
                           ▼
                     Jenkins Pipeline
                           │
            ┌──────────────┴──────────────┐
            ▼                             ▼
   Build Backend Image          Build Frontend Image
            │                             │
            └──────────────┬──────────────┘
                           ▼
                  Push Images to Amazon ECR
                           │
                           ▼
               Deploy to Amazon ECS (Fargate)
                           │
                           ▼
               Application Load Balancer (ALB)
                           │
                           ▼
              Frontend ↔ Backend Application
```

---

# 🛠️ Technologies Used

## Cloud Services

* Amazon EC2
* Amazon ECS (Fargate)
* Amazon ECR
* Application Load Balancer (ALB)
* Amazon VPC
* IAM
* CloudWatch

## Infrastructure as Code

* Terraform

## CI/CD

* Jenkins
* Git
* GitHub

## Containers

* Docker

## Application

### Frontend

* React.js

### Backend

* Node.js

---

# 📁 Project Structure

```text
techpathway-2/
│
├── backend/
│   └── Dockerfile
│
├── frontend/
│   └── Dockerfile
│
├── infra/
│   ├── provider.tf
│   ├── networking.tf
│   ├── security.tf
│   ├── alb.tf
│   ├── ecs.tf
│   ├── ecr.tf
│   ├── iam.tf
│   ├── jenkins.tf
│   ├── outputs.tf
│   └── variables.tf
│
├── Jenkinsfile
├── README.md
└── .gitignore
```

---

# ⚙️ Infrastructure Provisioned with Terraform

Terraform provisions the following AWS resources:

* Custom VPC
* Public Subnets
* Internet Gateway
* Route Tables
* Security Groups
* Jenkins EC2 Instance
* Application Load Balancer
* Target Groups
* ECS Cluster
* ECS Task Definitions
* ECS Services
* Amazon ECR Repositories
* IAM Roles
* CloudWatch Log Groups

---

# 🔄 CI/CD Pipeline Workflow

The Jenkins pipeline automates the following deployment process:

1. Checkout the latest source code from GitHub.
2. Authenticate with Amazon Elastic Container Registry (ECR).
3. Build the backend Docker image.
4. Build the frontend Docker image.
5. Push both Docker images to Amazon ECR.
6. Trigger a new deployment on Amazon ECS.
7. Deploy the updated application behind the Application Load Balancer.

---

# 📦 Docker Images

### Backend

```text
techpathway-backend
```

### Frontend

```text
techpathway-frontend
```

---

# 🌐 Deployment

The application is deployed using:

* Amazon ECS (Fargate)
* Amazon ECR
* Docker
* Application Load Balancer
* Jenkins CI/CD Pipeline

---

# 🔐 Security

Security best practices implemented include:

* IAM Roles and Policies
* Security Groups
* Jenkins Credential Store for AWS authentication
* Infrastructure provisioned using Terraform
* Docker container isolation

---

# ✅ Prerequisites

Before running this project, ensure the following tools are installed:

* Terraform
* Docker
* Git
* AWS CLI
* Jenkins
* Node.js (for local development)
* AWS Account with appropriate IAM permissions

---

# 🚀 Getting Started

## 1. Clone the Repository

```bash
git clone https://github.com/moyoakin/cicd-ecs-pipeline-jenkins.git
cd cicd-ecs-pipeline-jenkins
```

## 2. Provision the Infrastructure

```bash
cd infra
terraform init
terraform plan
terraform apply
```

## 3. Configure Jenkins

* Install the required Jenkins plugins.
* Configure AWS credentials in Jenkins.
* Create a Pipeline job.
* Point the pipeline to the repository's `Jenkinsfile`.

## 4. Run the Pipeline

Click **Build Now** or configure a GitHub webhook for automatic builds.

---

# 🎯 Skills Demonstrated

This project demonstrates practical experience with:

* Infrastructure as Code (Terraform)
* AWS Cloud Architecture
* Docker Containerization
* Jenkins CI/CD Pipelines
* Amazon ECS (Fargate)
* Amazon ECR
* Application Load Balancer
* Git & GitHub
* Linux Administration
* Cloud Infrastructure Deployment
* Continuous Integration & Continuous Deployment
* DevOps Best Practices

---

# 📈 Future Enhancements

Planned improvements include:

* GitHub Webhooks
* HTTPS with AWS Certificate Manager (ACM)
* Blue/Green Deployments
* ECS Auto Scaling
* CloudWatch Monitoring & Alarms
* Terraform Remote State (S3 + DynamoDB)
* SonarQube Code Quality Analysis
* Automated Unit & Integration Testing
* Slack / Microsoft Teams Notifications

---

# 📄 License

This project is licensed under the **MIT License**.

Feel free to use, modify, and distribute this project for learning and educational purposes.
