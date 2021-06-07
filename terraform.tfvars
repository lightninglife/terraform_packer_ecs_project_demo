region                                           = "eu-west-1"
aws_vpc_main_cidr_block                          = "10.0.0.0/16"
aws_vpc_tag_name                                 = "main"
aws_subnet_public_main_tag_name                  = "main"
aws_iam_role_ecs_task_execution_role_name        = "ecs-execution-role"
aws_iam_policy_ecs_task_execution_policy_name    = "ecs-execution-policy"
aws_ecr_repository_name                          = "aws_ecr_repository"
aws_ecs_cluster_name                             = "aws_ecs_fargate_cluster"
aws_ecs_task_definition_family                   = "wordpress"
aws_ecs_task_definition_network_mode             = "awsvpc"
aws_ecs_task_definition_requires_compatibilities = ["FARGATE"]
aws_ecs_task_definition_fargate_cpu              = 1024
aws_ecs_task_definition_fargate_memory           = 2048
app_port                                         = 80
ecs_sg_name                                      = "wordpress-ecs-sg"
ecs_sg_description                               = "Allow inbound access in port 80 only"
aws_ecs_service_main_name                        = "ecs_service"
aws_ecs_service_main_task_count                  = 3
aws_ecs_service_main_launch_type                 = "FARGATE"
aws_security_group_rds_name                      = "wordpress-rds-sg"
aws_security_group_rds_description               = "Allow inbound access in port 3306 only"
db_port                                          = 3306
docker_image                                     = "docker.io/lightninglife/mycentosimage:latest"
aws_subnet_ids_main_filter_values                = "main"
aws_db_subnet_group_default_name                 = "rds-subnet-group"
db_storage                                       = 10
db_storage_type                                  = "gp2"
db_engine                                        = "MySQL"
db_engine_version                                = "5.6.48"
db_instance                                      = "db.t2.micro"
db_name                                          = "wordpress"
db_username                                      = "wordpress"
db_password                                      = "ecsproject"
db_parameter_group_name                          = "default.mysql5.6"
db_subnet_group_name                             = "rds-subnet-group"
db_skip_final_snapshot_bool                      = true