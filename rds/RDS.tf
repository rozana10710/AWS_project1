
resource "aws_db_subnet_group" "rdssubnet" {
  name       = "rdssubnet"
  subnet_ids = ["subnet-0013fc2c02fa368bb", "subnet-0a954093c953b709e"]  # Replace with your subnet IDs

  tags = {
    Name = "DBSubnetGroup"
  }
}

resource "aws_db_instance" "rds" {
  identifier              = "rds-db"
  engine                 = "mysql"             
  engine_version         = "8.0"               
  instance_class         = "db.t3.micro"       
  allocated_storage       = 20                   
  username               = var.db_username      # Reference the variable
  password               = var.db_password      # Reference the variable
  db_name                = var.db_name          # Reference the variable        
  db_subnet_group_name   = aws_db_subnet_group.rdssubnet.name  # Reference to the subnet group
  publicly_accessible     = false
  deletion_protection     = false
  backup_retention_period = 7

  tags = {
    Name = "rds"
  }
}
