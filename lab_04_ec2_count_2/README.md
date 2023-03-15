The main purpose of this lab is to explore an undesirable behavior of using "count"

This lab also introduces a data source to use the latest Amazon linux AMI, instead of a "hard-coded" ami

Main thing to test

- create 4 instances

echo aws_instance.server[*].id | terraform console
[
  "i-0d91fe62578dadb1b",       (dep1)
  "i-0859c8e995606a474",       <<<< this is the one we want to delete in the next step... (dep2)
  "i-0cecacac55c431c51",       (dep3)
  "i-0fc6511b60c5a9abc",       (dep4)
]

Now remove "dep2" from the list  
(in default  or in terraform.tfvars)

And do terraform apply

Let's see what instances we have....

echo aws_instance.server[*].id | terraform console
[
  "i-0d91fe62578dadb1b",
  "i-0859c8e995606a474",  <<< not deleted...    terraform has just deleted the last one (originaly dep4)
  "i-0cecacac55c431c51",
]