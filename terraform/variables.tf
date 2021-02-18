variable "PATH_TO_PUBLIC_KEY" {
  default = "kubernetes.pub"
}

variable "project"{
    default = "project"
}

variable "vpc_id"{
    default = "vpc-0b9b5a3f39b1c09c5"
}

variable "region"{
    default="ap-south-1"
}

variable "az"{
    default=["a","b"]
}

variable "public"{
    default = ["192.168.1.0","192.168.3.0"]
}

variable "private"{
    default = ["192.168.2.0","192.168.4.0"]
}

variable "controller_instance_type"{
    default = "t2.medium"
}

variable "worker_instance_type"{
    default = "t2.micro"
}

variable "ami"{
    default = "ami-0db0b3ab7df22e366"
}

variable "default_keypair_name"{
    default = "kubernetes"
}