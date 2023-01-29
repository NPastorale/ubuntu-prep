#!/bin/env bash

if [ "$(id -u)" -ne 0 ]; then
        echo 'This script must be run by root' >&2
        exit 1
fi

cat << EOF > /etc/sudoers.d/nahue
nahue ALL=(ALL) NOPASSWD:ALL
EOF

sudo apt update
sudo apt install -y curl git

curl -L "https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb" --output chrome.deb

curl -L "https://code.visualstudio.com/sha/download?build=stable&os=linux-deb-x64" --output vscode.deb

sudo curl -o /usr/share/keyrings/syncthing-archive-keyring.gpg https://syncthing.net/release-key.gpg
echo "deb [signed-by=/usr/share/keyrings/syncthing-archive-keyring.gpg] https://apt.syncthing.net/ syncthing stable" | sudo tee /etc/apt/sources.list.d/syncthing.list

sudo add-apt-repository -y ppa:phoerious/keepassxc

sudo apt update
sudo apt install -y ./chrome.deb ./vscode.deb syncthing

rm ./chrome.deb ./vscode.deb

