provider "aws" {
    region = "eu-central-1"
    access_key = "AKIAZPQJ4A3RGBONIVH2"
    secret_key = "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"
}

variable "subnet_cidr_block" {
    description = "subnet cidr block"
}

variable "vpc_cidr_block" {
    description = "vpc cidr block"
}

variable "environment" {
    description = "development environment"
}

resource "aws_vpc" "development-vpc" {
    cidr_block = var.vpc_cidr_block
    tags = {
        Name: var.environment
    }
}

resource "aws_subnet" "dev-subnet-1" {
    vpc_id = aws_vpc.development-vpc.id
    cidr_block = var.subnet_cidr_block
    availability_zone = "eu-central-1a"
    tags = {
        Name: "subnet-1-dev"
    }
}


/*
data "aws_vpc" "existing_vpc" {
    default = true
}

resource "aws_subnet" "dev-subnet-2" {
    vpc_id = data.aws_vpc.existing_vpc.id
    cidr_block = "172.31.48.0/20" 
    availability_zone = "eu-central-1a"
    tags = {
        Name: "subnet-2-default"
    }
}
*/
output "dev-vpc-id" {
    value = aws_vpc.development-vpc.id
}

output "dev-subnet-id" {
    value = aws_subnet.dev-subnet-1.id
}