# Generate inventory
data "template_file" "inventory" {
    template = file("${path.module}/templates/kubernetes-csr.tpl")
    depends_on = [aws_instance.controller,aws_instance.worker]
    vars = {
      controller0_ip = aws_instance.controller.0.public_ip
      worker0_ip = aws_instance.worker.0.public_ip
      worker1_ip = aws_instance.worker.1.public_ip
    }
}
resource "null_resource" "inventory" {
  triggers = {
    template_rendered = data.template_file.inventory.rendered
  }

  provisioner "local-exec" {
    command = "mkdir -p hosts/ && echo '${ data.template_file.inventory.rendered }' > hosts/kubernetes-csr"
  }
}