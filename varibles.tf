variable "vpc_region" {
  default="us-west-2"
}


variable "instance_key" {
  default="harvestmoon-key"
}

variable "aws_ami" {  
  default= "ami-0c5204531f799e0c6"
}

variable "instance_type" {
    type= "string"
    default="t2.medium"
}

