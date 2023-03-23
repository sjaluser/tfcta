


resource "aws_instance" "cassandra" {
    ami           = "ami-0bd640fa6e169627b"
    instance_type = "t2.large"
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
  instance_id = aws_instance.cassandra.id
  
}







