# PROVIDER 

provider "aws"{
    #profile = "kubernetes"
    access_key = var.aws_access_key
    secret_key = var.aws_secret_key
    region = "ap-south-1"
}

data "aws_vpc" "selected" {
  tags = {
      Name = "kubernetes-vpc"
  }
}

data "aws_subnet_ids" "private" {
  vpc_id = data.aws_vpc.selected.id
  tags = {
    Tier = "Private"
  }
}

data "aws_subnet_ids" "public" {
  vpc_id = data.aws_vpc.selected.id
  tags = {
    Tier = "public"
  }
}








