variable "dns" {
  default = "ya.dekker-and.digital"
}

resource "aws_route53_zone" "main" {
  name = var.dns
}

output "main_name_servers" {
  value = aws_route53_zone.main.name_servers
}

resource "aws_route53_record" "main-txt" {
  zone_id = aws_route53_zone.main.id
  name = var.dns
  type = "TXT"
  records = [
    "test=abc", # more text records can be added below
  ]
  ttl = 900
}

resource "aws_route53_record" "ya-che" {
  name = "ya.dekker-and.digital"
  zone_id = aws_route53_zone.main.id
  type = "NS"
  ttl = 900
  records = [
      "ns-1654.awsdns-14.co.uk.",
      "ns-1085.awsdns-07.org.",
      "ns-995.awsdns-60.net.",
      "ns-129.awsdns-16.com."
  ]
}
