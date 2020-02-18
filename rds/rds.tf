variable "name" {

}

variable "prod" {
  type = bool
}

variable "subnets" {
  type = list(string)
}

resource "random_password" "db_password" {
  length = 9
}

resource "aws_db_subnet_group" "default" {
  subnet_ids = var.subnets
}

resource "aws_db_instance" "default" {
  allocated_storage    = 20
  storage_type         = "gp2"
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = var.prod ? "db.r5.large": "db.t2.micro"
  name                 = replace(var.name, "-", "_")
  username             = "root"
  password             = random_password.db_password.result
  parameter_group_name = "default.mysql5.7"
  multi_az             = var.prod
  db_subnet_group_name = aws_db_subnet_group.default.name
}

output "db_password" {
  value = random_password.db_password.result
}

output "address" {
  value = aws_db_instance.default.address
}
