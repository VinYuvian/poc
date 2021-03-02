# K8s Worker Instances

resource "aws_instance" "worker" {
    count = var.worker_count
    subnet_id=count.index+1>length(tolist(data.aws_subnet_ids.public.ids))?tolist(data.aws_subnet_ids.public.ids)[count.index%2]:tolist(data.aws_subnet_ids.public.ids)[count.index]
    ami = var.ami
    instance_type = var.worker_instance_type
    #subnet_id=tolist(data.aws_subnet_ids.public.ids)[count.index]
    #subnet_id = data.aws_subnet_ids.public.ids[count.index]
    #private_ip = cidrhost("${var.public[count.index]}/24", 30 + count.index)
    associate_public_ip_address = true # Instances have public, dynamic IP
    source_dest_check = false # TODO Required??

    #availability_zone = "${var.region}${var.az[count.index]}"
    vpc_security_group_ids = [aws_security_group.kubernetes-securitygroup.id]
    key_name = "kubernetes-poc"
    tags = {
      Name = "worker-${count.index}"
      ansibleNodeType = "worker"
      ansibleNodeName = "worker${count.index}"
    }
}

output "kubernetes_workers_public_ip" {
  value = join(",", aws_instance.worker.*.public_ip)
}
