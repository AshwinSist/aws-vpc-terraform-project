
# ==========================================
# PUBLIC SUBNET - AVAILABILITY ZONE 1
# ==========================================

resource "aws_subnet" "public_1" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "ap-southeast-2a"
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.project_name}-public-subnet-1"
  }
}


# ==========================================
# PRIVATE SUBNET - AVAILABILITY ZONE 1
# ==========================================

resource "aws_subnet" "private_1" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "ap-southeast-2a"

  tags = {
    Name = "${var.project_name}-private-subnet-1"
  }
}


# ==========================================
# PUBLIC SUBNET - AVAILABILITY ZONE 2
# ==========================================

resource "aws_subnet" "public_2" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.3.0/24"
  availability_zone       = "ap-southeast-2b"
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.project_name}-public-subnet-2"
  }
}


# ==========================================
# PRIVATE SUBNET - AVAILABILITY ZONE 2
# ==========================================

resource "aws_subnet" "private_2" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.4.0/24"
  availability_zone = "ap-southeast-2b"

  tags = {
    Name = "${var.project_name}-private-subnet-2"
  }
}
