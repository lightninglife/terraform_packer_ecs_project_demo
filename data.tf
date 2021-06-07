data "aws_availability_zones" "available" {}

data "aws_subnet_ids" "main" {
  vpc_id = aws_vpc.main.id
  filter {
    name   = "tag:Name"
    values = [var.aws_subnet_ids_main_filter_values]
  }
  depends_on = [aws_subnet.public_main]
}

