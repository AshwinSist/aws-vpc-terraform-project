
# REFERENCE ONLY - NOT PART OF THE ACTIVE INFRASTRUCTURE
#
# This file contains an alternative NAT Instance implementation.
# It is intentionally stored outside the root Terraform directory.
# It is not included in the current Terraform deployment.
#
# The active project uses an S3 Gateway VPC Endpoint
# and does not include a NAT Instance or NAT Gateway.

resource "aws_security_group" "nat_sg" {
  name        = "${var.project_name}-nat-sg"
  description = "Allow traffic from private subnets"
  vpc_id      = aws_vpc.main.id

  ingress {
    description = "Allow private subnet traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"

    cidr_blocks = [
      "10.0.2.0/24",
      "10.0.4.0/24"
    ]
  }

  egress {
    description = "Allow outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project_name}-nat-sg"
  }
}



data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-2023.*-x86_64"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}


resource "aws_instance" "nat" {
  ami                    = data.aws_ami.amazon_linux.id
  instance_type          = "t3.micro"
  subnet_id              = aws_subnet.public_1.id
  vpc_security_group_ids = [aws_security_group.nat_sg.id]

  associate_public_ip_address = true
  source_dest_check           = false

  user_data = <<-EOF
    #!/bin/bash
    set -eux

    # Install iptables persistence service
    dnf install -y iptables-services

    systemctl enable iptables
    systemctl start iptables

    # Enable IPv4 packet forwarding
    sysctl -w net.ipv4.ip_forward=1
    echo "net.ipv4.ip_forward=1" > /etc/sysctl.d/99-nat.conf

    # Find the network interface
    IFACE=$(ip -o -4 route show to default | awk '{print $5}')

    # Translate private subnet addresses
    iptables -t nat -A POSTROUTING -o "$IFACE" \
      -s 10.0.2.0/24 -j MASQUERADE

    iptables -t nat -A POSTROUTING -o "$IFACE" \
      -s 10.0.4.0/24 -j MASQUERADE

    # Allow new and established outbound connections
    iptables -A FORWARD -i "$IFACE" -o "$IFACE" \
      -s 10.0.2.0/24 \
      -m conntrack --ctstate NEW,ESTABLISHED,RELATED -j ACCEPT

    iptables -A FORWARD -i "$IFACE" -o "$IFACE" \
      -s 10.0.4.0/24 \
      -m conntrack --ctstate NEW,ESTABLISHED,RELATED -j ACCEPT

    # Allow established return traffic
    iptables -A FORWARD -i "$IFACE" -o "$IFACE" \
      -d 10.0.2.0/24 \
      -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT

    iptables -A FORWARD -i "$IFACE" -o "$IFACE" \
      -d 10.0.4.0/24 \
      -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT

    # Save firewall rules
    service iptables save
  EOF

  tags = {
    Name = "${var.project_name}-nat-instance"
  }
}


resource "aws_route" "private_nat" {
  route_table_id         = aws_route_table.private.id
  destination_cidr_block = "0.0.0.0/0"

  network_interface_id = aws_instance.nat.primary_network_interface_id
}
