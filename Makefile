PY?=python
PIP?=pip

debug:
	docker-compose run --service-ports web /bin/bash

test:
	pytest --cov ./ --cov-report term-missing:skip-covered --capture=no -p no:cacheprovider

server:
	$(PY) manage.py runserver 0.0.0.0:8000


build:
	docker-compose build

clean:
	docker-compose down

# Services

kibana:
	docker-compose run --service-ports kibana


.PHONY: debug test server
.PHONY: build clean
.PHONY: kibana kafka-manager
