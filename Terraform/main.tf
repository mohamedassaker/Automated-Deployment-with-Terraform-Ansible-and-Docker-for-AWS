provider "aws" {
  region = var.region
}

data "aws_ami" "amazon-linux-image" {
    most_recent = true
    owners      = ["amazon"]

    filter {
        name   = "name"
        values = ["amzn2-ami-hvm-*-x86_64-gp2"]
    }

    filter {
        name   = "virtualization-type"
        values = ["hvm"]
    }

}

resource "aws_vpc" "myapp-vpc" {
    cidr_block = var.vpc_cidr_block
    enable_dns_hostnames = true
    tags = {
        Name = "${var.env_prefix}-vpc"
    }
}

resource "aws_subnet" "myapp-subnet-1" {
    vpc_id            = aws_vpc.myapp-vpc.id
    cidr_block        = var.subnet_1_cidr_block
    availability_zone = var.availability_zone
    tags = {
        Name = "${var.env_prefix}-subnet-1"
    }
}

resource "aws_security_group" "myapp-sg" {
    name   = "myapp-sg"
    vpc_id = aws_vpc.myapp-vpc.id

    ingress {
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = [var.my_ip]
    }

    ingress {
        from_port   = 8080
        to_port     = 8080
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port       = 0
        to_port         = 0
        protocol        = "-1"
        cidr_blocks     = ["0.0.0.0/0"]
        prefix_list_ids = []
    }

}

resource "aws_internet_gateway" "myapp-igw" {
    vpc_id = aws_vpc.myapp-vpc.id
    tags = {
        Name = "${vars.env_prefix}-internet-gateway"
    }
}

resource "aws_route_table" "myapp-route-table" {
  vpc_id = aws_vpc.myapp-vpc.id

    route{
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.myapp-igw.id
    }

    tags = {
        Name = "${vars.env_prefix}-route-table"
    }

}

# Associate the route table with the subnet
resource "aws_route_table_association" "a-rtb-subnet" {
    subnet_id      = aws_subnet.myapp-subnet-1.id
    route_table_id = aws_route_table.myapp-route-table.id
}

resource "aws_key_pair" "ssh-key" {
    key_name   = "${var.myapp_key}"
    public_key = file(var.ssh_key)
}

resource "aws_instance" "myapp-server-one" {
    ami                         = data.aws_ami.amazon-linux-image.id
    instance_type               = var.instance_type
    key_name                    = "${var.myapp_key}"
    associate_public_ip_address = true
    subnet_id                   = aws_subnet.myapp-subnet-1.id
    vpc_security_group_ids      = [aws_security_group.myapp-sg.id]
    availability_zone           = var.availability_zone

    tags = {
        Name = "dev-server"
    }
}

resource "null_resource" "configure_server" {
    triggers = {
        trigger = aws_instance.myapp-server-one.public_ip
    }

    provisioner "local-exec" {
        working_dir = "${var.ansible_path}" 
        command     = "ansible-playbook --private-key ${var.ssh_key_private} --user ${var.user} deploy-docker.yaml"      
    }
}