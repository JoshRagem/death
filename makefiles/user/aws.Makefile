setup:

install: /usr/local/bin/aws-vault /usr/bin/aws

/usr/bin/aws:
	apt install python3 python3-pip
	pip3 install awscli --upgrade --user

/usr/local/bin/aws-vault:
	curl -L https://github.com/99designs/aws-vault/releases/download/v4.2.1/aws-vault-linux-amd64 > /usr/local/bin/aws-vault
	chmod +x /usr/local/bin/aws-vault

