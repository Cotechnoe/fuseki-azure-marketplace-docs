# Apache Jena Fuseki - systemd Service Configuration

This guide describes how to configure and manage the `systemd` service for Apache Jena Fuseki on an Azure virtual machine deployed from the official Marketplace image.

## 1. Location of service files

Systemd service unit files are stored in:
```
./services/
```
Each file is specific to an Azure VM size (e.g., `fuseki-d2s-v3.service`).

## 2. Deploying the service

Use the `Makefile` to deploy and start the service:
```bash
make service-deploy HOST=<vm-ip> SERVICE_FILE=fuseki-d2s-v3.service
make service-enable HOST=<vm-ip>
make service-start HOST=<vm-ip>
```

## 3. Example systemd file

```ini
[Unit]
Description=Apache Fuseki Server - D2s Standard v3
After=network.target

[Service]
Type=simple
User=fuseki
WorkingDirectory=/opt/fuseki
ExecStart=/usr/bin/java -Xmx4g -jar /opt/fuseki/fuseki-server.jar --config=/opt/fuseki/configuration/config.ttl
Restart=on-failure

[Install]
WantedBy=multi-user.target
```

## 4. Logging and debugging

Check logs in real time:
```bash
journalctl -u fuseki -f
```

Check service status:
```bash
make service-status HOST=<vm-ip>
```

## 5. Restarting or stopping the service
```bash
make service-restart HOST=<vm-ip>
make service-stop HOST=<vm-ip>
```

## 6. Customization options

You can modify:
- JVM memory allocation (`-Xmx4g`)
- Dataset configuration file (`--config=...`)
- Runtime user (`User=fuseki`)

Make sure paths and permissions match your deployment setup.

---
For advanced configurations, visit the GitHub repository:
https://github.com/Cotechnoe/fuseki-azure-marketplace

