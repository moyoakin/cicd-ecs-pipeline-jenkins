data "aws_ami" "ubuntu_22_04" {
  most_recent = true
  owners      = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }
}

resource "aws_security_group" "jenkins_sg" {
  name        = "techpathway-jenkins-sg"
  description = "Allow SSH and Jenkins access"
  vpc_id      = aws_vpc.main.id

 ingress {
  description = "SSH"
  from_port   = 22
  to_port     = 22
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
}

  ingress {
    description = "Jenkins UI"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP"
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
    Name = "techpathway-jenkins-sg"
  }
}

resource "aws_instance" "jenkins_server" {
  ami                         = data.aws_ami.ubuntu_22_04.id
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.public_1.id
  vpc_security_group_ids      = [aws_security_group.jenkins_sg.id]
  associate_public_ip_address = true
  key_name = "techpathway-jenkins-key-v2"

  user_data = <<-EOF
    #!/bin/bash
    apt update -y
    apt install openjdk-17-jdk git docker.io unzip curl -y

    curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key | tee /usr/share/keyrings/jenkins-keyring.asc > /dev/null

    echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/ | tee /etc/apt/sources.list.d/jenkins.list > /dev/null

    apt update -y
    apt install jenkins -y

    systemctl start jenkins
    systemctl enable jenkins

    usermod -aG docker jenkins
    usermod -aG docker ubuntu

    systemctl restart docker
    systemctl restart jenkins
  EOF

  tags = {
    Name = "techpathway-jenkins-server"
  }
}