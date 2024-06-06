resource "aws_key_pair" "aws_terraform_key" {
  key_name   = "aws_terraform_key"
  public_key = file(var.pub_key)
}
