locals {
  workers=var.worker_count - 1
}

data "aws_instances" "worker" {
  filter {
    name   = "tag:ansibleNodeType"
    values = ["worker"]
  }
  instance_state_names = ["running", "pending"]
  depends_on = [
    aws_instance.worker
  ]
}

data "aws_instances" "master" {
  filter {
    name   = "tag:ansibleNodeType"
    values = ["controller"]
  }
  instance_state_names = ["running", "pending"]
  depends_on = [
    aws_instance.controller
  ]
}

resource "null_resource" "inventory_worker" {
        triggers = {
              always_run = timestamp()
              #order = aws_cloudwatch_metric_alarm.cpu[local.workers].id
        }
        count = var.worker_count
        provisioner "local-exec"{
			command="/bin/bash inventory.sh '[workers]' 'worker${count.index} ansible_host=${data.aws_instances.worker.public_ips[count.index]}'"
	    }
      depends_on = [
            aws_cloudwatch_metric_alarm.cpu
        ]
}

resource "time_sleep" "wait_15_seconds" {
  depends_on = [null_resource.inventory_worker]

  create_duration = "15s"
}

resource "null_resource" "inventory_master" {
        triggers = {
              order = null_resource.inventory_worker[local.workers].id
        }
        count = var.master_count
        provisioner "local-exec"{
			command="/bin/bash inventory.sh '[masters]' 'master ansible_host=${data.aws_instances.master.public_ips[count.index]}'"
	    }
        depends_on = [
            time_sleep.wait_15_seconds
        ]
}
