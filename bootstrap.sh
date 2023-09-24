#!/bin/bash
wget -O- https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list

sudo apt update
sudo apt install -y  net-tools curl software-properties-common apt-transport-https ca-certificates gnupg2 jq unzip zip terraform packer

curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install

sudo apt install bash-completion -y
sudo echo "source /etc/profile.d/bash_completion.sh" >> ~/.bashrc

terraform -install-autocomplete
packer -autocomplete-install

sudo rm -r 'sudo apt update && sudo apt install packer' 

cat <<'EOF1'   | sudo tee /home/ubuntu/.aws/config
[default]
output = json
region = us-east-2
EOF1

cat <<'EOF2'  | sudo tee /home/ubuntu/.aws/credentials
[default]
aws_access_key_id = ${{ secrets.AWS_ACCESS_KEY_ID}}
aws_secret_access_key = ${{ secrets.AWS_SECRET_ACCESS_KEY}}
EOF2