module "Manager1-asg" {
  source = "./modules/tom_asg"
  count = var.text_instance_count
  launch_configuration = aws_launch_configuration.manager_conf[count.index]
  min = var.text_group_size[0]
  max = var.text_group_size[2]
  desired = var.text_group_size[1]
  health_check = 300
  health_check_type = "ELB"
  force_delete = true
  subnet_list = module.vpc.pubsubnet
  pName = var.pName
  type_of_instance = "manager"
}

module "Music-asg" {
  source = "./modules/tom_asg"
  launch_configuration = aws_launch_configuration.voice_conf
  min = var.music_group_size[0]
  max = var.music_group_size[2]
  desired = var.music_group_size[1]
  health_check = 300
  health_check_type = "ELB"
  force_delete = true
  subnet_list = module.vpc.pubsubnet  
  pName = var.pName
  type_of_instance = "music"
}

