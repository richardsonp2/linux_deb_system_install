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


# Clean up step
echo "Cleaning up downloaded .deb files..."
rm -f dbeaver-ce_latest_amd64.deb

echo "Clearing the APT cache..."
sudo apt-get clean

echo "Removing temporary files..."
rm -rf /tmp/some-temporary-file-or-directory