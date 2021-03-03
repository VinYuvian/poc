variable "PATH_TO_PUBLIC_KEY" {
  default = "kubernetes.pub"
}

variable "project"{
    default = "project"
}


variable "aws_access_key"{
    default = "aws_access_key"
}


variable "aws_secret_key"{
    default = "aws_secret_key"
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
    default = "ami-042b34111b1289ccd"
}

variable "default_keypair_name"{
    default = "kubernetes"
}

variable "master_pvt_ip"{
    default = "192.168.3.34"
}
variable "worker_count"{
    default = 1
}


variable "master_count"{
    default = 1
}
