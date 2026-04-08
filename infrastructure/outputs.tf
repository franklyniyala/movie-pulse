output "public-ip" {
  value = aws_instance.movie-pulse-ec2-server.public_ip
}

output "ssh_command" {
  value = "ssh -i jay.pem ec2-user@${aws_instance.movie-pulse-ec2-server.public_ip}"
}