vpc_id               = "vpc-0066db5148d7f9183"
subnets_ids          = ["subnet-0037ea77d33152362", "subnet-0768e210a23009cd0"]
cluster_version      = "1.28"
services_cidr        = "10.2.0.0/16"
stage                = "dev"
project              = "project-phoenix"
workers_desired      = 2
workers_max          = 5
workers_min          = 1
workers_pricing_type = "SPOT"
instance_types       = ["t3.micro"]
