profile = "cta"
region  = "eu-west-1"

project     = "acme02"
environment = "dev"


instance_type = "t2.micro"


# sec_allowed_external = ["2.0.0.0/8", "80.0.0.0/8"]
sec_allowed_external = ["0.0.0.0/0"]
key_name             = "tf-course"
