output "public_subnet_id_1" {

  value = module.vpc.public_subnet_id_1
}


output "vpc_id" {
  value = module.vpc.vpc_id
}

output "vpc_default_security_group_id" {
  value = module.vpc.vpc_security_group_ids
}

output "custom_security_group_id"{
  value = module.vpc.security_group_id
}
