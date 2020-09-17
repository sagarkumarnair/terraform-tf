module "vpc" {
  source               = "../../modules/vpc"
  vpc_id               = module.vpc.vpc_id
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
  public_subnet        = "10.0.101.0/24"
  public_subnet2        = "10.0.102.0/24"

}

module "myec2" {
  source        = "../../modules/ec2"
  name          = "instance1"
  instance_type = "t2.micro"
  key_name      = "skweb"
  ami           = "ami-0ebc1ac48dfd14136"
  public_subnet_id_1 = "${module.vpc.public_subnet_id_1}"
  public_subnet_id_2 = "${module.vpc.public_subnet_id_2}"

  vpc_security_group_ids = ["${module.vpc.security_group_id}"]

}




###################################################
# Calling Module aws_alb

module "alb" {
  source = "../../modules/alb"
  name = "my-alb"

  load_balancer_type = "application"

  internal = false

  subnet1             = module.vpc.public_subnet_id_1
  subnet2             = module.vpc.public_subnet_id_2
  security_groups     = ["module.alb.security_group_id"]



#Target group

target_group_port = 80
target_group_protocol = "HTTP"
target_type  = "instance"

vpc_id  = module.vpc.vpc_id



instance1_id = "${module.myec2.instance1_id}"
instance2_id = "${module.myec2.instance2_id}"



# ALB Listner
      port               = 80
      protocol           = "HTTP"

}
