resource "aws_db_subnet_group" "rds-subnet-group" {
  name       = "main"
  subnet_ids = [module.vpc.private_subnets[0], module.vpc.private_subnets[1], module.vpc.private_subnets[2]]

  tags = {
    Name = "Subnet group for RDS"
  }
}

resource "aws_elasticache_subnet_group" "elasticache-subnet-group" {
  name       = "elasticache-subnet-group"
  subnet_ids = [module.vpc.private_subnets[0], module.vpc.private_subnets[1], module.vpc.private_subnets[2]]

  tags = {
    Name = "Subnet group for ElastiCache"
  }
}

resource "aws_db_instance" "rds-subnet-group" {
  allocated_storage      = 20
  storage_type           = "gp2"
  db_name                = var.db_name
  engine                 = "mysql"
  engine_version         = "8.0"
  instance_class         = "db.t3.micro"
  username               = var.db_user
  password               = var.db_pass
  parameter_group_name   = "default.mysql8.0"
  multi_az               = false # Changed to boolean
  publicly_accessible    = false # Changed to boolean
  skip_final_snapshot    = true
  db_subnet_group_name   = aws_db_subnet_group.rds-subnet-group.name
  vpc_security_group_ids = [aws_security_group.backend-sg.id]
}

resource "aws_elasticache_cluster" "cache" {
  cluster_id           = "cache"
  engine               = "memcached"
  node_type            = "cache.t2.micro"
  num_cache_nodes      = 1
  parameter_group_name = "default.memcached1.6"
  port                 = 11211
  subnet_group_name    = aws_elasticache_subnet_group.elasticache-subnet-group.name
  security_group_ids   = [aws_security_group.backend-sg.id] # Corrected attribute name
}

resource "aws_mq_broker" "rmq" {
  broker_name        = "rmq"
  engine_type        = "ActiveMQ"
  engine_version     = "5.17.6"
  host_instance_type = "mq.t2.micro"
  security_groups    = [aws_security_group.backend-sg.id] # Changed to correct attribute name
  subnet_ids         = [module.vpc.private_subnets[0]]

  user {
    username = var.rmq_user
    password = var.rmq_pass
  }
}
