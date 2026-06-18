resource "aws_security_group" "rds" {
  name        = "${var.namespace}-rds-sg"
  description = "RDS MySQL security group"
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.ecs.id]
    description     = "Allow MySQL from ECS"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.namespace}-rds-sg"
  }
}

resource "aws_db_subnet_group" "main" {
  name       = "${var.namespace}-db-subnet-group"
  subnet_ids = aws_subnet.private[*].id

  tags = {
    Name = "${var.namespace}-db-subnet-group"
  }
}

resource "aws_db_instance" "main" {
  identifier             = "${var.namespace}-db"
  engine                 = "mysql"
  engine_version         = "8.0"
  instance_class         = "db.t3.micro"
  allocated_storage      = 20
  storage_type           = "gp3"
  db_name                = "ror_ecommerce"
  username               = "admin"
  password               = "Password#123"
  port                   = 3306
  db_subnet_group_name   = aws_db_subnet_group.main.name
  vpc_security_group_ids = [aws_security_group.rds.id]
  publicly_accessible    = false
  skip_final_snapshot    = true

  tags = {
    Name = "${var.namespace}-db"
  }
}