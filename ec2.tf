resource "aws_launch_configuration" "cc-music-player" {
  name_prefix   = "cloud-server"
  image_id      = "ami-0747bdcabd34c712a"
  instance_type = "t2.micro"
  key_name          = "cc-music-player"
  security_groups = [ aws_security_group.ports.id ]
  associate_public_ip_address = true

  user_data = <<-EOF
                 #!/bin/bash
                  sudo apt update -y
                  sudo apt install apache2 -y
                  sudo systemctl start apache2
                  sudo apt install mysql-server -y
                  sudo apt install php libapache2-mod-php php-mysql -y
                  git clone https://github.com/ahmadykhan555/cc-music-player.git
                  EOF

  lifecycle {
    create_before_destroy = true
  }
}