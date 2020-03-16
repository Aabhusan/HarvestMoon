resource "tls_private_key" "harvestMoon"{
    algorithm="RSA"
    rsa_bits=4096
  
}

resource "aws_key_pair" "harvestMoon" {
  key_name = "${var.instance_key}"
  public_key = "${tls_private_key.harvestMoon.public_key_openssh}"
}



resource "aws_instance" "harvestMoon" {
    ami                             ="${var.aws_ami}"
    instance_type                   = var.instance_type
    key_name                        ="${aws_key_pair.harvestMoon.id}"
    subnet_id                       ="subnet-0529e3e3e3fa9c434"
    vpc_security_group_ids          =["${aws_security_group.harvestMoon.id}"]
    

  


    tags = {
    Name  = "MUX-DEV-PHP-001"
    }
}


resource "aws_security_group" "harvestMoon" {
  name          ="harvestMoon_sg"
  description   ="allow all the inbound traffic"
  vpc_id        ="vpc-041d6d787df92bf16"
  
  lifecycle{
        create_before_destroy=true

    }
  ingress {
    protocol    = "tcp"
    from_port   = 80
    to_port     = 80
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    protocol    = "tcp"
    from_port   = 443
    to_port     = 443
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    protocol    = "tcp"
    from_port   = 22
    to_port     = 22
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    protocol    = "tcp"
    from_port   = 2073
    to_port     = 2073
    cidr_blocks = ["202.70.67.113/32","182.93.83.51/32","202.166.206.8/32","202.79.34.78/32"]
  }
  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}


resource "aws_eip" "harvestMoon" {
  instance = "${aws_instance.harvestMoon.id}"
  vpc      = true
}

