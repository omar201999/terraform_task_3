data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] 
}


resource "aws_instance" "public_1" {
  ami = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  associate_public_ip_address = true
  subnet_id = var.public_subnet_1_id
  security_groups = [var.public_security_group_id]
user_data = file("./modules/ec2-instance/nginx.sh")
 provisioner "local-exec" {
  when        = create
  on_failure  = continue
   command = "echo public ${self.public_ip} >> all_ip.txt"
 }

   tags = {
    Name        = "public_1"
    Environment = "dev"
  }

}

resource "aws_instance" "public_2" {
  ami = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  associate_public_ip_address = true
  subnet_id = var.public_subnet_2_id
  security_groups = [var.public_security_group_id]
  user_data = file("./modules/ec2-instance/nginx.sh")

 provisioner "local-exec" {
  when        = create
  on_failure  = continue
   command = "echo public ${self.public_ip} >> all_ip.txt"
 }

    tags = {
    Name        = "public_2"
    Environment = "dev"
  }


}

resource "aws_instance" "private_1" {
  ami = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  associate_public_ip_address = false
  subnet_id = var.private_subnet_1_id
  security_groups = [var.private_security_group_id]
user_data = file("./modules/ec2-instance/apache.sh")
 provisioner "local-exec" {
  when        = create
  on_failure  = continue
   command = "echo public ${self.private_ip} >> all_ip.txt"
 }
    tags = {
    Name        = "private_1"
    Environment = "dev"
  }

}

resource "aws_instance" "private_2" {
  ami = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  associate_public_ip_address = false
  subnet_id = var.private_subnet_2_id
  security_groups = [var.private_security_group_id]
user_data = file("./modules/ec2-instance/apache.sh")


 provisioner "local-exec" {
  when        = create
  on_failure  = continue
   command = "echo public ${self.private_ip} >> all_ip.txt"
 }
   tags = {
    Name        = "private_2"
    Environment = "dev"
  }

}


