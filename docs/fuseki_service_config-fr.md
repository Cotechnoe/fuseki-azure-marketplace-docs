# Apache Jena Fuseki – Configuration du service systemd

Ce guide décrit comment configurer et gérer le service `systemd` pour Apache Jena Fuseki sur une machine virtuelle Azure déployée à partir de l’image officielle disponible sur Azure Marketplace.

## 1. Emplacement des fichiers de service

Les fichiers `systemd` se trouvent dans :
```
./services/
```
Chaque fichier correspond à un type de machine virtuelle Azure (ex. : `fuseki-d2s-v3.service`).

## 2. Déploiement du service

Utilisez le `Makefile` pour transférer et activer le service :
```bash
make service-deploy HOST=<ip-vm> SERVICE_FILE=fuseki-d2s-v3.service
make service-enable HOST=<ip-vm>
make service-start HOST=<ip-vm>
```

## 3. Exemple de fichier systemd

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

## 4. Journalisation et débogage

Consulter les journaux en temps réel :
```bash
journalctl -u fuseki -f
```

Vérifier l’état du service :
```bash
make service-status HOST=<ip-vm>
```

## 5. Redémarrer ou arrêter le service
```bash
make service-restart HOST=<ip-vm>
make service-stop HOST=<ip-vm>
```

## 6. Personnalisation

Vous pouvez modifier :
- La mémoire JVM (`-Xmx4g`)
- Le fichier de configuration du jeu de données (`--config=...`)
- L’utilisateur système (`User=fuseki`)

Assurez-vous que les chemins et permissions correspondent à votre environnement.

---
Pour des configurations plus avancées, voir le dépôt GitHub :
https://github.com/Cotechnoe/fuseki-azure-marketplace

