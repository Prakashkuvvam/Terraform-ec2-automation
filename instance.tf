resource "aws_instance" "myec2" {
  ami                         = var.ami
  instance_type               = var.instance-type
  associate_public_ip_address = true
  key_name                    = "sample"
  subnet_id                   = aws_subnet.mysub.id
  vpc_security_group_ids      = [aws_security_group.mySG.id]
  tags = {
    "Name" = "Google-Instane"
  }
}