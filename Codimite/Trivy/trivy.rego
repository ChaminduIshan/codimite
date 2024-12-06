package terraform.gcs

# Ensure all GCS buckets have encryption enabled
deny["GCS bucket without encryption"] {
  input.resource_type == "google_storage_bucket"
  not input.resource.config.encryption
}

# Ensure GCS buckets are encrypted with the 'AES256' encryption type
deny["GCS bucket encryption not AES256"] {
  input.resource_type == "google_storage_bucket"
  input.resource.config.encryption != "AES256"
}

# Ensure that the project is restricted to a predefined set of allowed projects
allowed_projects = {
    "project-id-1",
    "project-id-2"
}

deny["Project not allowed"] {
  input.resource_type == "google_storage_bucket"
  not input.resource.config.project
}

deny["Project not allowed"] {
  input.resource_type == "google_storage_bucket"
  not input.resource.config.project in allowed_projects
}
