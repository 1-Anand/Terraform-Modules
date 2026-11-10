# 🏗️ Enterprise Azure Terraform Modules

[![Terraform Enterprise CI & Quality Gate](https://github.com/1-Anand/Terraform-Modules/actions/workflows/terraform-ci.yml/badge.svg)](https://github.com/1-Anand/Terraform-Modules/actions/workflows/terraform-ci.yml)
[![Terraform Version](https://img.shields.io/badge/Terraform-%3E%3D1.8.0-844FBA?style=flat-square&logo=terraform)](https://www.terraform.io)
[![Azure Provider](https://img.shields.io/badge/AzureRM-%3E%3D3.100.0-0078D4?style=flat-square&logo=microsoftazure)](https://registry.terraform.io/providers/hashicorp/azurerm/latest)
[![Security Scan: Trivy](https://img.shields.io/badge/Security-Trivy%20IaC%20Passing-brightgreen?style=flat-square&logo=aquasecurity)](https://github.com/aquasecurity/trivy)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg?style=flat-square)](LICENSE)

A modular, production-ready Infrastructure as Code (IaC) repository for provisioning secure, scalable, and resilient enterprise workloads on Microsoft Azure. Designed following the **Microsoft Cloud Adoption Framework (CAF)** and **Zero-Trust Network Architecture**.

---

## 🏛️ High-Level Enterprise Architecture

```mermaid
graph TD
    subgraph Hub_VNet ["🏢 Hub Network (Connectivity & Security)"]
        FW["Azure Firewall / NVA"]
        Bastion["Azure Bastion Host"]
        DNS["Private DNS Resolver"]
    end

    subgraph Spoke_VNet ["🚀 Spoke Network (Application & Workloads)"]
        AKS["Azure Kubernetes Service (AKS)"]
        VMSS["Workload Virtual Machines"]
        ACR["Azure Container Registry (ACR)"]
        KV["Azure Key Vault (Secrets)"]
        SA["Storage Account (Blob/Data)"]
        LAW["Log Analytics Workspace"]
    end

    Hub_VNet <==>|"Bidirectional VNet Peering"| Spoke_VNet
    Bastion -.->|"Secure TLS 443"| VMSS
    AKS -.->|"Private Endpoint"| ACR
    AKS -.->|"Workload Identity"| KV
    LAW ---|"Diagnostic Logs"| AKS
    LAW ---|"Diagnostic Logs"| VMSS
```

---

## 📦 Modular Components Catalog

| Module | Purpose | Key Enterprise Capabilities |
| :--- | :--- | :--- |
| **`modules/aks_cluster`** | Managed Kubernetes Control Plane | Managed Identity, Azure CNI, Node Auto-scaling, Workload Identity |
| **`modules/virtual_network`** | Foundation Virtual Network | Multi-tier Subnets, CIDR partitioning, Network Security integration |
| **`modules/subnet`** | Subnet provisioning & delegation | Service Endpoints, Private Endpoint delegation, NSG association |
| **`modules/azurerm_bastion_host`** | Zero-Public-IP Administrative Access | Native browser-based RDP/SSH without exposing public ports |
| **`modules/key_vault`** | Secrets & Cryptographic Management | RBAC authorization, Purge Protection, Private Endpoint support |
| **`modules/container_registry`** | Enterprise Private Image Repository | Premium SKU, Geo-replication, Content Trust, Vulnerability Scanning |
| **`modules/storage_account`** | Resilient Object & File Storage | TLS 1.3 enforced, Blob versioning, Private Endpoints, Customer-Managed Keys |
| **`modules/network_security_group`**| Stateful Layer 4 Traffic Filtering | Least-privilege inbound/outbound rules, diagnostic logging |
| **`modules/virtual_machine`** | Hardened Linux & Windows Compute | Cloud-init scripting, Managed Disks with SSE, Custom Script Extensions |
| **`modules/log_analytics_workspace`**| Centralized Observability & SIEM | Azure Monitor integration, Microsoft Sentinel ready, retention tiers |
| **`modules/nic` & `modules/pip`** | Network Interface & Public IPs | Static IP reservation, accelerated networking, IP configuration |

---

## 🚀 Quick Start Example: Consuming Modules

```hcl
module "hub_vnet" {
  source              = "./modules/virtual_network"
  resource_group_name = "rg-hub-enterprise-dev"
  location            = "eastus2"
  vnet_name           = "vnet-hub-prod-001"
  address_space       = ["10.100.0.0/16"]
}

module "aks_workload" {
  source              = "./modules/aks_cluster"
  resource_group_name = "rg-spoke-enterprise-dev"
  location            = "eastus2"
  cluster_name        = "aks-enterprise-workload-01"
  dns_prefix          = "aksworkload01"
  subnet_id           = module.hub_vnet.subnet_ids["aks-subnet"]
}
```

---

## 🔒 Security & Compliance Architecture

- **Zero-Trust Network Isolation**: All internal communication routes through private virtual networks and Azure Private Links.
- **Credential-less Authentication**: Uses **Azure Workload Identity Federation** and Managed Identities to eliminate hardcoded service principal secrets.
- **State File Protection**: Terraform state is encrypted at rest with AES-256 and locked via Azure Blob Storage lease management with Entra ID RBAC.
- **Automated IaC Security Gate**: Every pull request is verified with automated syntax, formatting, and Trivy static vulnerability scanning.

---

## 🤝 Collaboration & Quality Standards

- Managed and maintained by **[Anand Bhushan](https://github.com/1-Anand)** (Azure DevOps & Cloud Platform Engineer).
- Continuous peer code review and collaborative trunk-based development with automated GitHub Actions CI.
