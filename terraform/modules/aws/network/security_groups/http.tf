resource "aws_security_group" "http-servers" {
  name        = "HTTP-Servers"
  description = "Allow HTTP Traffic"
  vpc_id      = "${var.vpc_id}"

  tags {
    Name = "http-servers"
  }

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
}
