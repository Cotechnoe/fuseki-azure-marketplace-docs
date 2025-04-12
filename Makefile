###################################################################
# Script Name    : Makefile
# Description    : This Makefile automates the deployment and management 
#    of the Apache Jena Fuseki systemd service on remote servers via SSH. 
#    It allows users to deploy a specified Fuseki service file, 
#    enable it to start on boot, and control its operation 
#    (start, stop, restart, status) on the target machine. 
#    The Makefile is designed to work with different Azure VM configurations 
#    by specifying the appropriate service file.
# Return         : Executes the specified target actions on the remote server, 
#    providing output and status messages for each operation.
# Arguments      : HOST         - Remote server hostname or IP address (required)
#                  SERVICE_FILE - Name of the local service file to deploy (default: fuseki-d2s-v3.service)
#                  USER         - SSH username for the remote server (default: azureuser)
#                  KEY          - SSH private key path (optional, e.g. ~/.ssh/id_rsa)
# Author         : Michel Héon PhD
# Institution    : Cotechnoe inc.
# Copyright      : Cotechnoe inc. (c) 2025
# Creation Date  : 25-04-12
# Email          : support@cotechnoe.com
###################################################################

SERVICE_FILE ?= fuseki-d2s-v3.service
USER = azureuser
KEY ?=

LOCAL_SERVICE_PATH := ./services/$(SERVICE_FILE)
REMOTE_SERVICE_NAME := fuseki.service
REMOTE_SERVICE_PATH := /etc/systemd/system/$(REMOTE_SERVICE_NAME)

SSH := ssh $(if $(KEY),-i $(KEY)) $(USER)@$(HOST)
SCP := scp $(if $(KEY),-i $(KEY))

.PHONY: usage deploy enable start stop restart status connect

usage:  # Display this help message
	@echo "Usage: make [target] HOST=<remote_host> [SERVICE_FILE=<file>] [USER=<ssh_user>] [KEY=<private_key_path>]"
	@echo ""
	@echo "Variables:"
	@echo "  HOST         Remote server hostname or IP address (required)"
	@echo "  SERVICE_FILE Name of the local service file to deploy (default: fuseki-d2s-v3.service)"
	@echo "  USER         SSH username for the remote server (default: azureuser)"
	@echo "  KEY          Path to SSH private key (optional)"
	@echo ""
	@echo "Targets:"
	@grep -E '^[a-zA-Z_-]+:.*?#' $(MAKEFILE_LIST) | \
		awk 'BEGIN {FS = ":.*?#"}; {printf "  %-10s %s\n", $$1, $$2}'

deploy:  # Deploy the service file to the remote server
	@if [ -z "$(HOST)" ]; then \
		echo "Error: HOST variable is not set."; \
		exit 1; \
	fi
	@echo "Deploying $(SERVICE_FILE) to $(USER)@$(HOST)..."
	$(SCP) $(LOCAL_SERVICE_PATH) $(USER)@$(HOST):/tmp/$(REMOTE_SERVICE_NAME)
	$(SSH) "sudo mv /tmp/$(REMOTE_SERVICE_NAME) $(REMOTE_SERVICE_PATH) && \
	        sudo chown root:root $(REMOTE_SERVICE_PATH) && \
	        sudo chmod 644 $(REMOTE_SERVICE_PATH) && \
	        sudo systemctl daemon-reload"

enable:  # Enable the Fuseki service to start on boot
	@$(SSH) "sudo systemctl enable $(REMOTE_SERVICE_NAME)"

start:  # Start the Fuseki service
	@$(SSH) "sudo systemctl start $(REMOTE_SERVICE_NAME)"

stop:  # Stop the Fuseki service
	@$(SSH) "sudo systemctl stop $(REMOTE_SERVICE_NAME)"

restart:  # Restart the Fuseki service
	@$(SSH) "sudo systemctl restart $(REMOTE_SERVICE_NAME)"

status:  # Check the status of the Fuseki service
	@$(SSH) "sudo systemctl status $(REMOTE_SERVICE_NAME)"

connect:  # Open SSH connection to the remote server
	@if [ -z "$(HOST)" ]; then \
		echo "Error: HOST variable is not set."; \
		exit 1; \
	fi
	@echo "Connecting to $(USER)@$(HOST)..."
	$(SSH)

show:  # Display the remote fuseki.service file content
	@if [ -z "$(HOST)" ]; then \
		echo "Error: HOST variable is not set."; \
		exit 1; \
	fi
	@echo "Displaying contents of $(REMOTE_SERVICE_PATH) on $(HOST)..."
	@$(SSH) "sudo cat $(REMOTE_SERVICE_PATH)"

