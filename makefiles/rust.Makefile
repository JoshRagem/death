.DEFAULT_GOAL := install
SHELL := /bin/bash

install: state/rustup_version

state/rustup_version:
	su joshua -c "bash <(curl https://sh.rustup.rs -sSf) -y"
	bin/upsert_state_file "$(/home/joshua/.cargo/bin/rustc --version || date)" rustc_version state

.PHONY: upsert_version
upsert_version:
	bin/upsert_state_file "$(/home/joshua/.cargo/bin/rustc --version || date)" rustc_version state

.PHONY: clean
clean:


