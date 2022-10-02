#create frontend web server
resource "aws_instance" "jumpbox-srv" {
  ami                         = "ami-08d4ac5b634553e16"
  instance_type               = "t2.micro"
  vpc_security_group_ids      = [aws_security_group.jumpbox-srv-sg.id]
  key_name                    = "dev2-kp"
  subnet_id                   = aws_subnet.public-SN2.id
  associate_public_ip_address = true

  root_block_device {
    volume_size           = 30
    delete_on_termination = true
  }
  tags = {
    Name = "jumpbox-mobikart3-srv"
  }
}


#create security group for frontend

resource "aws_security_group" "jumpbox-srv-sg" {
  name        = "jumpbox-srv-sg"
  description = "Allow  traffic to srv"
  vpc_id      = aws_vpc.main-vpc.id

  ingress = [
  
  {
    description      = "SSH"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["74.132.208.143/32"]
    ipv6_cidr_blocks = []
    prefix_list_ids = []
    security_groups = []
    self = true
  },

 
 {
    description      = "ICMP"
    from_port        = -1
    to_port          = -1
    protocol         = "icmp"
    cidr_blocks      = ["74.132.208.143/32"]
    ipv6_cidr_blocks = []
    prefix_list_ids = []
    security_groups = []
    self = true
  }

 ]

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "jumpbox-sg"
  }
}
  