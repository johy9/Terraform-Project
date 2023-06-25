# Ansible master 
resource "aws_instance" "ansible-master" {
  ami           = "ami-002070d43b0a4f171"
  instance_type = "t2.micro"
  subnet_id = aws_subnet.food-pub-sn.id
  key_name = "DevKey"
  vpc_security_group_ids = [aws_security_group.allow_food.id]
  user_data = file("install-ansible.sh")
  private_ip = "10.0.1.20"

  tags = {
    Name = "Ansible master"
  }
}

# ANSIBLE NODE
resource "aws_instance" "ans-n1" {
  ami           = "ami-002070d43b0a4f171"
  instance_type = "t2.micro"
  subnet_id = aws_subnet.food-pub-sn.id
  key_name = "DevKey"
  vpc_security_group_ids = [aws_security_group.allow_food.id]
  private_ip = "10.0.1.22"

  tags = {
    Name = "Ansible node"
  }
}