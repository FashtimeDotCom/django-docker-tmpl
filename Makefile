PY?=python
PIP?=pip

debug:
	docker-compose run --service-ports web /bin/bash

test:
	PYTHONPATH=. pytest --cov ./ --cov-report term-missing:skip-covered --capture=no tests

server:
	$(PY) manage.py runserver 0.0.0.0:8000


build:
	docker-compose build

clean:
	docker-compose down


.PHONY: debug test server
.PHONY: build clean
