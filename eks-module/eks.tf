resource "aws_eks_cluster" "cluster" {
  name     = "project-phoenix-eks-dev"
  version = "1.28"
  role_arn = aws_iam_role.k8sclusterrole  .arn

  vpc_config {
    subnet_ids = ["subnet-0037ea77d33152362", "subnet-0768e210a23009cd0"]
  }

  kubernetes_network_config {
    service_ipv4_cidr = "10.2.0.0/16"
  }

  # Ensure that IAM Role permissions are created before and deleted after EKS Cluster handling.
  # Otherwise, EKS will not be able to  properly delete EKS managed EC2 infrastructure such as Security Groups.
  depends_on = [
    aws_iam_role_policy_attachment.k8sclusterrole-AmazonEKSClusterPolicy,
    aws_iam_role_policy_attachment.k8sclusterrole-AmazonEKSVPCResourceController,
  ]

  tags = {
    Name = "project-phoenix-eks-dev"
    Owner = "project-phoenix-team b"
  }
}

data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["eks.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

#IAM role for EKS cluster 
resource "aws_iam_role" "k8sclusterrole" {
  name               = "project-phoenix-eks-dev-iam-role"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

resource "aws_iam_role_policy_attachment" "k8sclusterrole-AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.k8sclusterrole.name
}

# Optionally, enable Security Groups for Pods
# Reference: https://docs.aws.amazon.com/eks/latest/userguide/security-groups-for-pods.html
resource "aws_iam_role_policy_attachment" "k8sclusterrole-AmazonEKSVPCResourceController" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController"
  role       = aws_iam_role.k8sclusterrole.name
}

# output "endpoint" {
#   value = aws_eks_cluster.example.endpoint
# }

# output "kubeconfig-certificate-authority-data" {
#   value = aws_eks_cluster.example.certificate_authority[0].data
# } 

resource "aws_security_group" "k8scluster-sg" {
  name        = "eks-cluster-sg-project-phoenix-eks-dev"
  description = "Main security group of EKS cluster"
  vpc_id      = " " 

  ingress {
    description =  "Allow All Self"
    from_port = 0
    to_port = 0
    protocol = "-1"
    self = true
  }

   egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    "kubernetes.oi/cluster/project-phoenix-eks-dev" = "owned"
    "aws:eks:cluster-name" = "project-phoenix-eks-dev"
    Name =  "eks-cluster-sg-project-phoenix-eks-dev"
  
}
}

  