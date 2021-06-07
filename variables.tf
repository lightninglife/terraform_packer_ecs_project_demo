variable "region" {
  type        = string
  description = "region"
}

variable "aws_vpc_main_cidr_block" {
  type        = string
  description = "aws_vpc_main_cidr_block"
}

variable "aws_vpc_tag_name" {
  type        = string
  description = "aws_vpc_tag_name"
}

variable "aws_subnet_public_main_tag_name" {
  type        = string
  description = "aws_subnet_public_main_tag_name"
}

variable "aws_iam_role_ecs_task_execution_role_name" {
  type        = string
  description = "aws_iam_role_ecs_task_execution_role_name"
}

variable "aws_iam_policy_ecs_task_execution_policy_name" {
  type        = string
  description = "aws_iam_policy_ecs_task_execution_policy_name"
}

variable "aws_ecr_repository_name" {
  type        = string
  description = "aws_ecr_repository_name"
}

variable "aws_ecs_cluster_name" {
  type        = string
  description = "aws_ecs_cluster_name"
}

variable "aws_ecs_task_definition_family" {
  type        = string
  description = "aws_ecs_task_definition_family"
}

variable "aws_ecs_task_definition_network_mode" {
  type        = string
  description = "aws_ecs_task_definition_network_mode"
}

variable "aws_ecs_task_definition_requires_compatibilities" {
  type        = list(string)
  description = "aws_ecs_task_definition_requires_compatibilities"
}

variable "aws_ecs_task_definition_fargate_cpu" {
  type        = number
  description = "aws_ecs_task_definition_fargate_cpu"
}

variable "aws_ecs_task_definition_fargate_memory" {
  type        = number
  description = "aws_ecs_task_definition_fargate_memory"
}

variable "app_port" {
  type        = number
  description = "app_port"
}

variable "ecs_sg_name" {
  type        = string
  description = "ecs_sg_name"
}

variable "ecs_sg_description" {
  type        = string
  description = "ecs_sg_description"
}

variable "aws_ecs_service_main_name" {
  type        = string
  description = "aws_ecs_service_main_name"
}

variable "aws_ecs_service_main_task_count" {
  type        = number
  description = "aws_ecs_service_main_task_count"
}

variable "aws_ecs_service_main_launch_type" {
  type        = string
  description = "aws_ecs_service_main_launch_type"
}

variable "aws_security_group_rds_name" {
  type        = string
  description = "aws_security_group_rds_name"
}

variable "aws_security_group_rds_description" {
  type        = string
  description = "aws_security_group_rds_description"
}

variable "aws_subnet_ids_main_filter_values" {
  type        = string
  description = "aws_subnet_ids_main_filter_values"
}

variable "db_port" {
  type        = number
  description = "Port to access the database"
}

variable "docker_image" {
  type        = string
  description = "Docker image to run in the ECS cluster"
}

variable "aws_db_subnet_group_default_name" {
  type        = string
  description = "aws_db_subnet_group_default_name"
}

variable "db_storage" {
  type        = number
  description = "The DB storage value"
}

variable "db_storage_type" {
  type        = string
  description = "db_storage_type"
}

variable "db_engine" {
  type        = string
  description = "db_engine"
}

variable "db_engine_version" {
  type        = string
  description = "db_engine_version"
}

variable "db_instance" {
  type        = string
  description = "db_instance"
}

variable "db_name" {
  type        = string
  description = "db_name"
}

variable "db_username" {
  type        = string
  description = "db_username"
}

variable "db_password" {
  type        = string
  description = "db_password"
}

variable "db_parameter_group_name" {
  type        = string
  description = "db_parameter_group_name"
}

variable "db_subnet_group_name" {
  type        = string
  description = "db_subnet_group_name"
}

variable "db_skip_final_snapshot_bool" {
  type        = bool
  description = "db_skip_final_snapshot_bool"
}