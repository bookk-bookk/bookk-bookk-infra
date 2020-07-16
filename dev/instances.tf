data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"]
  filter {
    name   = "image-id"
    values = ["ami-0d777f54156eae7d9"]
  }
}

resource "aws_key_pair" "access_key" {
  key_name   = "dev-init-key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDbV8mfq1GOXQTkSLMrLTXjjJySyseJbkegqgahSLB2q3h/FVENy+no0pmtIeD1MdfsYxnjaIJs+l9gCcZWj4o9AXAOidcjkINeiRhS6Inayc9fbYmrH58d74KcHgFci+INbYjO+R4ybEVL/ScODIvEzagBdwzAgNr24vdxtSiP7jYFcOVsPJH9VtmgiSwgjMF1bfn/M9JOR84zgF73CNgzhNAqoCjTwqrQknmZZfddEDovnIj570wVSmTFn3PO58yQhlC3BPsFU/HD3bknVYiCrq25JD9u5VJfVr279Okpdvsv0weXxynnrzHwCL23D99JBu/kJr/yx3n50yQnOOKN c201809035@C201809035-01.local"
  tags = {
    Name = var.tag_name
  }
}

resource "aws_instance" "dev" {
  key_name          = aws_key_pair.access_key.key_name
  availability_zone = "ap-northeast-2a"
  ami               = data.aws_ami.ubuntu.id
  subnet_id         = aws_subnet.public_subnet.id
  instance_type     = "t3a.small"
  user_data         = file("../install.sh")
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
