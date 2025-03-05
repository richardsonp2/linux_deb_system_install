#!/bin/bash
echo "***** Installing latest Python 3 and common Python tools *****"

sudo apt update
sudo apt install -y \
  python3 \
  python3-pip \
  python3-venv \
  python3-dev \
  build-essential \
  python3-wheel \
  python3-setuptools \
  python-is-python3 \
  pipx

# Optional: scientific/data packages
sudo apt install -y \
  python3-numpy \
  python3-scipy \
  python3-pandas \
  python3-matplotlib

echo "***** Python installation complete *****"