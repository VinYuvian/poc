resource "aws_key_pair" "kubernetes_key" {
  key_name = "kubernetes_key"
  public_key = "${file("${var.PATH_TO_PUBLIC_KEY}")}"
}
