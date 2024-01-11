module "ec2-private" {
  # META_ARGUMENTS depends_on
  depends_on = [module.vpc]
  source     = "terraform-aws-modules/ec2-instance/aws"
  version    = "5.6.0"

  # name = "${var.environment}-private_ec2"
  #instance_count = var.private_instance_count
  ami           = data.aws_ami.amzlinux2.id
  instance_type = var.instance_type
  key_name      = var.instance_keypair
  # used vpc-output file for reference 
  subnet_ids = [
    module.private_sg.security_group_vpc_id[0], module.private_sg.security_group_vpc_id[1]
  ]
  # user security-group-output for it
  vpc_security_group_ids = [module.private_sg.security_group_vpc_id]
  tags                   = local.common_tags
  user_data              = file("${path.module}/app1-install.sh}")


}

