TAG = 1.6.0
PREFIX = antob/web

all: build push

build:
	docker build -t $(PREFIX):$(TAG) .

push:
	docker push $(PREFIX):$(TAG)
