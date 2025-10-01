loki:
  schemaConfig:
    configs:
      - from: "2024-04-01"
        store: tsdb
        object_store: s3
        schema: v13
        index:
          prefix: loki_index_
          period: 24h
  limits_config:
    allow_structured_metadata: true
    volume_enabled: true
    retention_period: 6h
  querier:
    max_concurrent: 4
  auth_enabled: false
  storage:
    type: s3
    bucketNames:
      chunks: ${bucket_name}
    s3:
      endpoint: ${endpoint}
      region: ${region}
      s3ForcePathStyle: false

deploymentMode: SimpleScalable

backend:
  replicas: 2
  persistence:
    storageClass: gp2
read:
  replicas: 2
write:
  replicas: 2
  persistence:
    storageClass: gp2

chunksCache:
  allocatedMemory: 1024

ruler:
  enabled: false
  
serviceAccount:
  name: ${service_account}