resource "aws_instance" "bastion" {
  ami                         = lookup(var.amis, var.region)
  instance_type               = "t2.micro"
  associate_public_ip_address = true
  key_name                    = aws_key_pair.aws_terraform_key.key_name
  subnet_id                   = module.vpc.public_subnets[0]
  count                       = var.instance_count
  vpc_security_group_ids      = [aws_security_group.bastion-sg.id]

  tags = {
    Name    = "bastion"
    PROJECT = "aws-terraform"
  }

  provisioner "file" {
    content     = templatefile("templates/db-deploy.tmpl", { rds-endpoint = aws_db_instance.rds-subnet-group.address, db_user = var.db_user, db_pass = var.db_pass })
    destination = "/tmp/vprofile-dbdeploy.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/vprofile-dbdeploy.sh",
      "sudo /tmp/vprofile-dbdeploy.sh"
    ]
  }

  connection {
    user        = var.user
    private_key = file(var.pri_key)
    host        = var.myip
  }

  depends_on = [aws_db_instance.rds-subnet-group]
}