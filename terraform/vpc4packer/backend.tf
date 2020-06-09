terraform {
  backend "s3" {
    bucket                  = "tfstate-gameday-chaos-2020-engieit268341914207"
    key                     = "app.tfstate"
    region                  = "eu-west-1"
    profile                 = "default"
    shared_credentials_file = "../credentials"
  }
}
