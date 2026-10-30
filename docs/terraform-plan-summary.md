# Terraform Plan Summary

## Project Information

| Item | Details |
|---|---|
| Project | AWS VPC Infrastructure Using Terraform |
| Cloud Provider | Amazon Web Services (AWS) |
| Region | ap-southeast-2 (Sydney) |
| Infrastructure as Code | Terraform |
| Deployment Status | Not Deployed |

## Planned Infrastructure

The latest successful Terraform execution plan proposed:

| Resource Action | Count |
|---|---:|
| Resources to Add | 26 |
| Resources to Change | 0 |
| Resources to Destroy | 0 |

## Infrastructure Components

- 1 AWS VPC
- 2 Public Subnets
- 2 Private Subnets
- 1 Internet Gateway
- 2 Route Tables
- 4 Route Table Associations
- 1 Web Security Group
- 2 Network ACLs
- Network ACL Rules
- 1 S3 Gateway VPC Endpoint

## Validation Results

- Terraform formatting check: Passed
- Terraform configuration validation: Passed
- Terraform execution plan: Passed

## Cost Considerations

- No NAT Gateway is included.
- No EC2 instances or Load Balancers are included.
- S3 Gateway Endpoint has no additional endpoint hourly or data-processing charge.
- Normal S3 usage may incur separate charges.
- AWS Free account restrictions and permissions must be checked before deployment.

## Deployment Status

**Infrastructure Status: Not Deployed**

The Terraform plan is only a preview of proposed infrastructure changes.

No `terraform apply` command has been executed.

Deployment requires a separate review of permissions, security and potential costs.

---

**Project:** AWS VPC Infrastructure Using Terraform

**Region:** Sydney (`ap-southeast-2`)
