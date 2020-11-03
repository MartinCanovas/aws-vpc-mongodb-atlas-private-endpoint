output "mongo_uri" {
  value = mongodbatlas_cluster.my_cluster.mongo_uri_with_options
}

output "atlas_connection_string" {
    value = mongodbatlas_cluster.my_cluster.connection_strings
}

output "bastion_public_ip" {
  value = module.bastion.*.public_ip
}

output "app_private_ip" {
  value = module.app.private_ip
}