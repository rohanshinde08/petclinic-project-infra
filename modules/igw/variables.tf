variable "vpc_id" {
    description = "VPI ID"
    type        = string
}

variable "name" {
  description = "Name to be used on all the resources as identifier"
  type        = string
  default     = ""
}

variable "tags" {
    description = "Resource Tags"
    type        = map(string)
    default     = {}
}