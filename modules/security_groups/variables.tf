variable "vpc_id" {
    description = "VPI ID"
    type        = string
}

variable "name" {
    description = "Name for sg"
    type        = string
}

variable "tags" {
    description = "Resource Tags"
    type        = map(string)
    default     = {}
}

