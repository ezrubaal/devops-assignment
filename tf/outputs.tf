output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.elad-home-task.id
}

output "subnet_a_id" {
  description = "The ID of the subnet in availability zone A"
  value       = aws_subnet.subnet_a.id
}

output "subnet_b_id" {
  description = "The ID of the subnet in availability zone B"
  value       = aws_subnet.subnet_b.id
}

output "eks_cluster_name" {
  description = "The name of the EKS cluster"
  value       = aws_eks_cluster.elad-home-task-k8s.name
}

output "eks_cluster_endpoint" {
  description = "The endpoint for the EKS cluster"
  value       = aws_eks_cluster.elad-home-task-k8s.endpoint
}

output "eks_cluster_certificate_authority" {
  description = "The certificate authority data for the EKS cluster"
  value       = aws_eks_cluster.elad-home-task-k8s.certificate_authority[0].data
}

output "eks_cluster_arn" {
  description = "The Amazon Resource Name (ARN) of the EKS cluster"
  value       = aws_eks_cluster.elad-home-task-k8s.arn
}

output "eks_node_group_name" {
  description = "The name of the EKS node group"
  value       = aws_eks_node_group.node_group.node_group_name
}

output "ecr_repository_eladviprojservice1_url" {
  description = "The URL of the ECR repository for eladviprojservice1"
  value       = aws_ecr_repository.eladviprojservice1.repository_url
}

output "ecr_repository_eladviprojservice2_url" {
  description = "The URL of the ECR repository for eladviprojservice2"
  value       = aws_ecr_repository.eladviprojservice2.repository_url
}

output "load_balancer_dns_name" {
  description = "The DNS name of the load balancer"
  value       = aws_lb.lb.dns_name
}

output "load_balancer_arn" {
  description = "The ARN of the load balancer"
  value       = aws_lb.lb.arn
}