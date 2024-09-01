#!/bin/bash

#Update and upgrade the system
sudo apt update && sudo apt upgrade -y

# Install common software
sudo apt install -y git curl wget

# Install the ability to create venv 
echo "Installing the latest Python 3 and venv module..."
sudo apt install -y python3 python3-pip python3-venv

# Install Visual Studio Code
sudo apt install -y software-properties-common apt-transport-https wget
wget -q https://packages.microsoft.com/keys/microsoft.asc -O- | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main"
sudo apt update
sudo apt install -y code

# List of VSCode extensions to install
extensions=(
  ms-python.python
  esbenp.prettier-vscode
  GitHub.copilot
  ms-vscode.cmake-tools
  ecmel.vscode-html-css
  ms-toolsai.jupyter
  James-Yu.latex-workshop
)

echo "Starting VSCode extensions installation..."

for extension in "${extensions[@]}"; do
  echo "Installing $extension..."
  code --install-extension "$extension"
done

echo "All VSCode extensions have been installed successfully!"

# Install Blender
sudo apt install -y blender

# Install dbeaver (for SQL management)
wget -q https://dbeaver.io/files/dbeaver-ce_latest_amd64.deb
sudo dpkg -i dbeaver-ce_latest_amd64.deb
sudo apt-get install -f -y
rm dbeaver-ce_latest_amd64.deb

# Install filezilla
echo "Installing FileZilla..."
sudo apt install -y filezilla

# Install VLC
echo "Installing VLC..."
sudo apt install -y vlc

# Install Unity Hub
echo "Installing Unity Hub..."

# Add the public signing key
wget -qO - https://hub.unity3d.com/linux/keys/public | gpg --dearmor | sudo tee /usr/share/keyrings/Unity_Technologies_ApS.gpg > /dev/null

# Add the Unity Hub repository
sudo sh -c 'echo "deb [signed-by=/usr/share/keyrings/Unity_Technologies_ApS.gpg] https://hub.unity3d.com/linux/repos/deb stable main" > /etc/apt/sources.list.d/unityhub.list'

# Update the package cache and install Unity Hub
sudo apt update
sudo apt-get install -y unityhub



# Clean up step
echo "Cleaning up downloaded .deb files..."
rm -f dbeaver-ce_latest_amd64.deb

echo "Clearing the APT cache..."
sudo apt-get clean

echo "Removing temporary files..."
rm -rf /tmp/some-temporary-file-or-directory