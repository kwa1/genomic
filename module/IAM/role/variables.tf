variable "users" {
  description = "Map of users and their access configuration"
  type = map(object({
    access_type  = string
    bucket_name = string
  }))
  default = {
    "UserA" = {
      access_type = "read_write"
      bucket_name = "bucket-a"
    },
    "UserB" = {
      access_type = "read_only"
      bucket_name = "bucket-b"
    }
  }
}
