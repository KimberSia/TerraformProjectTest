resource "aws_instance" "jenkins_ec2_instance" {
  ami           = "ami-0e0498315a9a52ad3"
  instance_type = "t2.micro"
  key_name      = "aws2"
  vpc_security_group_ids =[aws_security_group.week_20_security_group.id]
  tags = {
    Name = "jenkins_ec2_instance"
  }

  user_data = <<-EOF
#!bin/bash
sudo yum update –y
sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.keydata "aws_vpc" "default" {
sudo amazon-linux-extras install java-openjdk11 -y
sudo yum install jenkins -y
sudo systemctl enable jenkins
sudo systemctl start jenkins
sudo systemctl status jenkins
              EOF
}

resource "aws_security_group" "week_20_security_group" {
  name_prefix = "week_20_security_group"
  description = "Allow inbound traffic on port 22 and 8080"
  vpc_id      = var.vpc_name


  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["54.146.181.136/32"]
  }

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "week_20_security_group"
  }
}
#create s3 bucket
resource "aws_s3_bucket" "jenkinbucket" {
  bucket = "bucket-jenkin"
  tags = {
    Name = "jenkins-artifact-bucket"
  }
}



resource "aws_s3_bucket_acl" "bucket-jenkin" {
  bucket = aws_s3_bucket.jenkinbucket.id
acl    = "private"
}