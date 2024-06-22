# create VPC
resource "aws_vpc" "elad-home-task" {
  cidr_block = "6.0.0.0/16"

  tags = {
    Name = "elad-home-task-vpc"
  }
}

# create two subnets (for load balancer)
resource "aws_subnet" "subnet_a" {
  vpc_id            = aws_vpc.elad-home-task.id
  cidr_block        = "6.0.1.0/24"
  availability_zone = "eu-north-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "elad-home-task-subnet-a"
  }
}

resource "aws_subnet" "subnet_b" {
  vpc_id            = aws_vpc.elad-home-task.id
  cidr_block        = "6.0.2.0/24"
  availability_zone = "eu-north-1b"
  map_public_ip_on_launch = true

  tags = {
    Name = "elad-home-task-subnet-b"
  }
}

# create gateway for outside connection
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.elad-home-task.id

  tags = {
    Name = "elad-home-task-igw"
  }
}

# create table route with association to subnets for outside connection
resource "aws_route_table" "rt" {
  vpc_id = aws_vpc.elad-home-task.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "elad-home-task-rt"
  }
}

resource "aws_route_table_association" "rta_a" {
  subnet_id      = aws_subnet.subnet_a.id
  route_table_id = aws_route_table.rt.id
}

resource "aws_route_table_association" "rta_b" {
  subnet_id      = aws_subnet.subnet_b.id
  route_table_id = aws_route_table.rt.id
}

# create load balancer for k8s cluster services
resource "aws_lb" "lb" {
  name               = "elad-home-task-k8s-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.lb_sg.id]
  subnets            = [aws_subnet.subnet_a.id, aws_subnet.subnet_b.id]

  enable_deletion_protection = false

  tags = {
    Name = "elad-home-task-k8s-lb"
  }
}


resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.lb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.front_end.arn
  }
}

resource "aws_lb_target_group" "front_end" {
  name     = "elad-home-task-k8s-front-end-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.elad-home-task.id

  health_check {
    path                = "/"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 5
    unhealthy_threshold = 2
  }

  tags = {
    Name = "elad-home-task-k8s-front-end-tg"
  }
}

# create load balancer security group for external connection
resource "aws_security_group" "lb_sg" {
  name        = "lb_sg"
  description = "Allow HTTP inbound traffic"
  vpc_id      = aws_vpc.elad-home-task.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "lb_sg"
  }
}
