# Setup project_ID
variable "project_id" {
  description = "Google Cloud project ID"
  default     = "codimite"  # Your project ID
}

# Setup Region
variable "region" {
  description = "Region where resources will be created"
  default     = "asia-south1" 
}

# Setup bucket name
variable "gcs_bucket_name" {
  description = "GCS bucket name for storing Terraform state"
  default     = "codimite-terraform-state-bucket"  
}
