resource "aws_eip" "bastien_eip" {
depends_on = [module.ec2_public, module.vpc]

instance = module.ec2-public.id[0]
vpc = true
depends_on = var.enable_nat_gateway 
tags = local.common_tags
}
