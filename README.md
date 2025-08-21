# Apache Jena Fuseki – Azure Marketplace VM

## 🚀 Now Available on Azure Marketplace!

[![Azure Marketplace](./marketing/assets/promotional-images/MS_Azure_Marketplace.png)](https://azuremarketplace.microsoft.com/fr/marketplace/apps/cotechnoe.apache-jena-fuseki?ocid=GTMRewards_WhatsNewBlog_apache-jena-fuseki_05022025)

**[🛒 Deploy Now on Azure Marketplace](https://azuremarketplace.microsoft.com/fr/marketplace/apps/cotechnoe.apache-jena-fuseki?ocid=GTMRewards_WhatsNewBlog_apache-jena-fuseki_05022025)**

---

Welcome to the official repository for the **Apache Jena Fuseki Virtual Machine** image, available on the Microsoft Azure Marketplace. This repository provides deployment tools, service configurations, and guides to help you run a high-performance RDF/SPARQL server in the cloud.

---

## About This VM

- Operating System: Ubuntu Server 24.04 LTS  
- Software: Apache Jena Fuseki with TDB2 storage backend  
- Access: Web interface (port 3030) and SSH  
- Setup: Preconfigured with cloud-init for automatic provisioning

---

## Key Features

- Out-of-the-box SPARQL 1.1 endpoint  
- Load, store, and query RDF datasets  
- Persistent or in-memory dataset support  
- Role-based authentication using Apache Shiro  
- Automated deployment via Makefile scripts  
- Optimized for Azure VM SKUs (e.g., B1ms, D2s_v3, E4s_v3)

---

## Quick Start Guide

### Step 1 – Deploy from Azure Marketplace

**[🛒 Deploy directly from Azure Marketplace](https://azuremarketplace.microsoft.com/fr/marketplace/apps/cotechnoe.apache-jena-fuseki?ocid=GTMRewards_WhatsNewBlog_apache-jena-fuseki_05022025)**

### Step 2 – Access the Fuseki Server

After deployment, open your browser to:  
http://your-vm-ip:3030

### Step 3 – Post-Deployment Setup

Use the included Makefile to:
- Deploy or update systemd services
- Secure Fuseki with a hashed password
- Restart or manage the Fuseki service remotely

For full instructions, refer to:
- `docs/fuseki_service_config-en.md` – systemd configuration
- `docs/fuseki_shiro_config-en.md` – Shiro security configuration

---

## Using the Makefile

This repository includes a robust Makefile to automate service deployment and Shiro security configuration.

### Prerequisites

- SSH access to the VM (azureuser or custom user)
- make, ssh, scp, and curl installed locally

### Common Commands

```bash
# Deploy systemd service to the remote VM
make service-deploy HOST=<your-vm-ip> SERVICE_FILE=fuseki-d2s-v3.service

# Enable and start the service
make service-enable HOST=<your-vm-ip>
make service-start HOST=<your-vm-ip>

# Secure the server with hashed Shiro credentials
make shiro-generate
make shiro-deploy-hashed HOST=<your-vm-ip>

# Test HTTP login
make login-test HOST=<your-vm-ip>
```

Run `make usage` to view all available targets.

---

## Repository Structure

```bash
.
├── Makefile                      # Deployment and configuration automation
├── services/                    # systemd service templates per VM type
├── security/                    # Shiro security templates (role-based, open, hashed, etc.)
├── config-examples/             # Sample Fuseki dataset configurations
├── sample-data/                 # Example RDF data files
├── docs/                        # Additional documentation
│   ├── fuseki_service_config-en.md      # systemd setup (EN)
│   ├── fuseki_shiro_config-en.md        # Shiro setup (EN)
```

---

## Support

For help and support:
- Open a GitHub issue at: https://github.com/Cotechnoe/fuseki-azure-marketplace/issues
- Use the Azure Marketplace support form

---

## License

This image is based on [Apache Jena Fuseki](https://jena.apache.org/) and distributed under the [Apache License 2.0](https://www.apache.org/licenses/LICENSE-2.0).

(c) 2025 – Cotechnoe inc. – http://cotechnoe.com

