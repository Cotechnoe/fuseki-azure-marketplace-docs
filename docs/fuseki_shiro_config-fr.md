# Apache Jena Fuseki – Configuration de la sécurité avec Apache Shiro

Ce guide décrit comment configurer l’authentification et les rôles dans Apache Jena Fuseki à l’aide de la bibliothèque Apache Shiro.

## 1. Emplacement du fichier shiro.ini

Le fichier de configuration se trouve généralement dans :
```
/data/fuseki/databases/shiro.ini
```
Sur l’environnement local, les modèles sont situés dans :
```
./security/
```

## 2. Structure d’un fichier shiro.ini

Exemple de configuration utilisant un hachage SHA-256 (sans sel) :

```ini
[main]
credentialsMatcher = org.apache.shiro.authc.credential.Sha256CredentialsMatcher
iniRealm.credentialsMatcher = $credentialsMatcher

[users]
michel = 5e884898da28047151d0e56f8dc62927, admin

[roles]
admin = *

[urls]
/** = authcBasic, roles[admin]
```

## 3. Génération d’un mot de passe haché

Utilisez la cible `make shiro-generate` pour générer un hash compatible (SHA-256 hexadécimal) :
```bash
make shiro-generate
```
Cela produira un fichier `shiro-hashed.ini` prêt à être déployé.

## 4. Déploiement sécurisé

Pour transférer le fichier sur le serveur distant et redémarrer le service Fuseki :
```bash
make shiro-deploy-hashed HOST=<ip-vm>
```

## 5. Vérification de la connexion

Testez la connexion HTTP Basic avec :
```bash
make login-test HOST=<ip-vm>
```

## 6. Variantes disponibles

Plusieurs modèles sont disponibles dans le dossier `security/` :
- `shiro-open.ini` : accès libre (développement)
- `shiro-role-based.ini` : contrôle basé sur les rôles
- `shiro-localhost-only.ini` : accès restreint à `localhost`
- `shiro-basic-auth.ini` : mot de passe en clair (à éviter en production)

## 7. Bonnes pratiques

- Ne pas utiliser de mot de passe en clair en production
- Toujours restreindre les accès via les rôles (`[roles]` et `[urls]`)
- Sauvegarder toute configuration modifiée dans Git ou un dépôt sécurisé

---
Pour plus de détails :
https://github.com/Cotechnoe/fuseki-azure-marketplace

