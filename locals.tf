locals {
    ami_id = data.aws_ami.rohithdevops.id
    vpc = data.aws_vpc.default.id
    common_tags = {
        Project = var.project_name
        Environment = var.environment
        terraform = true
    }
}