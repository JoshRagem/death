setup:

install: $(HOME)/.bash_path $(HOME)/.bash_prompt

$(HOME)/.bash_path:
	echo '. $$HOME/.bash_path' >> $(HOME)/.bashrc
	echo 'export PATH="/home/joshua/.cargo/bin:/home/joshua/.local/bin:$$PATH'

$(HOME)/.bash_prompt:
	echo '. $$HOME/.bash_prompt' >> $(HOME)/.bashrc
	curl -L https://github.com/JoshRagem/sexy-bash-prompt/releases/download/1.0.0/bash_prompt > $(HOME)/.bash_prompt
