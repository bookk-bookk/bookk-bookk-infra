resource "aws_ebs_volume" "ebs" {
  availability_zone = "ap-northeast-2a"
  size              = 16
  tags = {
    Name = var.tag_name
  }
}

resource "aws_ebs_snapshot" "ebs_snapshot" {
  volume_id = aws_ebs_volume.ebs.id
  tags = {
    Name = var.tag_name
  }
}

resource "aws_ami" "ubuntu" {
  name                = "ami-024cd8aafb84bb8bc"
  virtualization_type = "hvm"
  root_device_name    = "/dev/xvda"
  ena_support         = true
  ebs_block_device {
    device_name = "/dev/xvda"
    snapshot_id = aws_ebs_snapshot.ebs_snapshot.id
    volume_size = 16
  }
  tags = {
    Name = var.tag_name
  }
}

resource "aws_instance" "dev" {
  availability_zone = "ap-northeast-2a"
  ami               = aws_ami.ubuntu.id
  subnet_id         = aws_subnet.public_subnet.id
  instance_type     = "t3a.medium"
  user_data         = file("../install_docker.sh")
  tags = {
    Name = var.tag_name
  }
}

resource "aws_eip" "eip" {
  vpc      = true
  instance = aws_instance.dev.id
  tags = {
    Name = var.tag_name
  }
}
