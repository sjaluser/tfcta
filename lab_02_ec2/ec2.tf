
## Create instance - will use defaults for parameters not specified (e.g. VPC, security group)
resource "aws_instance" "prueba1" {
    ami           = var.my_ami
    instance_type = var.instance_type
    vpc_security_group_ids = [aws_security_group.sec_web.id]
    key_name = "test_key_pairs"
    availability_zone = "eu-west-1c"
    tags = {
        Name = "prueba1"
        Lab    = "vm_lab2"
    }
}

resource "aws_instance" "prueba2" {
    ami           = "ami-0bd640fa6e169627b"
    instance_type = var.instance_type
    ebs_block_device {
      device_name = "/dev/xvda"
      volume_size = 10
    }

    vpc_security_group_ids = [aws_security_group.sec_web.id]
    availability_zone = "eu-west-1a"
    key_name = "test_key_pairs"
    user_data = <<EOF
      #!/bin/bash
      sudo mkdir /data
      sudo mount /dev/sdh /data
    EOF
    tags = {
        Name = "prueba2"
        Lab    = "vm_lab2"
    }
}

resource "aws_volume_attachment" "ebs_att" {
  device_name = "/dev/sdh"
  volume_id   = "vol-02fc50d32360df654"
  instance_id = aws_instance.prueba2.id
  
}







