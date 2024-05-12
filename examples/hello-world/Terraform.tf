#  provider and region
provider "aws" {
  region = "aws-region"
}

# Creating  an ECS cluster
resource "aws_ecs_cluster" "my_cluster" {
  name = "ecs-cluster"
}

# Creating  a task definition for  ECS service
resource "aws_ecs_task_definition" "my_task" {
  family                   = "ecs-task"
  container_definitions   = jsonencode([
    {
      name      = "my-container",
      image     = "ecr-registry-url/my-nodejs-app:latest"
      cpu       = 256,
      memory    = 512,
      essential = true,
      portMappings = [{
        containerPort = 8080,
        hostPort      = 8080,
        protocol      = "tcp",
      }]
    }
  ])
}

# Creating an ECS service
resource "aws_ecs_service" "my_service" {
  name            = "my-ecs-service"
  cluster         = aws_ecs_cluster.my_cluster.id
  task_definition = aws_ecs_task_definition.my_task.arn
  desired_count   = 1
  launch_type     = "FARGATE" 
  network_configuration {
    subnets         = subnet is 
    security_groups = security group id 
    assign_public_ip = true
  }
}
