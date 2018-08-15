SHELL := bash

setup: /usr/bin/curl

/usr/bin/curl:
	apt install -y curl

install: $(HOME)/.cargo/bin/rustc /etc/bash_completion.d/rustup.bash-completion

/etc/bash_completion.d/rustup.bash-completion: $(HOME)/.cargo/bin/rustup /etc/bash_completion.d
	$(HOME)/.cargo/bin/rustup completions bash > /etc/bash_completion.d/rustup.bash-completion

/etc/bash_completion.d:
	mkdir -p /etc/bash_completion.d

$(HOME)/.cargo/bin/rustc: $(HOME)/.cargo/bin/rustup
	$(HOME)/.cargo/bin/rustup install nightly

$(HOME)/.cargo/bin/rustup:
	bash <(curl https://sh.rustup.rs -sSf) -y

