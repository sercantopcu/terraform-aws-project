variable "region" {
  default = "us-east-1"
}

variable "amis" {
  type = map(any)
  default = {
    us-east-1 = "ami-0e001c9271cf7f3b9"
    us-east-2 = "ami-0f30a9c3a48f3fa79"
  }
}

variable "pri_key" {
  default = "terraform_key"
}

variable "pub_key" {
  default = "terraform_key.pub"
}

variable "user" {
  default = "ubuntu"
}

variable "myip" {
  default = "183.83.39.124/32"
}

variable "rmq_user" {
  default = "rabbit"
}

variable "rmq_pass" {
  default = "FrL@raCriB7eYi+tuprL"
}

variable "db_user" {
  default = "admin"
}

variable "db_pass" {
  default = "admin123"
}

variable "db_name" {
  default = "accounts"
}

variable "intance_count" {
  default = "1"
}

variable "vpc_name" {
  default = "aws-terraform-project"
}

variable "zone1" {
  default = "us-east-1a"
}

variable "zone2" {
  default = "us-east-1b"
}

variable "zone3" {
  default = "us-east-1c"
}

variable "vpc_cidr" {
  default = "172.21.0.0/16"
}

variable "pub_sub1_cidr" {
  default = "172.21.1.0/24"
}

variable "pub_sub2_cidr" {
  default = "172.21.2.0/24"
}

variable "pub_sub3_cidr" {
  default = "172.21.3.0/24"
}

variable "priv_sub1_cidr" {
  default = "172.21.4.0/24"
}

variable "priv_sub2_cidr" {
  default = "172.21.5.0/24"
}

variable "priv_sub3_cidr" {
  default = "172.21.6.0/24"
}