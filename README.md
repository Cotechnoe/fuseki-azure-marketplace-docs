# Apache Jena Fuseki – Azure Marketplace VM

**Documentation and support resources** for the Apache Jena Fuseki Virtual Machine image published on the Microsoft Azure Marketplace.

This project contains configuration, deployment instructions, and guides to help you get started with your RDF/SPARQL server in the cloud.

---

## About the VM

- **OS**: Ubuntu Server 24.04 LTS  
- **Software**: Apache Jena Fuseki with TDB2 backend  
- **Access**: SSH and Web UI (port 3030)  
- **Cloud-init**: Preconfigured for automatic setup

---

## Features

- SPARQL 1.1 endpoint ready to use  
- Load and query RDF datasets  
- Persistent or in-memory storage  
- Designed for quick deployment via Azure

---

## Usage Instructions

1. Deploy the VM from the [Azure Marketplace](https://azuremarketplace.microsoft.com/en-us/marketplace/apps/cotechnoe.apache-jena-fuseki?tab=Overview)  
2. Access Fuseki at: `http://<your-vm-ip>:3030`  
3. Use default admin credentials (see deployment output)  
4. Load RDF data or connect via SPARQL client

---

## Post-Deployment Configuration (Using Makefile)

This repository includes a `Makefile` that automates the configuration of the systemd service for Apache Fuseki on the deployed VM.

### 🔧 Prerequisites

- SSH access to the VM (default user: `azureuser`)
- Your public key added to the VM (done automatically by Azure)
- `make` and `scp` installed on your local machine

### 📦 Directory structure

```
.
├── services/
│   ├── fuseki-b1ms.service
│   ├── fuseki-d2s-v3.service
│   └── ... (other service templates)
├── Makefile  # The Makefile
```

### ⚙️ How to Use

```bash
# Example: deploy the systemd service for a D2s_v3 VM
make deploy HOST=<your-vm-ip> SERVICE_FILE=fuseki-d2s-v3.service

# Enable and start the Fuseki service
make enable HOST=<your-vm-ip>
make start HOST=<your-vm-ip>

# Check status
make status HOST=<your-vm-ip>
```

> ℹ️ You can list all available targets by running:  
> `make usage`

---

## Files in this Repo

- `services/` – systemd unit templates for different Azure VM types  
- `Makefile` – Makefile for automated deployment and service management  
- `LICENSE`, `NOTICE` – Legal notices for included open-source components

---

## Support

For help, open an [issue](../../issues) or contact the publisher via the Marketplace support form.

---

## License

This image includes [Apache Jena Fuseki](https://jena.apache.org/) licensed under the [Apache License 2.0](https://www.apache.org/licenses/LICENSE-2.0).
