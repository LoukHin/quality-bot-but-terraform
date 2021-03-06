

##################################################################################
# RESOURCES
##################################################################################

# NETWORKING #
module "vpc" {
  source = "./modules/ProjectVPC"
  pName = var.pName
  network_address_space = var.network_address_space
  subnet_count = var.subnet_count

}

# SECURITY GROUPS #
# ALB Security Group
resource "aws_security_group" "Quality-SG" {
  name   = "${var.pName}-SG"
  vpc_id = module.vpc.Quality_VPC.id

  #Allow all outbound
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  #Allow SSH
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = { Name = "${var.pName}-SG"}
}

resource "aws_security_group" "quality-internal-web" {
  name   = "${var.pName}-internal-web"
  vpc_id = module.vpc.Quality_VPC.id

  #Allow all outbound
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.network_address_space]
  }

  #Allow SSH
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.network_address_space]
  }

  tags = { Name = "${var.pName}-internal-web"}

}

resource "aws_security_group" "Quality-RDS-SG" {
  name   = "${var.pName}-RDS-SG"
  vpc_id = module.vpc.Quality_VPC.id

  #Allow all outbound
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  #Allow SSH
  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = { Name = "${var.pName}-RDS-SG"}

}