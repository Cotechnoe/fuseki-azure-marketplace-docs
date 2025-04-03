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

1. Deploy the VM from the [Azure Marketplace](#)  
2. Access Fuseki at: `http://<your-vm-ip>:3030`  
3. Use default admin credentials (see deployment output)  
4. Load RDF data or connect via SPARQL client

---

## Files in this Repo

- `LICENSE`, `NOTICE` – Legal notices for included open-source components

---

## Support

For help, open an [issue](../../issues) or contact the publisher via the Marketplace support form.

---

## License

This image includes [Apache Jena Fuseki](https://jena.apache.org/) licensed under the [Apache License 2.0](https://www.apache.org/licenses/LICENSE-2.0).
