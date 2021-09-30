# Creating RDS

resource "aws_db_instance" "default" {
  identifier = "mysql-db-music-player"  
  allocated_storage    = 5
  engine               = "mysql"
  engine_version       = "5.7"
  publicly_accessible =   true
  instance_class       = "db.t2.small"
  name                 = "db_music-player"
  username             = "music-player"
  password             = "db_music-player"
  parameter_group_name = "default.mysql5.7"
  skip_final_snapshot  = true
}

