terraform {
  cloud {
    hostname     = "app.terraform.io"
    organization = "Meet-08"
    workspaces {
      name = "terra-ansible-demo"
    }
  }
}