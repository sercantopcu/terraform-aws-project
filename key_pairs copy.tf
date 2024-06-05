resource "aws_key_pair" "terraform-key" {
  key_name   = "terraform_key"
  public_key = file(var.pub_key)
}
