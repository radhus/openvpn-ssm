TAG := radhus/openvpn-ssm:latest

.PHONY: build
build:
	docker build --pull -t $(TAG) .

.PHONY: push
push: build
	docker push $(TAG)