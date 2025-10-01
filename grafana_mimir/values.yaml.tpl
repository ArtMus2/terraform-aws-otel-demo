mimir:
  structuredConfig:
    frontend:
      max_outstanding_per_tenant: 400
    multitenancy_enabled: false
    limits:
      max_global_exemplars_per_user: 100000
      max_label_names_per_series: 50
      ingestion_rate: 50000
      ingestion_burst_size: 400000
      out_of_order_time_window: 30m
      max_query_parallelism: 50
    blocks_storage:
      backend: s3
      s3:
        endpoint: ${endpoint}
        region: ${region}
        bucket_name: ${bucket_name}

overrides_exporter:
  enabled: false

serviceAccount:
  name: ${service_account}

admin_api:
  enabled: false

admin-cache:
  enabled: false

alertmanager:
  enabled: false

chunks-cache:
  enabled: false

compactor:
  topologySpreadConstraints:
    enabled: false
  persistentVolume:
    storageClass: gp2
    size: 2Gi
  resources:
    limits:
      memory: 512Mi
    requests:
      cpu: 100m
      memory: 256Mi

distributor:
  replicas: 1
  resources:
    limits:
      memory: 512Mi
    requests:
      #cpu: 100m
      memory: 256Mi

gateway:
  enabled: false

index-cache:
  enabled: false

ingester:
  persistentVolume:
    storageClass: gp2
    size: 5Gi
  replicas: 2
  ring:
    replication_factor: 2
  resources:
    requests:
      memory: 512Mi
  topologySpreadConstraints: {}
  affinity: {}
  zoneAwareReplication:
    enabled: false
    migration:
      replicas: 0
      enabled: false

metadata-cache:
  enabled: false

minio:
  enabled: false

nginx:
  enabled: true

querier:
  replicas: 1
  resources:
    limits:
      cpu: 200m
      memory: 512Mi
    requests:
      cpu: 100m
      memory: 512Mi

query_frontend:
  replicas: 1
  resources:
    requests:
      cpu: 100m
      memory: 512Mi

query_scheduler:
  enabled: false

results-cache:
  enabled: false

ruler:
  enabled: false

store_gateway:
  persistentVolume:
    storageClass: gp2
  replicas: 2
  resources:
    limits:
      memory: 512Mi
    requests:
      cpu: 100m
      memory: 256Mi
  topologySpreadConstraints:
    enabled: false
  affinity: {}
  zoneAwareReplication:
    enabled: false