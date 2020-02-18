variable "dns" {
  default = "aa.dekker-and.digital"
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


resource "aws_route53_record" "alex-zone" {
  name = "ya.${var.dns}"
  zone_id = aws_route53_zone.main.id
  type = "NS"
  ttl = 900
  records = [
    "ns-1379.awsdns-44.org",
    "ns-1583.awsdns-05.co.uk",
    "ns-43.awsdns-05.com",
    "ns-716.awsdns-25.net"
  ]
}