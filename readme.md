# Automated Software Installation Pipeline for Debian-Based Systems

This script automates the installation of essential and optional software packages on Debian-based systems, including Pop!_OS. It's designed to streamline the setup process, whether you're configuring a work environment or a general-use system.

---

## Table of Contents

1. [Features](#features)
2. [Prerequisites](#prerequisites)
3. [Usage](#usage)
4. [Customizations](#customizations)
5. [Logging](#logging)
6. [Software Installed](#software-installed)
7. [Troubleshooting](#troubleshooting)

---

## Features

- Automates the installation of commonly used software tools, including:
  - Development tools (`git`, `curl`, `wget`, Python, VS Code)
  - Scientific applications (R, RStudio, LaTeX, Inkscape, ImageJ)
  - Optional gaming and general-use software (Steam, Unity Hub, VLC)
- Configures Visual Studio Code with predefined extensions.
- Supports a `--work-system` flag to exclude non-work-related software.
- Generates timestamped logs for debugging and installation tracking.
- Handles dependencies automatically and performs cleanup post-installation.
- Allows easy customization via configuration files or script parameters.

---

## Prerequisites

Ensure the following before running the script:

- A Debian-based operating system (e.g., Ubuntu, Pop!_OS).
- Administrative privileges (`sudo` access).
- An active internet connection for package downloads.

---

## Usage

### Clone and Run

1. Clone or download the repository containing the script.
2. Make the script executable:

```bash
chmod +x install_pipeline.sh
```

Run the script with optional parameters:

```bash
./install_pipeline.sh [options]
```

### Command-Line Options

`--work-system`: Skip non-work-related software installations like Steam, Unity Hub, and Lutris. Example:

```bash
./install_pipeline.sh --work-system
```

### Customizations

#### R Packages

Add R package names to the r_packages.txt file, one package per line. The script will install these during the R setup.

#### Visual Studio Code Extensions

Modify the extensions array in the script to include or exclude specific extensions.

### Logging

All installation outputs and errors are logged to a timestamped directory:

output_logs_YYYY-MM-DD_HH-MM

Logs include details for each software installation step, helping with troubleshooting and system audit.

### Software Installed

#### Essential Packages

Development Tools:
    - git, curl, wget
    - Python (python3, python3-venv, python3-pip)
    - Visual Studio Code (with extensions)
Scientific Tools:
    R and RStudio
    LaTeX (texlive-full)
    Inkscape
    ImageJ (Fiji)
    Zotero with LibreOffice integration

#### Optional Packages (when --work-system is not specified)

- Gaming and Entertainment:
      - Steam
      - Unity Hub
      - Lutris
      - VLC
- Miscellaneous:
      - Blender
      - cmatrix (for fun)

#### Troubleshooting

Missing Dependencies: If a package installation fails due to missing dependencies, rerun the script. The script attempts to resolve dependencies automatically using:

```bash
sudo apt-get install -f -y
```

Logs: Check the output_logs_YYYY-MM-DD_HH-MM folder for details about errors or failed steps.

### License

This project is licensed under the MIT License. See the LICENSE file for more details.
