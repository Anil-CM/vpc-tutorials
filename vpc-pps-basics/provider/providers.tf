terraform {
  required_version = ">= 1.5"
  required_providers {
    ibm = {
      source = "IBM-Cloud/ibm"
      version = ">= 1.63"
    }
    restapi = {
      source  = "Mastercard/restapi"
      version = ">= 1.16.2"
    }
    template = {
      source = "hashicorp/template"
      version = "2.2.0"
    }
  }
}

provider "ibm" {
  region = var.region
}


provider "template" {

}