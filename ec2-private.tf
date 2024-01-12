module "ec2-private" {
  # META_ARGUMENTS depends_on
  depends_on = [module.vpc]
  source     = "terraform-aws-modules/ec2-instance/aws"
  version    = "5.6.0"

   name = "${var.environment}-private_ec2"
  #instance_count = var.private_instance_count
  ami           = data.aws_ami.amzlinux2.id
  instance_type = var.instance_type
  key_name      = var.instance_keypair
  # used vpc-output file for reference 
 /*
    # the below code is commented because it is not working for the above versions
   subnet_ids = [
    module.private_sg.security_group_vpc_id[0], module.private_sg.security_group_vpc_id[1]
  ]
*/
  # user security-group-output for it
  vpc_security_group_ids = [module.private_sg.security_group_vpc_id]
   # the for_each and subnet_id is used here because we want to use 2 subnets for the private instance
   for_each = toset(["0","1"])
   subnet_id = element(module.vpc.private_subnets, tonumber(each.key))
  tags                   = local.common_tags
  user_data              = file("${path.module}/app1-install.sh")

}

