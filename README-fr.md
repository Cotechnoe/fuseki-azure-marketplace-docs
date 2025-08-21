
# Apache---

Bienvenue dans le dépôt officiel de l'image **Apache Jena Fuseki Virtual Machine** publiée sur Microsoft Azure Marketplace. Ce dépôt fournit des outils de déploiement, des configurations de services et des guides pour exécuter un serveur RDF/SPARQL performant dans le cloud.

---useki – Image VM Azure Marketplace (Français)

## 🚀 Maintenant disponible sur Azure Marketplace !

[![Azure Marketplace](./marketing/assets/promotional-images/MS_Azure_Marketplace.png)](https://azuremarketplace.microsoft.com/fr/marketplace/apps/cotechnoe.apache-jena-fuseki?ocid=GTMRewards_WhatsNewBlog_apache-jena-fuseki_05022025)

**[🛒 Déployer maintenant sur Azure Marketplace](https://azuremarketplace.microsoft.com/fr/marketplace/apps/cotechnoe.apache-jena-fuseki?ocid=GTMRewards_WhatsNewBlog_apache-jena-fuseki_05022025)**

---

Bienvenue dans le dépôt officiel de l'image **Apache Jena Fuseki Virtual Machine** publiée sur Microsoft Azure Marketplace. Ce dépôt fournit des outils de déploiement, des configurations de services et des guides pour exécuter un serveur RDF/SPARQL performant dans le cloud.pache Jena Fuseki – Image VM Azure Marketplace (Français)

Bienvenue dans le dépôt officiel de l’image **Apache Jena Fuseki Virtual Machine** publiée sur Microsoft Azure Marketplace. Ce dépôt fournit des outils de déploiement, des configurations de services et des guides pour exécuter un serveur RDF/SPARQL performant dans le cloud.

---

## À propos de cette VM

- Système d’exploitation : Ubuntu Server 24.04 LTS  
- Logiciel : Apache Jena Fuseki avec backend de stockage TDB2  
- Accès : Interface Web (port 3030) et SSH  
- Configuration : Automatique via cloud-init

---

## Fonctionnalités clés

- Serveur SPARQL 1.1 prêt à l’emploi  
- Chargement, stockage et interrogation de jeux de données RDF  
- Support des jeux de données persistants ou en mémoire  
- Authentification par rôles avec Apache Shiro  
- Déploiement automatisé via des scripts Makefile  
- Optimisée pour les tailles de VM Azure (ex. : B1ms, D2s_v3, E4s_v3)

---

## Guide de démarrage rapide

### Étape 1 – Déploiement depuis Azure Marketplace

**[🛒 Déployer directement depuis Azure Marketplace](https://azuremarketplace.microsoft.com/fr/marketplace/apps/cotechnoe.apache-jena-fuseki?ocid=GTMRewards_WhatsNewBlog_apache-jena-fuseki_05022025)**

### Étape 2 – Accéder au serveur Fuseki

Après le déploiement, ouvrez un navigateur à l’adresse suivante :  
http://adresse-ip-de-votre-vm:3030

### Étape 3 – Configuration post-déploiement

Utilisez le Makefile inclus pour :
- Déployer ou mettre à jour le service systemd
- Sécuriser Fuseki avec un mot de passe haché
- Redémarrer ou gérer le service Fuseki à distance

Pour les instructions complètes, consulter :
- `docs/fuseki_service_config-fr.md` – configuration systemd
- `docs/fuseki_shiro_config-fr.md` – configuration de la sécurité Shiro

---

## Utilisation du Makefile

Ce dépôt comprend un Makefile robuste pour automatiser le déploiement et la configuration de la sécurité.

### Prérequis

- Accès SSH à la VM (`azureuser` ou utilisateur personnalisé)
- Outils requis localement : `make`, `ssh`, `scp`, `curl`

### Commandes courantes

```bash
# Déploiement du service systemd
make service-deploy HOST=<ip-vm> SERVICE_FILE=fuseki-d2s-v3.service

# Activer et démarrer le service
make service-enable HOST=<ip-vm>
make service-start HOST=<ip-vm>

# Générer un fichier shiro.ini avec mot de passe haché
make shiro-generate
make shiro-deploy-hashed HOST=<ip-vm>

# Tester l’authentification HTTP
make login-test HOST=<ip-vm>
```

Lancer `make usage` pour afficher toutes les cibles disponibles.

---

## Structure du dépôt

```bash
.
├── Makefile                      # Automatisation du déploiement et configuration
├── services/                    # Modèles systemd pour chaque type de VM
├── security/                    # Modèles de configuration Shiro (ouverts, par rôles, hachés...)
├── config-examples/             # Exemples de configuration de jeux de données Fuseki
├── sample-data/                 # Jeux de données RDF d'exemple
├── docs/                        # Documentation supplémentaire
│   ├── fuseki_service_config-fr.md      # Configuration systemd (FR)
│   ├── fuseki_shiro_config-fr.md        # Sécurité Shiro (FR)
```

---

## Support

Pour toute demande d’assistance :
- Ouvrez un ticket GitHub : https://github.com/Cotechnoe/fuseki-azure-marketplace/issues
- Ou utilisez le formulaire de support sur Azure Marketplace

---

## Licence

Cette image intègre [Apache Jena Fuseki](https://jena.apache.org/) distribué sous la [Licence Apache 2.0](https://www.apache.org/licenses/LICENSE-2.0).

(c) 2025 – Cotechnoe inc. – http://cotechnoe.com

