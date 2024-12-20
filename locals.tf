locals {
  region_list = [
    "af-johannesburg-1",
    "ap-chuncheon-1",
    "ap-dcc-canberra-1",
    "ap-hyderabad-1",
    "ap-melbourne-1",
    "ap-mumbai-1",
    "ap-osaka-1",
    "ap-seoul-1",
    "ap-singapore-1",
    "ap-sydney-1",
    "ap-tokyo-1",
    "ca-montreal-1",
    "ca-toronto-1",
    "eu-amsterdam-1",
    "eu-frankfurt-1",
    "eu-frankfurt-2",
    "eu-jovanovac-1",
    "eu-madrid-1",
    "eu-madrid-2",
    "eu-marseille-1",
    "eu-milan-1",
    "eu-paris-1",
    "eu-stockholm-1",
    "eu-zurich-1",
    "il-jerusalem-1",
    "me-abudhabi-1",
    "me-dubai-1",
    "me-jeddah-1",
    "mx-monterrey-1",
    "mx-queretaro-1",
    "sa-santiago-1",
    "sa-saopaulo-1",
    "sa-vinhedo-1",
    "uk-cardiff-1",
    "uk-gov-cardiff-1",
    "uk-gov-london-1",
    "uk-london-1",
    "us-ashburn-1",
    "us-chicago-1",
    "us-gov-ashburn-1",
    "us-gov-chicago-1",
    "us-gov-phoenix-1",
    "us-langley-1",
    "us-luke-1",
    "us-phoenix-1",
    "us-sanjose-1"
  ]

  defined_tags = {
    "Operation-Tags.CreatedBy"        = "Terraform"
    "Operation-Tags.TerraformVersion" = var.terraform_version
    "Resource-Tags.Region"            = var.region
  }
}