#!/bin/bash

##### NOTE #####
# Dotfiles are controlled via a seperate repo: https://github.com/richardsonp2/dotfiles


# Define variables for optional installations
work_system=true  # default is true, does not install packages such as steam for games

# Generate an output folder for error and output logs, add the date and time to the folder name 
output_folder="output_logs_$(date +'%Y-%m-%d_%H-%M')"
mkdir -p "$output_folder"

# Parse command-line arguments
for arg in "$@"; do
  case $arg in
    --work-system)
      work_system=true
      shift
      ;;
    *)
      ;;
  esac
done


#Update and upgrade the system
sudo apt update && sudo apt upgrade -y 2>&1 | tee "$output_folder/update_upgrade.log"

# Install common software
sudo apt install -y git curl wget

# Run Python install
./install_python.sh

## VS Code installation
# Install Visual Studio Code
echo "***** Installing Visual Studio Code *****"
sudo apt install -y software-properties-common apt-transport-https wget
wget -q https://packages.microsoft.com/keys/microsoft.asc -O- | sudo apt-key add -
sudo add-apt-repository -y "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main"
sudo apt update
sudo apt install -y code

# List of VSCode extensions to install
extensions=(
  esbenp.prettier-vscode
  ms-vscode.cmake-tools
  ecmel.vscode-html-css
  James-Yu.latex-workshop
  davidanson.vscode-markdownlint
  github.copilot
  github.copilot-chat
  ms-python.debugpy
  ms-python.python
  ms-python.vscode-pylance
  ms-toolsai.datawrangler
  ms-toolsai.jupyter
  ms-toolsai.jupyter-keymap
  ms-toolsai.jupyter-renderers
  ms-toolsai.vscode-jupyter-cell-tags
  ms-toolsai.vscode-jupyter-slideshow
  yzhang.markdown-all-in-one
)

for extension in "${extensions[@]}"; do
  echo "Installing $extension **** "
  code --install-extension "$extension"
done
echo "***** All VSCode extensions have been installed successfully! *****"

# Install Blender
echo "**** Installing Blender ****"
sudo apt install -y blender

# Install dbeaver (for SQL management)
wget -q https://dbeaver.io/files/dbeaver-ce_latest_amd64.deb
sudo dpkg -i dbeaver-ce_latest_amd64.deb
sudo apt-get install -f -y
rm -f dbeaver-ce_latest_amd64.deb

# Install filezilla
echo "***** Installing FileZilla *****"
sudo apt install -y filezilla

# Install VLC
echo "***** Installing VLC **** "
sudo apt install -y vlc

# Install obsidian
echo "**** Installing Obsidian **** "

# Fetch the latest release info from GitHub
latest_url=$(curl -s https://api.github.com/repos/obsidianmd/obsidian-releases/releases/latest | grep "browser_download_url.*amd64.deb" | cut -d '"' -f 4)
wget "$latest_url" -O obsidian_latest.deb
# Install the package
sudo dpkg -i obsidian_latest.deb

echo "**** Obsidian installation complete! ****"

# Install virtualbox
echo "**** Installing VirtualBox **** "
sudo apt install -y virtualbox

echo "**** VirtualBox installation complete! ****"

# These things seem to be necessary for using packages in R, probably useful for other things too
echo "**** Installing packages that will be needed for R libraries  **** "
useful_r_dependencies=(
  libclang-dev
  liblapack-dev
  libblas-dev
  gfortran
  cmake
  libudunits2-dev
  libgdal-dev
  libproj-dev
  libgeos-dev
  libssl-dev
  libxml2-dev
  libcurl4-openssl-dev
  libv8-dev
  libssl1.0.0
  libssl1.0.2
  libssl1.1
  libfontconfig1-dev
  libharfbuzz-dev
  libfribidi-dev
)

sudo apt install -y "${useful_r_dependencies[@]}"

## R installation
# Install R and RStudio, keeping r-base-dev for additional development tools (package install etc)
echo "**** Installing R and RStudio **** "
sudo apt install -y r-base r-base-dev

# Install RStudio
echo "**** Installing RStudio **** "
wget -q wget -q https://download1.rstudio.org/desktop/bionic/amd64/rstudio-latest-amd64.deb -O rstudio.deb
# Suppress prompts during dpkg installation
DEBIAN_FRONTEND=noninteractive sudo dpkg -i rstudio-1.4.1717-amd64.deb
# Automatically fix dependencies without confirmation
sudo apt-get install -f -y
# Clean up the .deb file after installation
rm rstudio.deb

echo "**** R and RStudio installation complete! ****"

# Install pacakages from included text file
echo "**** Installing R packages ****"
# Read the package names from the config file
if [ -f "installed-r-packages.txt" ]; then
  while IFS= read -r package; do
    echo "Installing R package: $package"
    Rscript -e "if (!requireNamespace('$package', quietly=TRUE)) install.packages('$package')"
  done < "installed-r-packages.txt"
else
  echo "Config file 'installed-r-packages.txt' not found."
fi

echo "**** R packages and installation complete! ****"
#R installation complete

# Install LaTeX
echo "**** Installing LaTeX **** "
sudo apt install -y texlive-full

# Install inkscape
echo "**** Installing Inkscape **** "
sudo apt install -y inkscape

# Install imageJ (Fiji)
echo "**** Installing ImageJ (Fiji) **** "
wget -q https://downloads.imagej.net/fiji/latest/fiji-linux64.zip
unzip fiji-linux64.zip -d /opt/
rm fiji-linux64.zip

## Zotero installation
# Download and install Zotero
echo "**** Installing Zotero **** "
wget -q https://www.zotero.org/download/client/dl?channel=release&platform=linux-x86_64 -O zotero.tar.bz2
tar -xjf zotero.tar.bz2 -C /opt/
sudo ln -s /opt/Zotero_linux-x86_64/zotero.desktop /usr/share/applications/zotero.desktop
rm zotero.tar.bz2

# Add Zotero to the PATH
sudo ln -s /opt/Zotero_linux-x86_64/zotero /usr/local/bin/zotero

# Install Zotero LibreOffice integration
echo "**** Installing Zotero LibreOffice integration **** "
/opt/Zotero_linux-x86_64/zotero -ZoteroInstall:extension -zoteroOpenURL="http://www.zotero.org/" libreofficeIntegration

# Start and stop LibreOffice to initialize Zotero menu integration
libreoffice --writer &
sleep 5
pkill libreoffice

echo "Zotero installation and LibreOffice integration complete!"

# Conditionally install software based on work_system flag
if [ "$work_system" = false ]; then
  echo "**** Installing entertainment and non-work-related software **** "


  # Install Unity Hub
  echo "Installing Unity Hub **** "

  # Add the public signing key
  wget -qO - https://hub.unity3d.com/linux/keys/public | gpg --dearmor | sudo tee /usr/share/keyrings/Unity_Technologies_ApS.gpg > /dev/null

  # Add the Unity Hub repository
  sudo sh -c 'echo "deb [signed-by=/usr/share/keyrings/Unity_Technologies_ApS.gpg] https://hub.unity3d.com/linux/repos/deb stable main" > /etc/apt/sources.list.d/unityhub.list'

  # Update the package cache and install Unity Hub
  sudo apt-get install -y unityhub


  # Install Steam
  echo "**** Installing Steam **** "
  sudo apt install -y steam

  # Install Lutris
  echo "**** Installing Lutris **** "
  sudo add-apt-repository ppa:lutris-team/lutris

  # Install cmatrix
  echo "**** Installing cmatrix **** "
  sudo apt install -y cmatrix
  echo "He's beginning to believe **** "


fi



# Clean up step

echo " **** Clearing the APT cache **** "
sudo apt-get clean

echo " **** Removing temporary files  **** "
rm -rf /tmp/some-temporary-file-or-directory