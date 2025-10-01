serviceAccount:
  name: ${service_account}
storage:
  trace:
    backend: s3
    s3:
      endpoint: ${endpoint}
      region: ${region}
      bucket_name: ${bucket_name}
traces:
  otlp:
    grpc:
      enabled: true
    http:
      enabled: true
