variable "vpc_region" {
  default="us-west-2"
}


variable "instance_key" {
  default="harvestmoon-key"
}

variable "aws_ami" {  
  default= "ami-06d51e91cea0dac8d"
}

variable "instance_type" {
    type= "string"
    default="t2.medium"
}

