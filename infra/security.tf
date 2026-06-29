resource "aws_security_group" "alb_sg" {
  name        = "techpathway-alb-sg"
  description = "Allow HTTP traffic to the load balancer"
  vpc_id      = aws_vpc.main.id

  ingress {
    description = "HTTP from internet"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow all outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "techpathway-alb-sg"
  }
}

resource "aws_security_group" "ecs_sg" {
  name        = "techpathway-ecs-sg"
  description = "Allow ALB traffic to ECS tasks"
  vpc_id      = aws_vpc.main.id

  ingress {
    description     = "Frontend traffic from ALB"
    from_port       = 3000
    to_port         = 3000
    protocol        = "tcp"
    security_groups = [aws_security_group.alb_sg.id]
  }

  ingress {
    description     = "Backend traffic from ALB"
    from_port       = 8080
    to_port         = 8080
    protocol        = "tcp"
    security_groups = [aws_security_group.alb_sg.id]
  }

  egress {
    description = "Allow all outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "techpathway-ecs-sg"
  }
}