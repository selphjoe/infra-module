resource "aws_instance" "example_server" {
  ami           = "ami-053a617c6207ecc7b"
  instance_type = "t2.micro"

  tags = {
    Name = "JacksBlogExample"
  }
}