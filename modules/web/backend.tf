terraform {
  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "pphan-servicenow"

    workspaces {
      name = "hashicat-azure-web"
    }
  }
}