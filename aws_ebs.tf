resource "aws_ebs_volume" "additional" {
  availability_zone = "us-east-1a"
  size              = 20

  tags = {
    Name = "tf-east-1a"
  }
}

resource "aws_ebs_volume" "new-volume" {
  availability_zone = "us-east-1b"
  size              = 15

  tags = {
    Name = "tf-east-1b"
  }
}