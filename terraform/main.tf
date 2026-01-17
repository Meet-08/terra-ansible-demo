# Create an EC2 Key Pair
resource "aws_key_pair" "deployer" {
  key_name   = "tf-ansible"
  public_key = file("tf-ansible.pem.pub")
}

# Create a VPC
resource "aws_default_vpc" "default" {}

# Create a Security Group
resource "aws_security_group" "my_security_group" {
  name        = "automate-sg"
  description = "This will add a TF generated Security group"
  vpc_id      = aws_default_vpc.default.id
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "tf-ansible-instance" {
  key_name               = aws_key_pair.deployer.key_name
  vpc_security_group_ids = [aws_security_group.my_security_group.id]
  instance_type          = var.ec2_instance_type
  ami                    = var.ec2_ami_id #Ubuntu
  count                  = 1

  root_block_device {
    volume_size = 25
    volume_type = "gp3"
  }
  tags = {
    Name = "tf-ansible"
  }
}