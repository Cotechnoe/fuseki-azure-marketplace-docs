# Privacy Policy – Apache Jena Fuseki VM on Azure Marketplace

This virtual machine image is published by **Cotechnoe inc.** and includes the open-source Apache Jena Fuseki server pre-installed and preconfigured. This policy explains how user data is handled and outlines responsibilities regarding privacy and data protection when using this image.

---

## 1. Data Collection and Processing

This VM image does **not collect**, **store**, or **transmit** any personal data or usage analytics. It does not include any background processes, agents, or telemetry systems designed to communicate data externally.

The Apache Jena Fuseki server itself does not contain tracking or data reporting components.

---

## 2. User Responsibility

When deploying this VM from the Azure Marketplace, **you (the user)** are fully responsible for:

- **Managing all data** stored and processed within the Fuseki server, including RDF datasets, SPARQL queries, and user-uploaded content.
- **Configuring access control**, firewall rules, and network security settings on your Azure subscription.
- **Ensuring data confidentiality and compliance** with relevant data protection regulations (e.g., GDPR, HIPAA, PIPEDA).

---

## 3. Security and Updates

This image is delivered with the base system (Ubuntu 24.04 LTS) and Fuseki installed. However:

- You are responsible for **keeping the operating system and Fuseki server up to date**, including applying security patches after deployment.
- We recommend using **SSH key-based access** and disabling password-based login for improved security.
- Sensitive data stored in RDF datasets should be protected using secure access policies and encryption if required.

---

## 4. Use of Open Source Components

This VM includes the following open-source software:

- **Apache Jena Fuseki** — [Apache License 2.0](https://www.apache.org/licenses/LICENSE-2.0)
- **Ubuntu Server** — [Canonical’s Terms](https://ubuntu.com/legal/terms-and-policies)

These components are included "as-is", and you are expected to review and comply with their respective licenses.

---

## 5. Scope of Publisher Responsibility

Cotechnoe inc. provides:
- The packaged virtual machine image
- Documentation and setup scripts
- Community-level support via GitHub

Cotechnoe inc. does **not**:
- Collect or access your deployed instances
- Provide managed hosting or maintenance
- Accept liability for data loss, unauthorized access, or misconfiguration on your end

---

## 6. Compliance

You are responsible for ensuring that your use of this image complies with applicable regulations such as:

- **GDPR** (General Data Protection Regulation – EU)
- **PIPEDA** (Canada)
- **HIPAA** (Health Insurance Portability and Accountability Act – US), if applicable

We do not offer legal advice or guarantee regulatory compliance.

---


_Last updated: April 3, 2025_
