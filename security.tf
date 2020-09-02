resource "aws_security_group" "sg_bastion" {
    name          = "bastion"
    description   = "Allow only port 22"
    vpc_id        = module.vpc.vpc_id

    ingress {
        description = "Allow SSH inbound traffic"
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

  tags = {
    Name = "Allow SSH"
  }
}

resource "aws_security_group" "sg_app" {
    name          = "App"
    description   = "App SG"
    vpc_id        = module.vpc.vpc_id

    ingress {
        description     = "Allow SSH inbound traffic"
        from_port       = 22
        to_port         = 22
        protocol        = "tcp"
        security_groups = [aws_security_group.sg_bastion.id]
    }

    ingress {
        description = "Allow MongoDB inbound traffic"
        from_port   = 27017
        to_port     = 27050
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

  tags = {
    Name = "App SG"
  }
}

resource "aws_security_group" "sg_endpoint" {
    name          = "endpoint"
    description   = "Endpoint SG"
    vpc_id        = module.vpc.vpc_id

    ingress {
        description     = "Allow all traffic from Replica Set"
        from_port       = 0
        to_port         = 65535
        protocol        = "tcp"
        security_groups = [aws_security_group.sg_app.id]
    }

    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

  tags = {
    Name = "Endpoint SG"
  }
}