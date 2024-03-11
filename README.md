# Automated Deployment with Terraform, Ansible, and Docker for AWS

## Project Overview

This project aims to automate the deployment of a Node.js application on AWS infrastructure using a seamless combination of Terraform for infrastructure provisioning, Ansible for configuration management, and Docker for containerized application deployment. The infrastructure includes a VPC, subnet, security group, and an EC2 instance with the specified configurations.

## Usage Instructions

### Terraform Configuration (Automated_Deployment\Terraform)

1. **main.yaml:** Defines the AWS infrastructure using Terraform, including VPC, subnet, security group, and EC2 instance.

2. **variables.yaml:** Set your specific variables for AWS region, CIDR blocks, IP addresses, instance type, and more.

3. **outputs.yaml:** Outputs the AMI ID and server's public IP for reference.

### Ansible Configuration (Automated_Deployment\Ansible)

1. **deploy-docker.yaml:** Ansible playbook for deploying Docker on AWS EC2 instances.

2. **deploy-docker-vars:** Configuration file containing variables used in the Ansible playbook.

3. **ansible.cfg:** Ansible configuration file with settings for AWS EC2 inventory and Python interpreter.

4. **inventory_aws_ec2.yaml:** Ansible dynamic inventory configuration for AWS EC2 instances.

5. **Roles:**
    - **check_ssh:** Ensures SSH port is open before proceeding.
    - **create_user:** Creates a new user on the EC2 instance.
    - **setup_environment:** Installs Python3, Docker, and Docker Compose.
    - **start_container:** Copies Docker Compose file, logs into Docker registry, and starts the container.

### Getting Started

1. Ensure you have Terraform, Ansible, and Docker installed locally.

2. Update variables in `Automated_Deployment\Terraform\variables.yaml` to match your preferences.

3. Run the following commands in sequence:

   ```bash
   cd Automated_Deployment\Terraform
   terraform init
   terraform apply
   ```

4. Execute the Ansible playbook using the following command:

   ```bash
   cd Automated_Deployment\Ansible
   ansible-playbook -i /path/to/Automated_Deployment/Ansible/inventory_aws_ec2.yaml --private-key /path/to/your/private/key.pem /path/to/Automated_Deployment/Ansible/deploy-docker.yaml
   ```


### Note

- Ensure AWS credentials are configured on your local machine.
- Modify Docker registry credentials in `deploy-docker-vars` before deployment.

