#--------------------------
# xebro GmbH - Traefik - 0.0.1
#--------------------------

.PHONY: certs
traefik.certs: ## create self signed ssl certificates
	@mkdir -p docker/traefik/certs/
	@grep -qFr '${LOCAL_DOMAIN}' /etc/hosts || echo "127.0.0.1 ${LOCAL_DOMAIN}" | sudo tee -a /etc/hosts
	mkcert -cert-file docker/traefik/certs/foo.crt -key-file ./docker/traefik/certs/foo.key *.${LOCAL_DOMAIN} ${LOCAL_DOMAIN}

traefik.install:
	$(call add_config,".env","docker/traefik/.env")

install: traefik.install traefik.certs

traefik.help:
	$(call add_help, ./docker/traefik/Makefile,"Traefik")

help: traefik.help