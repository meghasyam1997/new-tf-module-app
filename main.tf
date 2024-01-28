resource "aws_security_group" "sg" {
  name        = "${var.name}-${var.env}"
  description = "${var.name}-${var.env}"
  vpc_id      = var.vpc_id

  ingress {
    description = "APP"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = var.allow_app_cidr
  }

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.bastion_cidr
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.name}-${var.env}"
  }
}
resource "aws_launch_template" "main" {
  name_prefix            = "${var.name}-${var.env}"
  image_id               = data.aws_ami
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.sg.id]
}

resource "aws_autoscaling_group" "asg" {
  desired_capacity = var.desired_capacity
  max_size         = var.max_size
  min_size         = var.min_size

  launch_template {
    id      = aws_launch_template.main.id
    version = "$Latest"
  }
}
