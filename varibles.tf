variable "vpc_region" {
  default="us-west-2"
}


variable "instance_key" {
  default="harvestmoon-key"
}

variable "aws_ami" {  
  default= "ami-02cbed67225579b2c"
}

variable "instance_type" {
    type= "string"
    default="t2.medium"
}

