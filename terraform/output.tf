output "ec2_instance_ids" {
  value = aws_instance.tf-ansible-instance[*].id
}

output "ec2_public_ips" {
  value = aws_instance.tf-ansible-instance[*].public_ip
}

output "ec2_tags" {
  value = aws_instance.tf-ansible-instance[*].tags_all
}
