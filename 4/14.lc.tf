
resource "aws_launch_configuration" "simple" {
  name_prefix = "simple-"

  image_id = var.image_id
  instance_type = var.instance_type
  key_name = var.key_name
  iam_instance_profile = aws_iam_instance_profile.yjkim1_profile.id

  security_groups = [ aws_security_group.allow_http.id ]
  associate_public_ip_address = true

  user_data = <<USER_DATA
#!/bin/bash
sudo amazon-linux-extras install nginx1 -y
sudo yum install -y mysql 
sudo echo "$(curl http://169.254.169.254/latest/meta-data/local-ipv4)" | tee /usr/share/nginx/html/index.html
sudo chkconfig nginx on
sudo service nginx start
  USER_DATA

  lifecycle {
    create_before_destroy = true
  }
}