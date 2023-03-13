TODO

## Play with terraform  required_version 
- Try changing it to 

required_version = "<= 1.2.9"

why does it or does it not work?

## Play with aws provider version
- Try using :
version = "< 4.0"

You will have to run terraform init -upgrade

What is actually happening?
- Execute the command 

tree .terraform  (or equivalent for Windows)

You can see that terraform has downloaded and installed another version of the provider... something like 3.76.1

- See also the hidden file  .terraform.lock.hcl - note that it refers to the version of the provider (smaller than 4.0) that you just activated

- Now go back to the latest version of the provider by uncommenting version = "~> 4.16",   and running again terraform init -upgrade.   

Verify the file .terraform.lock.hcl
