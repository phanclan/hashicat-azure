terraform {
  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "pphan"

    workspaces {
      name = "hashicat-azure"
    }
  }
}