PWD:=$(shell pwd)

# Build
TAG:=
OS_VERSION:=
APP_USER:=app

# Docker
DOCKER_HUB_REPOSITORY:=baseimage
DOCKER_NAME:=$(if $(DOCKER_HUB_ACCOUNT),$(DOCKER_HUB_ACCOUNT)/$(DOCKER_HUB_REPOSITORY),$(DOCKER_HUB_REPOSITORY))

check-required-env:
	if [ -z "${TAG}" ]; then \
		echo 'Missing required argument "TAG"'; \
		exit 1; \
	fi

	if [ -z "${OS_VERSION}" ]; then \
		echo 'Missing required argument "OS_VERSION"'; \
		exit 1; \
	fi

	if [ -z "${APP_USER}" ]; then \
		echo 'Missing required argument "APP_USER"'; \
		exit 1; \
	fi

build-web-baseimage: check-required-env
	WEB_PATH=${PWD}/web ; \
	docker image build $$WEB_PATH \
		--rm --progress=plain \
		--tag ${DOCKER_NAME}:${TAG} \
		--file $$WEB_PATH/Dockerfile \
		--build-arg OS_VERSION=${OS_VERSION} \
		--build-arg APP_USER=${APP_USER}

build:
	make build-web-baseimage TAG='web_${OS_VERSION}'

docker-login:
	docker login -u $(DOCKER_HUB_ACCOUNT) --password $(DOCKER_HUB_ACCESS_TOKEN)

docker-tag:
	if [ -z "$(DOCKER_HUB_ACCOUNT)" ]; then \
		echo 'Missing required argument "DOCKER_HUB_ACCOUNT"'; \
		exit 1; \
	fi

	make build OS_VERSION=focal
	docker push ${DOCKER_NAME} --all-tags
