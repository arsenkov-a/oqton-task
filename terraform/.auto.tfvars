aws_region = "us-east-1"
environment_name = "test-env"
eks_cluster_name = "test"
helm_charts = {
  mongo = {
    repo = "https://charts.bitnami.com/bitnami"
    chart = "mongodb"
    version = "13.6.6"
    namespace = "mongo"
    extra_vars = {
      "architecture" = "replicaset"
    }
    extra_secrets = [
      "auth.replicaSetKey"
    ]
  }
}
