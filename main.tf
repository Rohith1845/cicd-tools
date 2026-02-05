resource "aws_instance" "Jenkins" {
    ami = local.ami_id
    instance_type = "t3.small"
    vpc_security_group_ids = [ aws_security_group.main.id ]
    subnet_id = "subnet-01ea71230c86dea2b"
    
    root_block_device {
        volume_size = 50
        volume_type = "gp3" # or "gp2", depending on your preference
    }

    user_data = file("Jenkin.sh")

    tags =  merge(
        local.common_tags,
        {
        Name = "${var.project_name}-${var.environment}-jenkins"
        }
    )
}

resource "aws_instance" "Jenkins_Agent" {
    ami = local.ami_id
    instance_type = "t3.small"
    vpc_security_group_ids = [ aws_security_group.main.id ]
    subnet_id = "subnet-01ea71230c86dea2b"
    
    root_block_device {
        volume_size = 50
        volume_type = "gp3" # or "gp2", depending on your preference
    }

    user_data = file("jenkinsagent.sh")

    tags =  merge(
        local.common_tags,
        {
        Name = "${var.project_name}-${var.environment}-jenkins-agent"
        }
    )
}

# resource "aws_instance" "sonar" {
#     ami = local.ami_id
#     instance_type = "t2.large"
#     vpc_security_group_ids = [ aws_security_group.main.id ]
#     subnet_id = "subnet-01ea71230c86dea2b"
    
#     # root_block_device {
#     #     volume_size = 50
#     #     volume_type = "gp3" # or "gp2", depending on your preference
#     # }

#     user_data = file("sonar.sh")

#     tags =  merge(
#         local.common_tags,
#         {
#         Name = "${var.project_name}-${var.environment}-sonar"
#         }
#     )
# }

resource "aws_security_group" "main" {
  name        =  "${var.project_name}-${var.environment}-jenkins"
  description = "Created to attatch Jenkins and its agents"

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  ingress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  ingress {
    from_port        = 8080
    to_port          = 8080
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  ingress {
    from_port        = 9000
    to_port          = 9000
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = merge(
    local.common_tags,
    {
        Name = "${var.project_name}-${var.environment}-jenkins"
    }
  )
}

resource "aws_route53_record" "jenkins" {
    name = "jenkins.${var.domain_name}"
    zone_id = var.zone_id
    ttl = 1
    type = "A"
    records = [ aws_instance.Jenkins.public_ip ]
    allow_overwrite = true
}

resource "aws_route53_record" "jenkins-agent" {
    name = "jenkins-agent.${var.domain_name}"
    zone_id = var.zone_id
    ttl = 1
    type = "A"
    records = [ aws_instance.Jenkins_Agent.private_ip ]
    allow_overwrite = true
}

# resource "aws_route53_record" "sonar" {
#     name = "sonar.${var.domain_name}"
#     zone_id = var.zone_id
#     ttl = 1
#     type = "A"
#     records = [ aws_instance.sonar.public_ip ]
#     allow_overwrite = true
# }
