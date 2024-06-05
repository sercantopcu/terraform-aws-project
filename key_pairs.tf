resource "aws_key_pair" "terraformkey" {
  key_name   = "terraform_key"
  public_key = file(var.pub_key)
}
