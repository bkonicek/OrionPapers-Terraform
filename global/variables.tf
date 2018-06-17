variable "region" {
  description = "AWS Region"
  default     = "us-east-1"
}

variable "allow_user_change" {
  description = "Allow users to change their own passwords."
  default     = true
}

variable "min_pw_length" {
  description = "Minimum password length"
  default     = 8
}

variable "require_lowercase" {
  description = "Require password to have lowercase letters"
  default     = true
}

variable "require_nums" {
  description = "Require password to have at least one number"
  default     = true
}

variable "require_sym" {
  description = "Require password to have at least one symbol"
  default     = true
}

variable "max_pw_age" {
  description = "Maximum age of password (in days) before it must be changed"
  default     = 180
}

variable "expiry" {
  description = "Can users change their password once it expires?"
  default     = false
}

variable "password_reuse" {
  description = "Number of previous passwords to track that cannot be set as new passwords"
  default     = 3
}

variable "s3_full_access_policy" {
  description = "ARN of premade S3 access policy"
  default     = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}
