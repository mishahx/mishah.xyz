module "static_website" {
  source = "./static-website"

  for_each = var.websites

  bucket_name = each.key
  error_page = each.value["error_page"]
  index_page = each.value["index_page"]
  website_dir = each.value["website_dir"]

  tags = var.tags
}