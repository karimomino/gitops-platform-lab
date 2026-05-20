# OpenTofu vs Terraform

## Context
Hashicorp changed the license in 2023 from Mozilla Public License (MPL) 2.0 to Business Source License (BSL) v1.1, which allows free use for internal projects, but not for commercial use. Linux Foundation forked the last MPL licensed terraform, creating OpenTofu.

## Decision
Use OpenTofu for this project.

## Consequences
- Sytax is identical between Terraform and OpenTofu, meaning the skills translate seamlessly between the two.
- Terraform new providers might be delayed due to OpenTofu being a smaller ecosystem.
- Open-source values are preserved.
