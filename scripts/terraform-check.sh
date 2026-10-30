#!/bin/bash

set -e

echo "=================================="
echo " Terraform Project Safety Check"
echo "=================================="

echo ""
echo "Step 1: Checking Terraform format..."
terraform fmt -check -recursive

echo ""
echo "Step 2: Validating Terraform configuration..."
terraform validate

echo ""
echo "Step 3: Generating Terraform plan..."
terraform plan

echo ""
echo "All checks completed successfully!"
echo "Review the plan before considering deployment."
