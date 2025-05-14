# Makefile derived from https://web.archive.org/web/20240205205603/https://venthur.de/2021-03-31-python-makefiles.html

# Get the directory this Makefile is sitting in
ROOT_DIR := $(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))

CHECK_SCRIPTS := $(ROOT_DIR)/common/*.sh $(ROOT_DIR)/debian/*.sh $(ROOT_DIR)/ubi/*.sh

# system python interpreter. used only to create virtual environment
PY = python3
VENV = venv
BIN=$(ROOT_DIR)/$(VENV)/bin

all: bashate hadolint shellcheck yamllint

$(VENV): requirements.txt
	$(PY) -m venv $(VENV)
	$(BIN)/pip install --upgrade -r requirements.txt
	touch $(VENV)

.PHONY: bashate
bashate: $(VENV)
	$(BIN)/bashate --max-line-length 120 $(CHECK_SCRIPTS)

.PHONY: hadolint
hadolint: $(VENV)
	$(BIN)/hadolint $(ROOT_DIR)/debian/Containerfile $(ROOT_DIR)/ubi/Containerfile

.PHONY: shellcheck
shellcheck: $(VENV)
	$(BIN)/shellcheck $(CHECK_SCRIPTS)

.PHONY: yamllint
yamllint: $(VENV)
	$(BIN)/yamllint .

clean:
	rm -rf $(VENV)
	find . -type f -name *.pyc -delete
	find . -type d -name __pycache__ -delete
