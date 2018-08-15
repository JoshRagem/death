.DEFAULT_GOAL := install

install: state/vim_version upsert_version
	apt install -y vim

.PHONY: upsert_version
upsert_version:
	bin/upsert_state_file "$(vim --version || date)" vim_version state

.PHONY: clean
clean:


