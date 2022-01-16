terraform {
  backend "s3" {
    bucket                  = "praat-scripting-tfstate"
    key                     = "praat-scripting.tfstate"
    region                  = "us-east-1"
    shared_credentials_file = "/home/daniel/.aws/credentials"
    profile                 = "praatscripting"
  }
}