###################################################################
# Script Name    : Makefile
# Description    : Automates the deployment and management of the
#                  Apache Jena Fuseki systemd service and its
#                  shiro.ini security configuration on remote servers via SSH.
#                  Includes password hashing assistant for Shiro 2.x.
# Return         : Executes specified target actions on the remote server,
#                  providing output and status messages for each operation.
# Arguments      : HOST         - Remote server hostname or IP address (required)
#                  SERVICE_FILE - Local service file to deploy (default: fuseki-d2s-v3.service)
#                  SHIRO_FILE   - Local shiro.ini file to deploy (default: shiro.ini)
#                  REMOTE_USER  - SSH REMOTE_USERname for the remote server (default: azureREMOTE_USER)
#                  KEY          - SSH private key path (optional, e.g., ~/.ssh/id_rsa)
# Author         : Michel Héon PhD
# Institution    : Cotechnoe inc.
# Copyright      : Cotechnoe inc. (c) 2025
# Creation Date  : 2025-04-12
# Email          : support@cotechnoe.com
###################################################################
SHELL          := /usr/bin/env bash
PWD            := $(shell pwd)
SERVICE_FILE ?= fuseki-d2s-v3.service
SHIRO_FILE ?= shiro.ini
REMOTE_USER = azureuser
KEY ?=

LOCAL_SERVICE_PATH := ./services/$(SERVICE_FILE)
REMOTE_SERVICE_NAME := fuseki.service
REMOTE_SERVICE_PATH := /etc/systemd/system/$(REMOTE_SERVICE_NAME)

LOCAL_SHIRO_PATH := ./security/$(SHIRO_FILE)
REMOTE_SHIRO_PATH := /data/fuseki/databases/shiro.ini

SSH := ssh $(if $(KEY),-i $(KEY)) $(REMOTE_USER)@$(HOST)
SCP := scp $(if $(KEY),-i $(KEY))

.PHONY: usage service-deploy service-enable service-start service-stop service-restart service-status service-connect service-show shiro-deploy shiro-show shiro-remove shiro-hash shiro-generate

usage:  # Display this help message
	@echo "Usage: make [target] HOST=<remote_host> [SERVICE_FILE=<file>] [SHIRO_FILE=<file>] [REMOTE_USER=<ssh_REMOTE_USER>] [KEY=<private_key_path>]"
	@echo ""
	@echo "Variables:"
	@echo "  HOST         Remote server hostname or IP address (required)"
	@echo "  SERVICE_FILE Local service file to deploy (default: fuseki-d2s-v3.service)"
	@echo "  SHIRO_FILE   Local shiro.ini file to deploy (default: shiro.ini)"
	@echo "  REMOTE_USER         SSH REMOTE_USERname for the remote server (default: azureREMOTE_USER)"
	@echo "  KEY          Path to SSH private key (optional)"
	@echo ""
	@echo "Targets:"
	@grep -E '^[a-zA-Z0-9_-]+:.*?#' $(MAKEFILE_LIST) | \
		awk 'BEGIN {FS = ":.*?#"}; {printf "  %-20s %s\n", $$1, $$2}'

service-deploy:  # Deploy the Fuseki service file to the remote server
	@if [ -z "$(HOST)" ]; then \
		echo "Error: HOST variable is not set."; \
		exit 1; \
	fi
	@echo "Deploying $(SERVICE_FILE) to $(REMOTE_USER)@$(HOST)..."
	$(SCP) $(LOCAL_SERVICE_PATH) $(REMOTE_USER)@$(HOST):/tmp/$(REMOTE_SERVICE_NAME)
	$(SSH) "sudo mv /tmp/$(REMOTE_SERVICE_NAME) $(REMOTE_SERVICE_PATH) && \
	        sudo chown root:root $(REMOTE_SERVICE_PATH) && \
	        sudo chmod 644 $(REMOTE_SERVICE_PATH) && \
	        sudo systemctl daemon-reload"

service-enable:  # Enable the Fuseki service to start on boot
	@$(SSH) "sudo systemctl enable $(REMOTE_SERVICE_NAME)"

service-start:  # Start the Fuseki service
	@$(SSH) "sudo systemctl start $(REMOTE_SERVICE_NAME)"

service-stop:  # Stop the Fuseki service
	@$(SSH) "sudo systemctl stop $(REMOTE_SERVICE_NAME)"

service-restart:  # Restart the Fuseki service
	@$(SSH) "sudo systemctl restart $(REMOTE_SERVICE_NAME)"

service-status:  # Check the status of the Fuseki service
	@$(SSH) "sudo systemctl status $(REMOTE_SERVICE_NAME)"

service-show:  # Display the remote fuseki.service file content
	@if [ -z "$(HOST)" ]; then \
		echo "Error: HOST variable is not set."; \
		exit 1; \
	fi
	@echo "Displaying contents of $(REMOTE_SERVICE_PATH) on $(HOST)..."
	@$(SSH) "sudo cat $(REMOTE_SERVICE_PATH)"

shiro-deploy:  # Deploy the shiro.ini file to the remote server
	@if [ -z "$(HOST)" ]; then \
		echo "Error: HOST variable is not set."; \
		exit 1; \
	fi
	@echo "Deploying $(SHIRO_FILE) to $(REMOTE_USER)@$(HOST)..."
	$(SCP) $(LOCAL_SHIRO_PATH) $(REMOTE_USER)@$(HOST):/tmp/shiro.ini
	$(SSH) "sudo mv /tmp/shiro.ini $(REMOTE_SHIRO_PATH) && \
	        sudo chown root:root $(REMOTE_SHIRO_PATH) && \
	        sudo chmod 644 $(REMOTE_SHIRO_PATH)"

shiro-show:  # Display the remote shiro.ini file content
	@if [ -z "$(HOST)" ]; then \
		echo "Error: HOST variable is not set."; \
		exit 1; \
	fi
	@echo "Displaying contents of $(REMOTE_SHIRO_PATH) on $(HOST)..."
	@$(SSH) "sudo cat $(REMOTE_SHIRO_PATH)"

shiro-remove:  # Remove the remote shiro.ini file
	@if [ -z "$(HOST)" ]; then \
		echo "Error: HOST variable is not set."; \
		exit 1; \
	fi
	@echo "Removing $(REMOTE_SHIRO_PATH) on $(HOST)..."
	@$(SSH)

shiro-hash:  # Launch the Shiro password hashing assistant
	@echo "Downloading shiro-tools-hasher if not already present..."
	@mvn dependency:get -DgroupId=org.apache.shiro.tools \
		-DartifactId=shiro-tools-hasher \
		-Dclassifier=cli \
		-Dversion=2.0.3
	@echo "Launching Shiro password hashing assistant..."
	@java -jar ~/.m2/repository/org/apache/shiro/tools/shiro-tools-hasher/2.0.3/shiro-tools-hasher-2.0.3-cli.jar -p

.PHONY: shiro-generate

shiro-hash-bash:  # Génère un mot de passe haché SHA-512 avec OpenSSL
	@read -s -p "Entrez le mot de passe : " password; echo; \
	read -s -p "Confirmez le mot de passe : " password_confirm; echo; \
	if [ "$$password" != "$$password_confirm" ]; then \
		echo "Les mots de passe ne correspondent pas."; exit 1; \
	fi; \
	hash=$$(echo -n "$$password" | openssl passwd -6 -stdin); \
	echo "Mot de passe haché (SHA-512) :"; \
	echo "$$hash"

shiro-generate:  # Generate a shiro-hashed.ini file using SHA-256 and hexadecimal encoding (Sha256CredentialsMatcher)
	@read -p "Enter username: " username; \
	read -s -p "Enter password: " password; echo; \
	read -s -p "Confirm password: " confirm; echo; \
	if [ "$$password" != "$$confirm" ]; then \
		echo "❌ Passwords do not match."; exit 1; \
	fi; \
	hash=$$(python3 -c "import hashlib; \
	print(hashlib.sha256(b'$$password').hexdigest())"); \
	awk -v user="$$username" -v hash="$$hash" '\
		{gsub(/__USERNAME__/, user); gsub(/__HASH__/, hash); print}' \
		./security/shiro-hashed-template.ini > ./security/shiro-hashed.ini; \
	echo "./security/shiro-hashed.ini generated with SHA-256 (hex) for user '$$username'"


shiro-deploy-hashed:  # Deploy the shiro-hashed.ini file to the remote Fuseki server and restart the service
	@if [ -z "$(HOST)" ]; then \
		echo "Error: HOST variable is not set."; \
		exit 1; \
	fi
	@echo "Deploying shiro-hashed.ini to $(REMOTE_USER)@$(HOST)..."
	$(SCP) ./security/shiro-hashed.ini $(REMOTE_USER)@$(HOST):/tmp/shiro.ini
	$(SSH) "sudo systemctl stop fuseki && \
	        sudo mv /tmp/shiro.ini /data/fuseki/databases/shiro.ini && \
	        sudo chown root:root /data/fuseki/databases/shiro.ini && \
	        sudo chmod 644 /data/fuseki/databases/shiro.ini && \
	        sudo systemctl start fuseki"
	        
login-test:  # Test HTTP Basic login to Fuseki using curl
	@if [ -z "$(HOST)" ]; then \
		echo "Error: HOST variable is not set."; \
		exit 1; \
	fi; \
	read -p "Enter username: " user; \
	read -s -p "Enter password: " pass; echo; \
	echo "Testing authentication to http://$(HOST):3030..."; \
	status=$$(curl -s -o /dev/null -w "%{http_code}" -u "$$user:$$pass" http://$(HOST):3030/); \
	if [ "$$status" = "200" ]; then \
		echo "✅ Login successful (HTTP $$status)"; \
	else \
		echo "❌ Login failed (HTTP $$status)"; \
	fi

ssh-connect:  # Open SSH connection to the remote server
	@if [ -z "$(HOST)" ]; then \
		echo "Error: HOST variable is not set."; \
		exit 1; \
	fi
	@echo "Connecting to $(REMOTE_USER)@$(HOST)..."
	$(SSH)

browser-open:  # Open http://<HOST>:3030 in the default browser (Linux, macOS, WSL1, Windows)
	@if [ -z "$(HOST)" ]; then \
		echo "❌ Error: HOST variable is not set."; \
		exit 1; \
	fi; \
	url="http://$(HOST):3030"; \
	echo "Opening $$url..."; \
	if command -v xdg-open >/dev/null; then \
		xdg-open "$$url"; \
	elif command -v open >/dev/null; then \
		open "$$url"; \
	elif grep -qEi "(Microsoft|WSL)" /proc/version && [ -e /mnt/c/Windows/System32/cmd.exe ]; then \
		/mnt/c/Windows/System32/cmd.exe /C "start $$url"; \
	elif command -v start >/dev/null; then \
		start "$$url"; \
	else \
		echo "No known method to open browser. Please open manually: $$url"; \
	fi



