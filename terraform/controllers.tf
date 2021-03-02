resource "aws_instance" "controller" {
    count = var.master_count
    ami = var.ami
    instance_type = var.controller_instance_type

    iam_instance_profile = aws_iam_instance_profile.kubernetes.id
    subnet_id=tolist(data.aws_subnet_ids.public.ids)[count.index]
    #subnet_id = data.aws_subnet_ids.public[count.index]
    private_ip = var.master_pvt_ip
    associate_public_ip_address = true # Instances have public, dynamic IP
    source_dest_check = false # TODO Required??

    #availability_zone = "${var.region}${var.az[count.index]}"
    vpc_security_group_ids = [aws_security_group.kubernetes-securitygroup.id]
    key_name = "kubernetes-poc"
    tags = {
      Name = "controller-${count.index}"
      ansibleNodeType = "controller"
      k8s-control-plane = ""
      "kubernetes.io/cluster/kubernetes" = "owned"
    }
}
