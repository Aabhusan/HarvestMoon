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
}
resource "aws_security_group_rule" "allow_all_ssh" {
    type                ="ingress"
    from_port           = 22
    to_port             = 22
    protocol            ="tcp"
    cidr_blocks         =["0.0.0.0/0"]
    security_group_id   ="${aws_security_group.harvestMoon.id}"
  
}

resource "aws_security_group_rule" "allow_all_outbound" {
    type                    ="egress"
    from_port               =0
    to_port                 = 0
    protocol                ="-1"
    cidr_blocks             =["0.0.0.0/0"]
    security_group_id       ="${aws_security_group.harvestMoon.id}"

}


resource "aws_eip" "harvestMoon" {
  instance = "${aws_instance.harvestMoon.id}"
  vpc      = true
}

