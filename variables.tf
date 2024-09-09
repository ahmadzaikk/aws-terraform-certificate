variable "domain_name" {
  description = "The primary domain name for the ACM certificate"
  type        = string
}

variable "subject_alternative_names" {
  description = "List of alternative domain names for the ACM certificate"
  type        = list(string)
  default     = []
}

variable "zone_id" {
  description = "The Route 53 zone ID where DNS validation records should be created"
  type        = string
}
