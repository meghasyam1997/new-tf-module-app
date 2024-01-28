variable "instance_type" {}
variable "name" {}
variable "desired_capacity" {}
variable "max_size" {}
variable "min_size" {}

variable "bastion_cidr" {}
variable "allow_app_cidr" {}
variable "vpc_id" {}
variable "subnet_ids" {}

variable "tags" {}
variable "env" {}