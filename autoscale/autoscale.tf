resource "aws_launch_configuration" "web_server" {
  name          = "web-server-lc"
  image_id     = "ami-097c5c21a18dc59ea"  # Replace with your web server AMI
  instance_type = "t3.micro"
  key_name      = "my_first_key"  # Your SSH key for accessing the instances

}

resource "aws_autoscaling_group" "web_server" {
  launch_configuration = aws_launch_configuration.web_server.id
  desired_capacity    = 1
  max_size            = 3
  min_size            = 1
  vpc_zone_identifier = ["subnet-0f8372851f216c6e2"]

  tag {
    key                 = "Name"
    value               = "WebServer"
    propagate_at_launch = true
  }
}

# Attach existing instance to the Auto Scaling Group

resource "aws_autoscaling_attachment" "existing_instance" {
  autoscaling_group_name = aws_autoscaling_group.web_server.name
  instance_id           = "i-07173cea4841b1866"
}
