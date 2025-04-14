# Apache Jena Fuseki – Security Configuration with Apache Shiro

This guide explains how to configure authentication and role-based access in Apache Jena Fuseki using Apache Shiro.

## 1. Location of the `shiro.ini` file

The main configuration file is typically located at:
```
/data/fuseki/databases/shiro.ini
```
Local templates are available in:
```
./security/
```

## 2. Sample `shiro.ini` structure

Example configuration using SHA-256 password hashing (no salt):
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

## 3. Password hash generation

Use the Makefile target to generate a compatible SHA-256 hex hash:
```bash
make shiro-generate
```
This will create a `shiro-hashed.ini` file ready for deployment.

## 4. Secure deployment

Deploy the hashed configuration and restart Fuseki using:
```bash
make shiro-deploy-hashed HOST=<vm-ip>
```

## 5. Authentication test

Use the following to test HTTP Basic login:
```bash
make login-test HOST=<vm-ip>
```

## 6. Available variants

Several preconfigured templates are provided in the `security/` folder:
- `shiro-open.ini`: unrestricted access (dev only)
- `shiro-role-based.ini`: role-based access control
- `shiro-localhost-only.ini`: restricts access to localhost
- `shiro-basic-auth.ini`: plain-text password (not for production)

## 7. Best practices

- Avoid plain-text passwords in production
- Use role-based restrictions via `[roles]` and `[urls]`
- Store configuration securely in version control

---
For advanced usage and updates:
https://github.com/Cotechnoe/fuseki-azure-marketplace

