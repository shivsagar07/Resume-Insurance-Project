#ami → latest Amazon Linux AMI for your region

resource "aws_instance" "app" {
  ami                    = "ami-0f5ee92e2d63afc18"
  instance_type           = var.instance_type
  subnet_id               = var.subnet_id
  vpc_security_group_ids  = [var.security_group]

  user_data = file("${path.module}/user_data.sh")

  tags = {
    Name = "Health-Insurance-App"
  }
}
