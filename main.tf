provider "aws" {
  region  = var.region
  profile = "Interact_Dev"
}

################################################################################
# VPC 
resource "aws_vpc" "main" {
  cidr_block       = var.aws_vpc_main_cidr_block
  instance_tenancy = "default"

  tags = {
    Name = var.aws_vpc_tag_name
  }
}

# Subnets
resource "aws_subnet" "public_main" {
  count                   = length(data.aws_availability_zones.available.names)
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.${count.index}.0/24"
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  map_public_ip_on_launch = true
  tags = {
    Name = var.aws_subnet_public_main_tag_name
  }
}

# ECS execution role
resource "aws_iam_role" "ecs_task_execution_role" {
  name               = var.aws_iam_role_ecs_task_execution_role_name
  assume_role_policy = file("ecs-execution-role.json")
}

# ECS execution policy
resource "aws_iam_policy" "ecs_task_execution_policy" {
  name = var.aws_iam_policy_ecs_task_execution_policy_name

  policy = file("ecs-execution-policy.json")
}

# Attach execution policy to execution role
resource "aws_iam_role_policy_attachment" "ecs-role-attach" {
  role       = aws_iam_role.ecs_task_execution_role.name
  policy_arn = aws_iam_policy.ecs_task_execution_policy.arn
}

################################################################################

# ECR repository creation
resource "aws_ecr_repository" "directory" {
  name = var.aws_ecr_repository_name
}

# ECS Cluster creation
resource "aws_ecs_cluster" "main" {
  name = var.aws_ecs_cluster_name
}

# ECS Task Definition creation
resource "aws_ecs_task_definition" "task" {
  family                   = var.aws_ecs_task_definition_family
  network_mode             = var.aws_ecs_task_definition_network_mode
  requires_compatibilities = var.aws_ecs_task_definition_requires_compatibilities
  cpu                      = var.aws_ecs_task_definition_fargate_cpu
  memory                   = var.aws_ecs_task_definition_fargate_memory
  task_role_arn            = aws_iam_role.ecs_task_execution_role.arn
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  container_definitions    = <<DEFINITION
[
{
  "cpu": ${var.aws_ecs_task_definition_fargate_cpu},
  "image": "${var.docker_image}",
  "memory": ${var.aws_ecs_task_definition_fargate_memory},
  "name": "app",
  "networkMode": "awsvpc",
  "portMappings": [
    {
      "containerPort": ${var.app_port},
      "hostPort": ${var.app_port}
    }
  ]
}
]
DEFINITION
}

# ECS service SG creation
resource "aws_security_group" "ecs_tasks" {
  name        = var.ecs_sg_name
  description = var.ecs_sg_description
  vpc_id      = aws_vpc.main.id

  ingress {
    protocol    = "tcp"
    from_port   = var.app_port
    to_port     = var.app_port
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# ECS service creation
resource "aws_ecs_service" "main" {
  name            = var.aws_ecs_service_main_name
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.task.arn
  desired_count   = var.aws_ecs_service_main_task_count
  launch_type     = var.aws_ecs_service_main_launch_type

  network_configuration {
    security_groups  = [aws_security_group.ecs_tasks.id]
    subnets          = data.aws_subnet_ids.main.ids
    assign_public_ip = true
  }
}

################################################################################
# RDS Security group
resource "aws_security_group" "rds" {
  name        = var.aws_security_group_rds_name
  description = var.aws_security_group_rds_description
  vpc_id      = aws_vpc.main.id

  ingress {
    protocol        = "tcp"
    from_port       = var.db_port
    to_port         = var.db_port
    security_groups = [aws_security_group.ecs_tasks.id]
  }

  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# RDS DB Subnet Group
resource "aws_db_subnet_group" "default" {
  name       = var.aws_db_subnet_group_default_name
  subnet_ids = data.aws_subnet_ids.main.ids

}

# The RDS Database used by Wordpress application
resource "aws_db_instance" "default" {
  count                  = length(data.aws_availability_zones.available.names)
  allocated_storage      = var.db_storage
  storage_type           = var.db_storage_type
  engine                 = var.db_engine
  engine_version         = var.db_engine_version
  instance_class         = var.db_instance
  name                   = var.db_name
  username               = var.db_username
  password               = var.db_password
  parameter_group_name   = var.db_parameter_group_name
  vpc_security_group_ids = [aws_security_group.rds.id]
  db_subnet_group_name   = var.db_subnet_group_name
  skip_final_snapshot    = var.db_skip_final_snapshot_bool
  depends_on = [
    aws_db_subnet_group.default
  ]
}