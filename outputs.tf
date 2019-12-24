output "private_key_for_ec2" {
  value = "${tls_private_key.harvestMoon.private_key_pem}"
}
