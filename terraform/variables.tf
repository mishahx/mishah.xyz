variable "websites" {
  type = map(map(string))
  default = {
    "www.mishah.xyz" = {
      index_page = "index.html"
      error_page = "error.html"
      website_dir = "www"
    }
    "test.mishah.xyz" = {
      index_page = "index.html"
      error_page = "error.html"
      website_dir = "test"
    }
  }
}

variable "tags" {
  type = map(string)
  default = {
    owner = "mishalshah92"
  }
}