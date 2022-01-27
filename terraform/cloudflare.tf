resource "cloudflare_zone" "domain" {
  zone    = var.domain
}


resource "cloudflare_record" "site_cname" {
  # zone_id = data.cloudflare_zones.domain.zones[0].id
  zone_id = cloudflare_zone.domain.id
  name    = var.domain
  value   = aws_s3_bucket.bucket.website_endpoint
  type    = "CNAME"

  ttl     = 1
  proxied = true
}

resource "cloudflare_record" "www" {
  # zone_id = data.cloudflare_zones.domain.zones[0].id
  zone_id = cloudflare_zone.domain.id
  name    = "www"
  value   = var.domain
  type    = "CNAME"

  ttl     = 1
  proxied = true
}

resource "cloudflare_page_rule" "https" {
  zone_id = cloudflare_zone.domain.id
  target  = "*.${var.domain}/*"
  actions {
    always_use_https = true
  }
}