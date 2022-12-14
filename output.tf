##Output
output "public_ip" {
  value = aws_eip.example.public_ip
}