variable "service_type" {
  type = string
  description = "Service type can be LoadBalancer, NodePort, ClusterIP"
}


variable "replica_count" {
  type = number
  description = "Replica count can increase the numbe of pods needed"
 
}