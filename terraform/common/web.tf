resource "aws_key_pair" "keypair" {
  key_name   = "gameday_key"
  public_key = file(var.key_name)
}

resource "aws_security_group" "web" {
  name        = "sg_web_${var.application}${var.team_number}"
  description = "Allow traffic to web servers"
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port   = "22"
    to_port     = "22"
    cidr_blocks = ["0.0.0.0/0"]
    protocol    = "TCP"
  }

  ingress {
    from_port       = "443"
    to_port         = "443"
    security_groups = [aws_security_group.elb.id]
    protocol        = "TCP"
  }

  egress {
    from_port   = "0"
    to_port     = "0"
    cidr_blocks = ["0.0.0.0/0"]
    protocol    = "-1"
  }

  tags = {
    Name        = "sg_web_${var.application}${var.team_number}"
    Application = var.application
    Owner       = var.owner
  }
}

resource "aws_iam_role" "web" {
  name = "web_role_${var.application}${var.team_number}"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow"
    }
  ]
}
EOF

}

resource "aws_iam_role_policy" "web_log" {
  name = "web_log_role_policy_${var.application}${var.team_number}"
  role = aws_iam_role.web.id

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents",
        "logs:DescribeLogStreams"
    ],
      "Resource": [
        "arn:aws:logs:*:*:*"
    ]
  }
 ]
}
EOF

}

resource "aws_iam_role_policy_attachment" "IamRoleManagedPolicyRoleAttachment0" {
  role = aws_iam_role.web.id
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_iam_instance_profile" "web" {
  name = "profile_${var.application}${var.team_number}"
  role = aws_iam_role.web.name
}

resource "aws_launch_configuration" "web" {
  image_id             = var.web_ami
  name_prefix          = "lc_${var.application}${var.team_number}_"
  instance_type        = var.instance_type
  key_name             = aws_key_pair.keypair.id
  iam_instance_profile = aws_iam_instance_profile.web.id
  security_groups      = [aws_security_group.web.id]

  user_data = data.template_file.user_data.rendered
}

resource "aws_autoscaling_group" "web_asg" {
  name                 = "asg_web_${aws_launch_configuration.web.name}"
  launch_configuration = aws_launch_configuration.web.id
  vpc_zone_identifier  = aws_subnet.public.*.id
  load_balancers       = [aws_elb.web.name]

  health_check_type         = var.asg_health_check_type
  health_check_grace_period = var.asg_health_check_grace_period

  min_size              = var.asg_min
  max_size              = var.asg_max
  wait_for_elb_capacity = var.asg_min
  desired_capacity      = var.asg_desired

  tag {
    key                 = "Name"
    value               = "web_${var.application}${var.team_number}"
    propagate_at_launch = "true"
  }

  tag {
    key                 = "Application"
    value               = var.application
    propagate_at_launch = "true"
  }

  tag {
    key                 = "Owner"
    value               = var.owner
    propagate_at_launch = "true"
  }
}
