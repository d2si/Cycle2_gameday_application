output "vpcid" {
  value = "${aws_vpc.main.id}"
}

output "subnetid" {
  value = "${aws_subnet.public.id}"
}
