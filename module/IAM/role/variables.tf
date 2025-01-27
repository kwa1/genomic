# User configuration (dynamic)
variable "users" {
  description = "Map of users and their access configuration"
  type = map(object({
    access_type  = string
    environment  = string # Added environment tag for each user
    bucket_name  = string
  }))
  default = {
    "UserA" = {
      access_type = "read_write"
      environment = "dev"
      bucket_name = "bucket-a"
    },
    "UserB" = {
      access_type = "read_only"
      environment = "prod"
      bucket_name = "bucket-b"
    }
  }
}
