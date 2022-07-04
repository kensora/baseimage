PWD:=$(shell pwd)

OS_VERSION:=focal
APP_USER:=app
APP_EXECUTABLE_PATH:=ps
NODEJS_VERSION:=16

build-web-baseimage:
	WEB_PATH=${PWD}/web ; \
	docker image build $$WEB_PATH \
		--rm --progress=plain --no-cache \
		--tag 'web_${OS_VERSION}' \
		--file $$WEB_PATH/Dockerfile \
		--build-arg OS_VERSION=${OS_VERSION} \
		--build-arg APP_USER=${APP_USER} \
		--build-arg APP_EXECUTABLE_PATH=${APP_EXECUTABLE_PATH} \
		--build-arg NODEJS_VERSION=${NODEJS_VERSION}
