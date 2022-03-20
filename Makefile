.PHONY: venv
venv:
	echo 'layout python3' > .envrc && \
		direnv allow

.PHONY: init
init:
	pip install -U pip pip-tools

.PHONY: reqs
reqs:
	pip-compile
	pip install -r requirements.txt
	cp ~/_sys/tikzmagic.py .direnv/python-3.10.2/lib/python3.10/site-packages
.PHONY: nb
nb:
	cd  book && \
		jupyter notebook

.PHONY: book
book:
	jb build book/
	cp -R book/_build/html/* docs/

.PHONY: test
test:
	pytest tests
	flake8 mmdesigner

.PHONY: server
server:
	gunicorn --bind 0.0.0.0:5000 wsgi:app

.PHONY: jbtest
jbtest:
	pytest --nbmake book
