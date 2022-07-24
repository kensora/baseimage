PWD:=$(shell pwd)

TAG:=
OS_VERSION:=
APP_USER:=app

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
		--tag ${TAG} \
		--file $$WEB_PATH/Dockerfile \
		--build-arg OS_VERSION=${OS_VERSION} \
		--build-arg APP_USER=${APP_USER}

build:
	make build-web-baseimage TAG='web_${OS_VERSION}'