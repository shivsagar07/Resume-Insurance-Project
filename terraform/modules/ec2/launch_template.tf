resource "aws_launch_template" "app_lt" {
  name_prefix   = "health-app-"
  image_id      = "ami-0f5ee92e2d63afc18"
  instance_type = var.instance_type

  user_data = base64encode(file("${path.module}/user_data.sh"))

  network_interfaces {
    security_groups = [var.security_group]
  }
}
#AMI ID → latest Amazon Linux for your region
