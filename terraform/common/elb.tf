resource "aws_security_group" "elb" {
  name        = "sg_elb_${var.application}${var.team_number}"
  description = "Allow traffic to elb"
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port   = "80"
    to_port     = "80"
    cidr_blocks = ["0.0.0.0/0"]
    protocol    = "TCP"
  }

  egress {
    from_port   = "0"
    to_port     = "0"
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "sg_elb_${var.application}${var.team_number}"
    Application = var.application
    Owner       = var.owner
  }
}

resource "aws_elb" "web" {
  name                      = "elb-${var.application}${var.team_number}"
  subnets                   = aws_subnet.public.*.id
  security_groups           = [aws_security_group.elb.id]
  cross_zone_load_balancing = "true"

  listener {
    instance_port     = "80"
    instance_protocol = "HTTP"
    lb_port           = "80"
    lb_protocol       = "HTTP"
  }

  health_check {
    healthy_threshold   = "2"
    unhealthy_threshold = "2"
    timeout             = "2"
    target              = "TCP:80"
    interval            = "5"
  }

  tags = {
    Name        = "elb-${var.application}${var.team_number}"
    Application = var.application
    Owner       = var.owner
  }
}

output "elb_dns_name" {
  value = aws_elb.web.dns_name
}

