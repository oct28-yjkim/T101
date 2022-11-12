# AWS Route53 Zone 
resource "aws_route53_zone" "se4ofnight_ml" {
  name = "se4ofnight.ml"
}


# devops-test.se4ofnight.ml
# MX Record for G. Suite
resource "aws_route53_record" "se4ofnight_ml_mx" {
  zone_id = aws_route53_zone.se4ofnight_ml.zone_id
  name    = "se4ofnight.ml"
  type    = "MX"
  ttl     = "3600"
  records = [
    "1 ASPMX.L.GOOGLE.COM.",
    "5 ALT1.ASPMX.L.GOOGLE.COM.",
    "5 ALT2.ASPMX.L.GOOGLE.COM.",
    "10 ALT3.ASPMX.L.GOOGLE.COM.",
    "10 ALT4.ASPMX.L.GOOGLE.COM."
  ]
}

# CNAME Record Example
resource "aws_route53_record" "dev_se4ofnight_ml" {
  zone_id = aws_route53_zone.se4ofnight_ml.zone_id
  name    = "devops-test.se4ofnight.ml."
  type    = "CNAME"
  ttl     = "300"
  records = ["www.se4ofnight.ml"]
}

