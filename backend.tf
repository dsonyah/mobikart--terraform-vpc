#create backend server
resource "aws_instance" "backend-srv" {
  ami                         = "ami-08d4ac5b634553e16"
  instance_type               = "t2.micro"
  vpc_security_group_ids      = [aws_security_group.backend-srv-sg.id]
  key_name                    = "dev2-kp"
  subnet_id                   = aws_subnet.private-SN1.id
  associate_public_ip_address = false

  root_block_device {
    volume_size           = 30
    delete_on_termination = true
  }
  tags = {
    Name = "backend-mobikart3-srv"
  }
}



#create security group for backend

resource "aws_security_group" "backend-srv-sg" {
  name        = "backend-srv-sg"
  description = "Allow  traffic to srv"
  vpc_id      = aws_vpc.main-vpc.id

  ingress = [
 {
    description      = "HTTP"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["10.0.0.0/16"]
    ipv6_cidr_blocks = []
    prefix_list_ids = []
    security_groups = []
    self = true
  },

  {
    description      = "SSH"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["10.0.0.0/16"]
    ipv6_cidr_blocks = []
    prefix_list_ids = []
    security_groups = []
    self = true
  },

 {
    description      = "CUSTOM TCP"
    from_port        = 3000
    to_port          = 3000
    protocol         = "tcp"
    cidr_blocks      = ["10.0.0.0/16"]
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
    cidr_blocks      = ["10.0.0.0/16"]
    ipv6_cidr_blocks = []
    prefix_list_ids = []
    security_groups = []
    self = true
  },


  {
    description      = "mysql/Aurora"
    from_port        = 3306
    to_port          = 3306
    protocol         = "tcp"
    cidr_blocks      = ["10.0.0.0/16"]
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
    Name = "github-mobikart3-sg"
  }
}
  