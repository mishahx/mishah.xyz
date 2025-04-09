variable "bucket_name" {
  type = string
  default = "www.drmayurpatel.in"
}

variable "index_page" {
  type    = string
  default = "index.html"
}

variable "error_page" {
  type    = string
  default = "error.html"
}

variable "website_dir" {
  type = string
}

variable "tags" {
  type = map(string)
  default = {
    owner = "mishalshah92"
  }
}