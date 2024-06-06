# Example IAM Role
resource "aws_iam_role" "beanstalk_role" {
  name = "beanstalk_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })
}

# Example IAM Instance Profile
resource "aws_iam_instance_profile" "beanstalk_profile" {
  name = "beanstalk_profile"
  role = aws_iam_role.beanstalk_role.name
}
