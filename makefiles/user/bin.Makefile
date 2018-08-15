export PATH := $(HOME)/.cargo/bin:$(PATH)

setup:
	apt install -y gzip

install: $(HOME)/bin/bu $(HOME)/bin/terraform $(HOME)/bin/argo $(HOME)/.fzf/bin/fzf

$(HOME)/.fzf/bin/fzf:
	git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
	~/.fzf/install --all

$(HOME)/bin/alacritty:
	cd $(HOME)/workspace && git clone https://github.com/jwilm/alacritty.git
	cd $(HOME)/workspace/alacritty && cargo build --release
	cp target/release/alacritty $(HOME)/bin/

$(HOME)/bin/argo:
	curl -sSL https://github.com/argoproj/argo/releases/download/v2.1.1/argo-linux-amd64 > $(HOME)/bin/argo
	chmod +x $(HOME)/bin/argo

$(HOME)/bin/terraform:
	curl -L https://releases.hashicorp.com/terraform/0.11.7/terraform_0.11.7_linux_amd64.zip | gunzip > $(HOME)/bin/terraform
	chmod +x $(HOME)/bin/terraform

$(HOME)/bin/bu:
	git clone https://github.com/joshragem/bin.git $(HOME)/bin

