variable "region" {
    description = "The AWS region to deploy to"
    type        = string
    default     = "eu-west-3"
}

variable "vpc_cidr_block" {
    description = "The CIDR block for the VPC"
    type        = string
    default     = "10.0.0.0/16"
}

variable "subnet_1_cidr_block" {
    description = "The CIDR block for the subnet"
    type        = string
    default     = "10.0.10.0/24"
}

variable "my_ip" {
    description = "The IP address to allow SSH access from"
    type        = string
    default     = "178.191.165.222/32"
}

variable "env_prefix" {
    description = "The prefix to use for all resources"
    type        = string
    default     = "my-app"
}

variable "instance_type" {
    description = "The instance type to use for the server"
    type        = string
    default     = "t2.micro"
}

variable "availability_zone" {
    description = "The availability zone to deploy to"
    type        = string
    default     = "eu-west-3b"
}

variable "ssh_key" {
    description = "The path to the SSH public key to use for the server"
    type        = string
    default     = "~/.ssh/id_rsa.pub"
}

variable "myapp_key" {
    description = "The name of the key pair to create"
    type        = string
    default     = "my-app-key"
}

variable "ansible_path" {
    description = "The path to the Ansible playbook"
    type        = string
    default     = "/Users/mohamed-assaker/Ansible"
}

variable "ssh_key_private" {
    description = "The path to the SSH private key to use for the server"
    type        = string
    default     = "~/.ssh/id_rsa"
}

variable "user" {
    description = "The user to use for the server"
    type        = string
    default     = "ec2-user"
  
}

variable "inventory_file_path" {
    description = "The path to the inventory file"
    type        = string
    default     = "/Users/mohamed-assaker/Ansible/inventory/inventory_aws_ec2.yaml"
}