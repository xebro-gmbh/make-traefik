#--------------------------
# xebro GmbH - Traefik - 0.0.2
#--------------------------

.PHONY: certs
traefik.certs: ## create self signed ssl certificates
	@mkdir -p docker/traefik/certs/
	@grep -qFr '${XEBRO_LOCAL_DOMAIN}' /etc/hosts || echo "127.0.0.1 ${XEBRO_LOCAL_DOMAIN}" | sudo tee -a /etc/hosts
	mkcert -cert-file docker/traefik/certs/foo.crt -key-file ./docker/traefik/certs/foo.key *.${XEBRO_LOCAL_DOMAIN} ${XEBRO_LOCAL_DOMAIN}

traefik.install:
	$(call headline,"Installing traefik")
	$(call add_config,".env","docker/traefik/.env")

install: traefik.install traefik.certs

traefik.help:
	$(call add_help, ./docker/traefik/Makefile,"Traefik")

help: traefik.help
