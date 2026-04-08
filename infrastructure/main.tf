resource "aws_instance" "movie-pulse-ec2-server" {
  ami                         = "ami-01b14b7ad41e17ba4"
  instance_type               = "m7i-flex.large"
  subnet_id                   = aws_subnet.movie-pulse-subnet.id
  vpc_security_group_ids      = [aws_security_group.movie-pulse-sg.id]
  key_name                    = "jay"
  associate_public_ip_address = true

  tags = {
    Name = "movie-pulse-ec2-server"
  }
}